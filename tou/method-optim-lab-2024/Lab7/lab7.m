clear
global params flag_plot
close all



L = 67;
V0 = 10*0.514;
T1 = 20;
Kw = 1.5/30;

%Initial set
ap_coeffs = [4, 12, 0.003];


%coeffs_weight = [1, 0, 0, 0];
%coeffs_weight = [0, 1, 0, 0];
%$coeffs_weight = [1, 1, 1, 0];
coeffs_weight = [0.1, 1, 0, 1];
  

rdmax = 15;
rdmaxrate = 5; 
dt = 0.1;



flag_plot = 1;
tmax = 250;
f_dist_rd = 1*1*1;




scale_ap_coeffs = [5,  20,  0.001];
params = [V0, L, T1, Kw, rdmax, rdmaxrate,  tmax, dt, f_dist_rd, coeffs_weight, scale_ap_coeffs];

flag_plot = 1;
funlab7(ap_coeffs./scale_ap_coeffs);


flag_plot = 0;
needopt = 1;
if needopt, 
 ap_coeffs_opt_nd = fminsearch('funlab7',ap_coeffs./scale_ap_coeffs);
 ap_coeffs_opt = ap_coeffs_opt_nd.*scale_ap_coeffs;

 flag_plot = 1;
 funlab7(ap_coeffs_opt_nd);
 disp(ap_coeffs_opt)
 disp(ap_coeffs_opt_nd)
end

