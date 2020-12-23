% Boat_Definition_Template
% Aidan Gerkis
% 2020-10-08

Boat = BoatModel;

% Known values
Boat.mb = 200; % Boat mass (kg)
Boat.l = 5; % Boat length (m)
Boat.b = 3; % Beam length (m)
Boat.beta = 10; % Deadrise Angle (degrees)

% Estimated Parameters
Boat.vplane = 1.3*sqrt(Boat.l); % The velocity at which the boat starts to hydroplane (m/s)