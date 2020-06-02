function [HF] = heat_flux(w, r)
% Basic implementation of the heat flux
% Highly probable to be moved elsewhere
% Could add it to the ODE? since we'll have to plot it 

global rho_SL r_n r_E

[T ,a ,P ,rho] = atmosisa(r-r_E);
HF = [];
for i = length(w): -1 :1
    if w(i) <= 7900 % m/s
        B_c = 9823.4;
        B_r = 1135.7;
        chi_c = 3.15;
        chi_r = 8.5;
        psi_c = 0.5;
        psi_r = 1.6;

    else
        B_c = 9823.4;
        B_r = 85.174;
        chi_c = 3.15;
        chi_r = 12.5;
        psi_c = 0.5;
        psi_r = 1.5;
    end
    q_conv = B_c * (w(i) / 3.048)^chi_c * (rho(i) / rho_SL)^psi_c * ... 
    sqrt(0.3048 / r_n);

    q_rad = B_r * (w(i) / 3.048)^(chi_r) * (rho(i) / rho_SL)^(psi_r) * r_n / 0.3048;

    q_d = q_conv + q_rad;
    HF = [HF q_d];
end
% -> comopute for each step
% then integrate this thnigy of the re-entry time
end