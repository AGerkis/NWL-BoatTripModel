% Carolina_Skiff_25DVL_2009
% Note: Modified Vee Hull
% Aidan Gerkis
% 2020-11-12

Boat = BoatModel;

% Known values
Boat.mb = 917.6; % Boat mass (kg)
Boat.maxload = 1814.4; % Max Boat Capacity (kg)
Boat.l = 7.57; % Boat length (m)
Boat.b = 2.44; % Beam length (m)
Boat.beta = 10; % Deadrise Angle (degrees)

% Estimated Parameters
Boat.vplane = 1.3*sqrt(Boat.l); % The velocity at which the boat starts to hydroplane (m/s)