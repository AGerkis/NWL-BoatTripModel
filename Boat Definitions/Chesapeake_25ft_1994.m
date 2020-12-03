% Chesapeake_25ft_1994
% Note: Modified Vee Hull
% Aidan Gerkis
% 2020-11-12

Boat = BoatModel;

% Known values
Boat.mb = 2041.2; % Boat mass (kg)
Boat.l = 7.52; % Boat length (m)
Boat.b = 2.82; % Beam length (m)
Boat.beta = 14; % Deadrise Angle (degrees)
Boat.maxdraft = 0.33; % Max draft (m)

% Estimated Parameters
Boat.vplane = 1.3*sqrt(Boat.l); % The velocity at which the boat starts to hydroplane (m/s)
Boat.Cd = 0.5; % Coefficient of Drag