function m_tps = tps(qd,type_mat)
m_spec = 0.32 * qd + 0.38*sqrt(qd) + 6.5; % if ceramic
m_spec = 0.3 * qd + 0.21*sqrt(qd) + 64.9; % if metal
m_spec = 0.24 * qd + 0.29*sqrt(qd) + 11.3; % if ablator
m_spec = 1.51 * qd + 1.1; % if water passive
m_spec = 1.47 * qd + 15.9; % if water passiv
m_TPS = r_n * r_n * 2 * pi * m_spec * (-cos(theta1_rad) + cos(0));
end

