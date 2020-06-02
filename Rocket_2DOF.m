function dy = Rocket_2DOF(t,y)

% global cw ca A mu_E mpunmu_Et_quer Thrust tc alpha r_E
global C_L C_D A mu_E alpha r_E Thrust md t_burn qd

% Thrust switched on as long as burning time of engine
% if t > t_burn
    Thrust = 0;
    md = 0;   
% end
% Atmospheric data at r from ISA atmosphere model (Aerospace Toolbox)
% w = flow_velocity(y(1), y(2));
w = y(1);
y(3);
[T ,a ,P ,rho] = atmosisa(y(3)-r_E);

if y(3)-r_E > 120000
    P = 0;
    rho = 0;
end

% Initial lift and drag coeff and mach speed for the sapcecraft
mach = y(1) / a; 

if mach > 2
    C_D = 0.2;
else
    C_D = sqrt(cx_inter(alpha, mach)^2 + cz_inter(alpha, mach)^2);
end
% drag, im not sure of the formula though
C_L = lift_drag(alpha, mach) * C_D;  % lift coeff from L/D ratio
D = 0.5 * rho * w * w * A * C_D;
L = 0.5 * rho * w * w * A * C_L;


% Set Matrix of results to zero
dy = zeros(5,1);
% Calculate derivatives of velocity, radius and ground angle for alitudes
% above ground
alpha_rad = deg2rad(alpha);

if y(3) >= r_E
    dy(1) = (-Thrust * cos(alpha_rad) - D) / y(5) + mu_E / (y(3) * y(3)) ...
        * sin(y(2));
    dy(2) = (-Thrust * sin(alpha_rad) - L) / (y(5) * y(1)) + (mu_E ...
        / (y(3) * y(3) * y(1)) - y(1) / y(3)) * cos(y(2));
    dy(3) = -y(1) * sin(y(2));
    dy(4) = y(1) / y(3) * cos(y(2));
    dy(5) = -md;
else
    dy(1) = 0;
    dy(2) = 0;
    dy(3) = 0;
    dy(4) = 0;
    dy(5) = 0;
end
% Calculate derivative of mass   

% Calculate derivative of flight path angles for altitudes above ramp
% length
end



