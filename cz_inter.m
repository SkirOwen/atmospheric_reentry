function cz = cz_inter(alpha, mach)


alpha_x =[-30; -25; -20; -15; -10; -5; 0];
mach_y =[0.6 0.95 1.10 1.78 2.52 5.96];

cz_values = [
    0.025, 0.045, 0.052, 0.053, 0.052, 0.025, 0;
    -0.130, -0.075, -0.001, 0.015, 0.04, 0.025, 0;
    -0.140, -0.08, -0.045, 0, 0.035, 0.025, 0;
    -0.355, -0.255, -0.16, -0.08, -0.01, 0.025, 0;
    -0.32, -0.24, -0.17, -0.14, -0.08, -0.04, 0;
    -0.25, -0.18,  -0.13, -0.095, -0.06, -0.035, 0
    ];

% [x, y] = meshgrid(alpha_x, mach_y);
% 
% p = polyfitn([x(:), y(:)], cz_values(:), 5);
% cz = polyvaln(p, [alpha, mach]);
cz = griddata(alpha_x, mach_y, cz_values, alpha, mach, 'v4');
% Cz = polyfitweighted2(alpha_x, mach_y, cx_values ,3,[1 1 1 1 1 1; 
%                                           1 1 1 1 1 1;
%                                           1 1 1 1 1 1;
%                                           1 1 1 1 1 1;
%                                           1 1 1 1 1 1;
%                                           1 1 1 1 1 1;]);
% cz = polyval2(Cz, alpha, mach);
end

