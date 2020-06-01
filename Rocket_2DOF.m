function dy = Rocket_2DOF(t,y)

global cw ca A K mpunkt_quer F_quer tc alpha lrampe r0

% Thrust switched on as long as burning time of engine
if t <= tc
    F = F_quer;
    mp = mpunkt_quer;
else
    F = 0;
    mp = 0;
end
% Atmospheric data at r from ISA atmosphere model (Aerospace Toolbox) 
[T ,a ,P ,rho] = atmosisa(y(2)-r0);
% Set Matrix of results to zero
dy = zeros(5,1);
% Calculate derivatives of velocity, radius and ground angle for alitudes
% above ground
if y(2) >= r0
    % Velocity
    dy(1) = (F * cos(alpha) - rho * cw * A / 2 * y(1) * y(1)) / y(3) - K / y(2) / y(2) * sin(y(4));
    % Absolute altitude (from the center of the Earth)
    % add a minus sign to correspond to the pdf, and also we are going down
    dy(2) = -y(1) * sin(y(4));
    % Angle phi
    dy(5) = y(1) / y(2) * cos(y(4));
else
    dy(1) = 0;
    dy(2) = 0;
    dy(5) = 0;
end
% Calculate derivative of mass   
dy(3) = -mp;
% Calculate derivative of flight path angles for altitudes above ramp
% length
if (y(2)-r0) <= lrampe
    % Angle gamma
    dy(4) = 0.0;
    acc = dy(1);
else
    dy(4) = (F * sin(alpha) + rho * ca * A / 2 * y(1) * y(1)) / y(3) / y(1) - (K / y(2) / y(2) / y(1) - y(1) / y(2)) * cos(y(4));
end



