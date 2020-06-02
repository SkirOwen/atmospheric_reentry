function cx = cx_inter(alpha, mach)

alpha_x =[-30 -25 -20 -15 -10 -5 0];
mach_y =[0.6 0.95 1.10 1.78 2.52 5.96];

cx_values = [
    0.885, 0.920, 0.960, 0.975, 0.997, 1, 1.05;
    1.150, 1.180, 1.205, 1.230, 1.255, 1.268, 1.270;
    1.250, 1.297, 1.340, 1.365, 1.395, 1.397, 1.400;
    1.285, 1.370, 1.420, 1.460, 1.490, 1.520, 1.520;
    1.310, 1.380, 1.420, 1.460, 1.480, 1.520, 1.540;
    1.180, 1.280, 1.380, 1.440, 1.515, 1.530, 1.560
    ];
% l_ratio = interp2(alpha_x, mach_y, LD_values, alpha, mach, 'spline');

% [x, y] = meshgrid(alpha_x, mach_y);

% p = polyfitn([x(:), y(:)], cx_values(:), 5);
% cx = polyvaln(p, [alpha, mach]);
cx = griddata(alpha_x, mach_y, cx_values, alpha, mach, 'v4');
end