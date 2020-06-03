alpha_x =[-30 -25 -20 -15 -10 -5 0];
mach_y =[0.6 0.95 1.10 1.78 2.52 5.96];

[alpha, mach] = meshgrid(alpha_x, mach_y);
[X,Y] =  meshgrid(alpha_x, mach_y);
Z1 = interp2([X(:), Y(:)]);

cz_values = [
    0.025, 0.045, 0.052, 0.053, 0.052, 0.025, 0;
    -0.130, -0.075, -0.001, 0.015, 0.04, 0.025, 0;
    -0.140, -0.08, -0.045, 0, 0.035, 0.025, 0;
    -0.355, -0.255, -0.16, -0.08, -0.01, 0.025, 0;
    -0.32, -0.24, -0.17, -0.14, -0.08, -0.04, 0;
    -0.25, -0.18,  -0.13, -0.095, -0.06, -0.035, 0
    ];

cz = griddata(alpha_x, mach_y, cz_values ,alpha,mach, 'v4');

cx_values = [
    0.885, 0.920, 0.960, 0.975, 0.997, 1, 1.05;
    1.150, 1.180, 1.205, 1.230, 1.255, 1.268, 1.270;
    1.250, 1.297, 1.340, 1.365, 1.395, 1.397, 1.400;
    1.285, 1.370, 1.420, 1.460, 1.490, 1.520, 1.520;
    1.310, 1.380, 1.420, 1.460, 1.480, 1.520, 1.540;
    1.180, 1.280, 1.380, 1.440, 1.515, 1.530, 1.560
    ];
cx = griddata(alpha_x, mach_y, cx_values ,alpha,mach, 'v4');

LD_values = [
    0.610,0.530,0.450,0.350,0.250,0.120,0;
    0.425,0.390,0.350,0.280,0.210,0.110,0;
    0.450,0.390,0.335,0.260,0.200,0.110,0;
    0.260,0.260,0.250,0.210,0.170,0.110,0;
    0.295,0.270,0.230,0.180,0.120,0.0650,0;
    0.320,0.300,0.260,0.200,0.130,0.0650,0
    ];
ld_ratio = griddata(alpha_x, mach_y, LD_values ,alpha,mach, 'v4');


tiledlayout(3,1);

nexttile
plot3(alpha,mach,cz)
xlabel('Alpha')
ylabel('Mach')
zlabel('cz')
% hold on
% mesh(alpha,mach,cz)
% hold on
% surf(alpha,mach,cz)
title('Interpolation of Drag')

nexttile
plot3(alpha,mach,cx)
xlabel('Alpha')
ylabel('Mach')
zlabel('cx')
% hold on
% mesh(alpha,mach,cx)
% hold on
% surf(alpha,mach,cx)
title('Interpolation of Lift')


nexttile
plot3(alpha,mach,ld_ratio)
xlabel('Alpha')
ylabel('Mach')
zlabel('ld_ratio')
% hold on
% mesh(alpha,mach,ld_ratio)
% hold on
% surf(alpha,mach,ld_ratio)
title('Interpolation of Lift/Drag Ratio')





