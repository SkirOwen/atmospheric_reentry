clear all
close all
clc

% Global constants
global cw ca A K mpunkt_quer F_quer tc alpha lrampe r0

% We need to change the following values, it was a bit obvious looking at
% it though :')

% Basic Design Data of Rocket
m1 = 2.0
m0 = 80         % initial mass in kg
cw = 0.4        % lift coeff -> to move to the function if alpha variable
ca = 0.0        % drag coeff -> idem
alpha = 0.0     % Angle alpha
lrampe = 10.0   % No idea for now -> some kind of altitude in metre 
D = 0.2         % Diametre of the capsule
A = D^2 * pi / 4    % Area (section for the lift and drag mostly)
r = 425600      % added initial altitude in m (here ISS) -> bug if r <=10 m

% Genereric Constants
r0 = 6371000    % Radius of the Earth (orbiting body)
rho = 1.225     % rho at sea level, though WolframAlpha says it's 1.226
K = 3.9658e14   % Seems to be mu from 'Guided_work_2.pdf' where to find?
% maybe the geocentric gravitational constant?? but I only find the value
% of 3.9860044e14 m^3/s^2 on the Internet
g0 = 9.81       % maybe we need to change this but i dont reckon we need
                % since we stay pretty close to Earth

% Motor Data
m8 = 26.0
Is = 1700.0
tc = 15.0       % burn time of the engine in second
mpunkt_quer = m8 / tc   % apparently mass total or the one for the derivative
Itot = m8 * Is
F_quer = Itot / tc

% Calculated Rocket Data
mc = m0 - m8
R = m0 / mc
H = r + r0

% Numerical solution
% gamma initial is 80 degre, do we need to change it?
gamma = 80 * pi / 180

                            % t0 t_end  v H m0 gamma phi
[T,Y] = ode15s(@Rocket_2DOF, [0 1000], [0 H m0 gamma 0]);
% Y vertical vector as: [velocity, H, m, gamma, phi]

% Calculate accelerations as derivatives from velocities
    deltav = diff(Y(:, 1));
    deltat = diff(T);
    lt = length(T)
    for j=1 : lt-1
        acc(j) = deltav(j) / deltat(j);
    end
    acc(lt) = acc(lt - 1)
    if length (acc) > lt
        la = length(acc);
        acc(lt + 1:la) = [];
    end
% plot results   
subplot(3,2,1)
plot (T, acc, 'b-')
ylabel ('Acceleration [m/s^2]')
xlabel ('Time [s]')
subplot(3, 2, 2)
plot (T, Y(:, 1), 'r-')
ylabel ('Velocity [m/s]')
xlabel ('Time [s]')
subplot(3, 2, 3)
plot (T, Y(:, 2)-r0, 'b-')
ylabel ('Altitude [m]')
xlabel ('Time [s]')
subplot(3, 2, 4)
plot (T, Y(:, 3))
ylabel ('Mass [kg]')
xlabel ('Time [s]')
subplot(3, 2, 5)
plot (T, Y(:, 4) * 180 / pi)
ylabel ('gamma [\gamma]')
xlabel ('Time [s]')
