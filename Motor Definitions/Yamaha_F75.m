% Yamaha F75
% Aidan Gerkis
% 2020-10-20

Motor = MotorModel;

% Known values
Motor.maxHP = 75; % Maximum Motor (HP)
Motor.mm = 160; % Mass of the motor (kg)
Motor.rpmAtMax = 5500; % Motor RPM at max HP (rpm)

% Estimated Power Curve
Motor.RPM = [1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6100]; %  The x-axis for the power curve (rpm)
Motor.MPG = [8.5 7.14 5.64 3.74 2.67 3.81 5.62 5.47 5.18 4.51 4.31]; % The y-axis for the power curve (MPG)