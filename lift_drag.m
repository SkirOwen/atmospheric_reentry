function ld_ratio = lift_drag(alpha, mach)

alpha_x =[-30; -25; -20; -15; -10; -5; 0];
mach_y =[0.6 0.95 1.10 1.78 2.52 5.96];

LD_values = [
    0.610,0.530,0.450,0.350,0.250,0.120,0;
    0.425,0.390,0.350,0.280,0.210,0.110,0;
    0.450,0.390,0.335,0.260,0.200,0.110,0;
    0.260,0.260,0.250,0.210,0.170,0.110,0;
    0.295,0.270,0.230,0.180,0.120,0.0650,0;
    0.320,0.300,0.260,0.200,0.130,0.0650,0
    ];

% [x, y] = meshgrid(alpha_x, mach_y);
% 
% p = polyfitn([x(:), y(:)], LD_values(:), 5);
% ld_ratio = polyvaln(p, [alpha, mach]);
ld_ratio = griddata(alpha_x, mach_y, LD_values, alpha, mach, 'v4');
% ld = polyfitweighted2(alpha_x, mach_y, LD_values ,3,[1 1 1 1 1 1; 
%                                           1 1 1 1 1 1;
%                                           1 1 1 1 1 1;
%                                           1 1 1 1 1 1;
%                                           1 1 1 1 1 1;
%                                           1 1 1 1 1 1;]);
% ld_ratio = polyval2(ld, alpha, mach);
end


