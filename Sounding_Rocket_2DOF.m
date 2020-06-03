clear all
close all
clc

% REQUIRE 'polyfitn'

% TODO: angel of attack variable with mach number -> lookup table again

% Global constants
% global cw ca A K mpunkt_quer Thrust tc alpha r0
global C_L C_D A mu_E alpha r_E Thrust md t_burn qd r_n rho_SL r_atm m0

% Constant
rho_SL = 1.225;
g = 9.81;
mu_E = 3.9860044e14;
r_E = 6371000;
h_atm = 120e+03;
r_atm = r_E + h_atm;
C_L = 0.2;
C_D = 0.2;
alpha = -10;

% SpaceCraft data
m0 = 3000;          % kg
SI = 3300;          % m/s
Thrust = 1600;      % N
D = 2.17;          % Diametre of the capsule
A = D^2 * pi / 4;   % Area (section for the lift and drag mostly)
% m_mo = 1100;        % [kg] mass of the obital module
% m_fuel = 700;       % [kg]
% m_f = m0 - m_mo - m_fuel;   % mass after the burn
% deltav = SI * log(m0 / m_f);
% md = Thrust / SI;
% t_burn = m_fuel / md;    % [s]
% r_n = D/2;          % radis of the nose

a_parachute1 = 11.0;
a_parachute2 = 51.0;

% Mission Parameters
g_max = 5 * g;
h_apoapsis = 425.6 * 1000;
h_periapsis = 75e+03;
r_apoapsis = h_apoapsis + r_E; % Starting altitude
r_periapsis = h_periapsis + r_E;

r_start = r_atm;

% Orbital 
e = (r_apoapsis - r_periapsis) / (r_apoapsis + r_periapsis);
a = (r_apoapsis + r_periapsis) / 2;
theta = acos((a * (1 - e^2) - r_start) / (r_start * e));
gamma0 = atan((e * sin(theta)) / (1 + e * cos(theta)));     % something around 1.35deg

v0 = sqrt(((2*mu_E)/r_start)-(mu_E/a));


[T,Y] = ode15s(@Rocket_2DOF, [0:0.01:2000], [v0 gamma0 r_start 0 m0]);

% qd = heat_flux(Y(:,1), Y(:,3));

% Calculate accelerations as derivatives from velocities
    deltav = diff(Y(:, 1));
    deltat = diff(T);
    lt = length(T)
    
    for j=1 : lt-1
        acc(j) = deltav(j) / deltat(j);
%         VecQ = cumtrapz(qd);
    end
    acc(lt) = acc(lt - 1);
    if length (acc) > lt
        la = length(acc);
        acc(lt + 1:la) = [];
%         VecQ(lt + 1:la) = [];
    end
% plot results   
figure(1)
plot (T, acc/g, 'b-')
ylabel ('Acceleration [g]')
xlabel ('Time [s]')
figure(2)
plot (T, Y(:, 1), 'r-')
ylabel ('Velocity [m/s]')
xlabel ('Time [s]')
figure(3)
plot (T, Y(:, 2) * 180 / pi, 'b-')
ylabel ('gamma [\gamma]')
xlabel ('Time [s]')
figure(4)
plot (T, Y(:, 3)-r_E)
ylabel ('Altitude [m]')
xlabel ('Time [s]')
figure(5)
plot (T, Y(:, 4))
ylabel ('phi [\phi]')
xlabel ('Time [s]')
figure(6)
plot (T, Y(:, 5))
ylabel ('mass [kg]')
xlabel ('Time [s]')
% subplot(4, 2, 7)
% plot (T, qd(:))
% ylabel ('Heat Flux')
% xlabel ('Time [s]')
% subplot(4,2,8)
% plot (T, VecQ)
% ylabel ('Cumulated heat flux Heat Flux')
% xlabel ('Time [s]')
