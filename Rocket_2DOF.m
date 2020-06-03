function dy = Rocket_2DOF(t,y)

% global cw ca A mu_E mpunmu_Et_quer Thrust tc alpha r_E
global C_L C_D A mu_E alpha r_E Thrust md t_burn r_atm r_n m0

Thrust_ = 0;
md_ = 0;

% w the flow stream is the same as y(1) if we keep the alpha at zero
% we shall consider it the same as alse the computation for L and D 
% are much difficult as the section of the ship with respect to alpha is
% needed
w = y(1);

[T ,a ,P ,rho] = atmosisa(y(3)-r_E);

% Initial lift and drag coeff and mach speed for the sapcecraft
mach = y(1) / a;

%Parachute Conditions

if mach > 0
    C_D = 0.4;
else
    C_D = sqrt(cx_inter(alpha, mach)^2 + cz_inter(alpha, mach)^2);
end

% need to do the following:
% http://www.russianspaceweb.com/soyuz-landing.html
% Starting altitude h = 422.0 km


h = (y(3))
A_drogue = 24;    % m^2
A_main = 1000;
C_D_drogue = 0.874; %see arc or 0.59 
C_D_main = 1.5;    %see nasa
mass_heat_shield = 100;     % need to be changed with the q
mass_drogue = 20;

C_L = lift_drag(alpha, mach) * C_D;  % lift coeff from L/D ratio
D = 0.5 * rho * w * w * A * C_D;
L = 0.5 * rho * w * w * A * C_L;

if h <= 9500 && h >= 8500
    % omitting the two parachute that pull out the drogue parachute
    D_drogue = 0.5 * rho * w * w * A_drogue * C_D_drogue;
    D = D + D_drogue;
elseif h <= 8500 && y(1) <= 80
%     open main parachute % area of 1000m2
    if y(5) == m0
        y(5) = y(5) - mass_drogue
    end
    D_main = 0.5 * rho * w * w * A_main * C_D_main;
    D = D + D_main;
end
    
if h <= 5500 && y(5) == m0 - mass_drogue
    y(5) = y(5) - mass_heat_shield;
end

% Set Matrix of results to zero
dy = zeros(5,1);
% Calculate derivatives of velocity, radius and ground angle for alitudes
% above ground
alpha_rad = deg2rad(alpha);

if y(3) > r_E
    dy(1) = (-Thrust_ * cos(alpha_rad) - D) / y(5) + mu_E / (y(3) * y(3)) ...
        * sin(y(2));
%     dy(2) = (-Thrust_ * sin(alpha_rad) - L) / (y(5) * y(1)) + (mu_E ...
%         / (y(3) * y(3) * y(1)) - y(1) / y(3)) * cos(y(2));
    dy(3) = -y(1) * sin(y(2));
    dy(4) = y(1) / y(3) * cos(y(2));
    dy(5) = -md_;
else
    dy(1) = 0;
    dy(2) = 0;
    dy(3) = 0;
    dy(4) = 0;
    dy(5) = 0;
end

if h <= 10
    alpha = 0;
    y(2) = pi;
    dy(2)=0.;
    acc=dy(1);
else
    dy(2) = (-Thrust_ * sin(alpha_rad) - L) / (y(5) * y(1)) + (mu_E ...
         / (y(3) * y(3) * y(1)) - y(1) / y(3)) * cos(y(2));
end
% Calculate derivative of mass   
% if (y(3)-r_E)<=10
%     dy(2)=0.;
%     acc=dy(1);
% else
%     dy(2) = (-Thrust_ * sin(alpha_rad) - L) / (y(5) * y(1)) + (mu_E ...
%          / (y(3) * y(3) * y(1)) - y(1) / y(3)) * cos(y(2));
% end

% Calculate derivative of flight path angles for altitudes below the
% parachute deployment
% if (y(3) - r_E) <= 5.2
%     dy(2) = 0;
% else
%      dy(2) = (-Thrust_ * sin(alpha_rad) - L) / (y(5) * y(1)) + (mu_E ...
%         / (y(3) * y(3) * y(1)) - y(1) / y(3)) * cos(y(2));
end
