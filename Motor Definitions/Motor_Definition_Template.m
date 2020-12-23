% Yamaha F70
% Aidan Gerkis
% 2020-10-20

Motor = MotorModel;

% Known values
Motor.maxHP = 0; % Maximum Motor (HP)
Motor.mm = 0; % Mass of the motor (kg)
Motor.rpmAtMax = 0; % Motor RPM at max HP (rpm)
Motor.Vd = 0; % Displacement volume of engine
Motor.pme = 0; % Effective motor pressure
Motor.nr = 0; % Motor constant, varies with # of cylinders

% Estimated Power Curve
Motor.RPM = [0 0 0 0 0 0 0 0 0 0 0 0]; %  The x-axis for the power curve (rpm)
Motor.HP; % The y-axis for the power curve (HP)
Motor.MPG; % The y-axis for the power curve (MPG)