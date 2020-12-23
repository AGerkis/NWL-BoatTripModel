% NWL Boat Trip Model
% Aidan Gerkis
% 2020-11-02

clc; clear;

Boat_Definition_Template;
Motor_Definition_Template;
% Yamaha_F70;
% Yamaha_F75;
% Evinrude_135;

% Physical Constants
roh = 999; % Density of Water (kg/m^3)
g = 9.81; % Gravitational Constant (m/s^2)
kv = 1.004e-6; % Kinematic Viscosity of Water at 20 degrees Celsius (m^2/s)
hpToWatt = 735.5; % Conversion of horsepower to watts (1 hp = 735.5)

% Declare needed symbolic variables
syms clo;

% Model Parameters
d = 9.9; % Approximate distance from landing to NW (km)
% d = 28.4; % Approximate distance from landing to L (km)
% d = 23.4; % Approximate distance from NW to L (km)
ml = 50; % Mass of the load the boat is carrying (kg)
accel = []; % Acceleration map
n = size(accel); % Variable storing the length of accel, controls # of iterations
w = zeroes(n); % An array to store the required work for each time step
v = 0; % Boat velocity, assume we start from a standstill
planing = 0; % A binary variable, indicating when the boat is planing
delt = 1; % The time between iterations (s)
tau = 0; % Trim Angle
lambda = 0; % Mean Wetted Beam Length

Fb = (Boat.mb + ml + Motor.mm)*g; % The bouyant force (N)
Vdisp = Fb/(roh*g); % The volume of water displaced (m^3)
z = Vdisp/(Boat.l*Boat.b); % How much of the boat is submerged (m)
Astatic = z*w; % The static submerged frontal area 7(m^2)
d = z; % Submerged transom depth, assumed to be constant (m)

i = 1; % Tracks loop iterations

% Note: Assumes it can always apply the required force (need to check this)
while planing == 0
    v = v + accel(i)*delt; % Calculate the new velocity
    
    if v > Boat.vplane
        planing = 1;
    else
        R = Boat.l*v/kv; % Reynolds number (unitless)
        Cf = 0.075/((log10(R) - 2)^2); % Schoenherr Turbulent Friction Coefficient, calculated from ITTC 1957 standards (unitless)
        Fd = 0.5*roh*A*Boat.Cf*v^2;
        dprime = v*delt;
        w(i) = Fd*dprime;
        
        Preq = Fd*v; % Compute required power for given acceleration (W)
        
        % Verifies that the requested acceleration is possible by comparing
        % required power to maximum motor horsepower. Exits the script if
        % the required power exceeds maximum motor horsepower.
        if Preq/hpToWatt > Motor.maxHP
          disp('Model Failed. Maximum motor horsepower exceeded. Please input another acceleration map.');
          disp('The current acceleration is:');
          disp(accel(i));
          quit(0);
        end
    end
        
    i = i +1;
end

if planing == 1
    j = i; % Prep for the re-assignment in the next line
    
    % TODO: Check that units make sense
    for i = j:n
        v = v + accel(i)*delt; % Update Velocity
        
        % Update planing parameters
        Clb = Fb/(0.5*roh*(v^2)*(Boat.b)^2);
        Cv = v/sqrt(g*Boat.b);
        
        cloeqn = 0 == clo - 0.0065*beta*clo^0.6 - Clb; % Define an equation for Clo
        Clo = vpasolve(cloeqn, clo); % Numerically solve for Clo
        
        tl0 = [3; Boat.l/Boat.b]; % Starting point for fsolve
        tlsols = fsolve(@taulambda, tl0);
        tau = tlsols(1);
        lambda = tlsols(2);
        
        v1 = v*sqrt(1 - Clb/(lambda*cos(tau))); % Compute average bottom velocity (m/s)
        R = Boat.l*v/kv; % Reynolds number (unitless)
        Cf = 0.075/((log10(R) - 2)^2); % Schoenherr Turbulent Friction Coefficient, calculated from ITTC 1957 standards (unitless)
        
        % Compute Forces
        Df = ((Cf+ Fb*Cf)*roh*(v1^2)*lambda*(Boat.b)^2)/(2*cosd(Boat.beta)); % Drag resulting from friction (N)
        Dp = Fb*tand(tau); % Drag resutling from pressure (N)
        Fd = Dp + Df; % Total drag (N)
        dprime = v*delt; % Compute distance travelled
        w(i) = Fd*dprime; % Compute work required, assign to array index
    end
end

T = (Motor.pme*Motor.Vd)/(2*pi*Motor.nr); % Calculate torque output from motor (Nm)
rpm = zeroes(n); % Instantiate array of motor rpm for each time interval

% Compute motor rpm at each time step
for i = 1:n
    rpm(i) = w(i)/(T*delt/60);
end

% TODO: Calculate fuel usage from motor data
% TODO: Build motor models
% TODO: Make some plots to make sure values make sense
% TODO: Vary loads and plot fuel consumption
% TODO: Determine which sensitivities we are interested in, calculate, plot

% Defines the system of equations relating tau and lambda
% tau = tl(1)
% lambda = tl(2)
function F = taulambda(tl)
    F = [(tl(1)^1.1)*(0.012*sqrt(tl(2)) + (0.0055*(tl(2)^2.5))/(Cv^2)) - Clo;
        (1/Boat.b)*(d/sind(tl(1)) - (b/(2*pi))*(tand(beta)/tand(tl(1)))) - tl(2)];
end