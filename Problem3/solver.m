syms G0 N0 Ns
% 21.2852 == 2.63e11 + 1.26e5 * G0 - G0*(Ns - N0)
% 292.1764 == 2.741e19 + 3.33e11 * G0 - 1e8 *  G0*(Ns - N0)
% Ns == (3.33e11 + 1.26e5 * G0 * N0)/(1401.667 + G0 * 1.26e5)
P0 = 1.9E-3;
beta = 1e-3;
tao_n = 0.4e-9;
k = 1.54e-8;
tao_p = 4.14e-12;
epsi = 1.23e-7;
[N0_r,G0_r,Ns_r] = solve(21.2852 == 1/tao_n + 1/tao_p+ (P0 / k) * G0 - G0*(Ns - N0),292.1764 == 1/(tao_n * tao_p) + (P0 / (k*tao_p)) * G0 - (1/tao_n)*  G0*(Ns - N0),Ns == (P0/(k*tao_p) + (P0/k) * G0 * N0)/(beta/tao_n + G0 * (P0/k)),N0,G0,Ns);
double(1/tao_n + 1/tao_p+ (P0 / k) * G0_r - G0_r*(Ns_r - N0_r))
double(1/(tao_n * tao_p) + (P0 / (k*tao_p)) * G0_r - (1/tao_n)*  G0_r*(Ns_r - N0_r))
double(G0_r)
double(N0_r)