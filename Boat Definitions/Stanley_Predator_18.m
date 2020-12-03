% Stanley_Predator_18
% Note: Modified Vee Hull
% Aidan Gerkis
% 2020-11-12

Boat = BoatModel;

% Known values
Boat.mb = 589.7; % Boat mass (kg)
Boat.l = 5.49; % Boat length (m)
Boat.b = 2.03; % Beam length (m)
Boat.h = 0.61; % Boat height (m)
Boat.beta = 7; % Deadrise Angle (degrees)

% Estimated Parameters
Boat.vplane = 1.3*sqrt(Boat.l); % The velocity at which the boat starts to hydroplane (m/s)
Boat.Cd = 0.5; % Coefficient of Drag