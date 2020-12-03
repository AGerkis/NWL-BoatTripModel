% Yamaha F75
% Aidan Gerkis
% 2020-10-20

Motor = MotorModel;

% Known values
Motor.maxHP = 75; % Maximum Motor (HP)
Motor.mm = 160; % Mass of the motor (kg)
Motor.rpmAtMax = 5500; % Motor RPM at max HP (rpm)

% Estimated Power Curve
Motor.RPM = [1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6300]; %  The x-axis for the power curve (rpm)
Motor.MPG = []; % The y-axis for the power curve (MPG)