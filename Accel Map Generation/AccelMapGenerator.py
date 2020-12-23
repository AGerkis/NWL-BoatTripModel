# -*- coding: utf-8 -*-
"""
Created on Mon Dec 21 14:59:26 2020

@author: aidan
"""
# Define functions
# A function that returns the slope of a piecewise function at a given time
def get_slope(time, pcwiseFunc):
    for r in range(len(pcwiseFunc) - 1): # Loop through each interval of th piecewise function
        if (time < pcwiseFunc[r][1]): # Return slope if the given time lies in the current interval
            return pcwiseFunc[r][0]
    
    return pcwiseFunc[len(pcwiseFunc) - 1][0] # Adds the slope of the last interval otherwise
        
# Introductory Text
print("NWL Boat Model Acceleration Map Generator")
print("")
print("This generator takes an input in one of 4 formats and generates an acceleration map in CSV format")
print("All 4 formats require the user to input the distance travelled and the desired interval for each time step.")
print("Their are 4 accepted formats to describe the desired acceleration, they are:")
print("(1) Input a target velocity, and the time (starting from 0) at which that velocity should be reached.")
print("(2) Input the desired acceleration as a piecewise function of time.")
print("(3) Input the jolt (time derivative of acceleration) as a piecewise function.")
print("(4) Input the snap (second time derivative of acceleration) as a piecewise function.")
print("")

# Receive name for the output file
name = input("Please enter the desired name for the output file (note that if this name is a duplicate then data may be overwritten): ")

# Receive desired input mode
mode = int(input("Please enter the desired input mode (enter '1', '2', '3', or '4'): "))
print("You selected mode (" + str(mode) + ").")
print("")

# Receive distance and time step size parameters
dist = float(input("Please enter the distance being covered in km: "))
dist = dist*1000 # Convert distance to metres
delt = float(input("Please enter the time covered by each time interval in seconds: "))

# Receive acceleration definition inputs
if mode == 1:
    velTarget = int(input("Please enter the target velocity in m/s: "))
    timeToVel = int(input("Please enter the time at which the target velocity should be reached in s: "))
elif mode == 2:
    numPieces = int(input("Please enter the number of intervals in your function: "))
    
    # Initialize an aray of numPieces arrays of 2
    ind1, ind2 = 2, numPieces
    accelFunc = [[0 for x in range(ind1)] for y in range(ind2)]
    
    print("Enter the following in order of increasing time.")
    
    # Populate array with piecewise function
    for i in range(numPieces):
        accelFunc[i][0] = float(input("Please enter the acceleration in m/s/s for interval " + str(i+1) + ": "))
        timeint = input("Please enter the time in seconds when interval " + str(i+1) + " ends (enter 'inf' if the interval goes until the destination is reached): ")
        
        if timeint == "inf":
            accelFunc[i][1] = str(timeint)
        else:
            accelFunc[i][1] = float(timeint)
elif mode == 3:
    numPieces = int(input("Please enter the number of intervals in your function: "))
    
    # Initialize an aray of numPieces arrays of 2
    ind1, ind2 = 2, numPieces
    joltFunc = [[0 for x in range(ind1)] for y in range(ind2)]
    
    print("Enter the following in order of increasing time.")
    
    # Populate array with piecewise function
    for i in range(numPieces):
        joltFunc[i][0] = float(input("Please enter the jolt in m/s/s/s for interval " + str(i+1) + ": "))
        timeint = input("Please enter the time in seconds when interval " + str(i+1) + " ends (enter 'inf' if the interval goes until the destination is reached): ")
        
        if(timeint == "inf"):
            joltFunc[i][1] = str(timeint)
        else:
            joltFunc[i][1] = float(timeint)
elif mode == 4:
    numPieces = int(input("Please enter the number of intervals in your function: "))
    
    # Initialize an aray of numPieces arrays of 2
    ind1, ind2 = 2, numPieces
    snapFunc = [[0 for x in range(ind1)] for y in range(ind2)]
    
    print("Enter the following in order of increasing time.")
    
    # Populate array with piecewise function
    for i in range(numPieces):
        snapFunc[i][0] = float(input("Please enter the snap in m/s/s/s/s for interval " + str(i+1) + ": "))
        timeint = input("Please enter the time in seconds when interval " + str(i+1) + " ends (enter 'inf' if the interval goes until the destination is reached): ")
        
        if(timeint == "inf"):
            snapFunc[i][1] = str(timeint)
        else:
            snapFunc[i][1] = float(timeint)
            
# Create a new file to store the acceleration map
csv = open(name + ".txt", "x")

# Populate acceleration map array
accelMap = [] # Initiate acceleration map list
t = 0 # Tracks current time step
distTravelled = 0 # Stores distance currently travelled in metres
v = 0 # Stores current velocity

# Populate list based on chosen input format
if mode == 1:
    accel = velTarget/timeToVel # Compute corresponding acceleration
    
    # Populate list while the input distance has not been reached
    while distTravelled <= dist:
        # Determine acceleration at current time step
        if t < timeToVel:
            curAccel = accel
        elif t >= timeToVel:
            curAccel = 0
        
        # Update velocity, distance, and time
        v += curAccel*delt
        distTravelled += v*delt
        t += delt
        
        # Add current acceleration to the map
        accelMap.append(curAccel)
elif mode == 2:
    # Populate list while the input distance has not been reached
    while distTravelled <= dist:
        # Determine acceleration at current time step
        curAccel = get_slope(t, accelFunc)
        
        # Update velocity, distance, and time
        v += curAccel*delt
        distTravelled += v*delt
        t += delt
        
        # Add current acceleration to the map
        accelMap.append(curAccel)
elif mode == 3:
    curAccel = 0 # Initialize current acceleration value
    
    # Populate list while the input distance has not been reached
    while distTravelled <= dist:
        # Determine acceleration at current time step
        curAccel += get_slope(t, joltFunc)*delt
        
        # Update velocity, distance, and time
        v += curAccel*delt
        distTravelled += v*delt
        t += delt
        
        # Add current acceleration the map
        accelMap.append(curAccel)
elif mode == 4:
    curAccel = 0 # Initialize current acceleration value
    curJerk = 0 # Initialize current jerk value
    
    # Populate list while the input distance has not been reached
    while distTravelled <= dist:
        # Determine acceleration at current time step
        curAccel += curJerk*delt + 0.5*get_slope(t, snapFunc)*delt*delt
        curJerk += get_slope(t, snapFunc)*delt
        
        # Update velocity, distance, and time
        v += curAccel*delt
        distTravelled += v*delt
        t += delt
        
        # Add current acceleration the map
        accelMap.append(curAccel)
        
for i in range(len(accelMap)):
   csv.write(str(accelMap[i]) + "\n")

csv.close()