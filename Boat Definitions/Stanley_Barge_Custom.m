% Stanley_Barge_Custom
% Note: Displacement Hull
% Aidan Gerkis
% 2020-11-12

Boat = BoatModel;

% Known values
Boat.mb = 1043.3; % Boat mass (kg)
Boat.l = 7.62; % Boat length (m)
Boat.b = 2.74; % Beam length (m)
Boat.beta = 4; % Estimated Deadrise Angle (degrees)

% Estimated Parameters
Boat.vplane = 1.3*sqrt(Boat.l); % The velocity at which the boat starts to hydroplane (m/s)
Boat.Cd = 0.5; % Coefficient of Drag