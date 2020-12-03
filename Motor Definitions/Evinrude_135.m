% Evinrude 135
% Aidan Gerkis
% 2020-10-20

Motor = MotorModel;

% Known values
Motor.maxHP = 135; % Maximum Motor (HP)
Motor.mm = 190; % Mass of the motor (kg)
Motor.rpmAtMax = 5600; % Motor RPM at max HP (rpm)

% Estimated Power Curve
Motor.RPM = [2000 2500 3000 3500 4000 4500 5000 5500 6100]; %  The x-axis for the power curve (rpm)
Motor.HP = [30 55 85 110 130 140 137 136 135]; % The y-axis for the power curve (MPG)
Motor.LPH = [5.5 10 13.5 16.7 21.5 28.6 38.1 44.5 49.9]; % The y-axis for the consumption curve, fuel usage in litres-per-hour