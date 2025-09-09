function J = funlab7(xx)

global params flag_plot

i=1;
L = params(i); i=i+1;
V0 = params(i); i=i+1;
T1 = params(i); i=i+1;
Kw = params(i); i=i+1;
rdmax = params(i); i=i+1;
rdmaxrate = params(i); i=i+1;
tmax  = params(i); i=i+1;
dt  = params(i); i=i+1;
f_dist_rd  = params(i); i=i+1;
mult1 = params(i); i=i+1;
mult2 = params(i); i=i+1;
mult3 = params(i); i=i+1;
mult4 = params(i); i=i+1;
scale_coeff1 = params(i); i=i+1;
scale_coeff2 = params(i); i=i+1;
scale_coeff3 = params(i); i=i+1;


ap_coeffs = [xx(1)*scale_coeff1, xx(2)*scale_coeff2, xx(3)*scale_coeff3];

%ap_coeffs

T1_ = T1*V0/L;
Kw_ = Kw*L/V0;

phi = 20;
phides = phi;
intdphi = 0;
intdw = 0;
w  =0;

wmax  = 60/60;
 
rd_actual = 0;
t = 0:dt:tmax;
arda  =[];
awu=[];
au=[];
aphiu = [];
awdes=[];
phidesold = phi;
aphides=[];

flag_in_band =0;


%t_switch_u = [20, 220, 300];
%phi_switch_u = [50, 45, 30];
t_switch_u = [50];
phi_switch_u = [35];
j_switch_u = 1;

max_overshoot = 0;
wait_for_overshoot=0;
T_transient = [];
t_old = 0;
dir_dhdg = 0;


J = 0;
static_err= [];
ardmax = [];
i_band = 1;
for i=1:length(t),
  V = V0;
  T1_now = T1_*L/V;
  Kw_now = Kw_*V/L;

  if t(i)> t_switch_u(j_switch_u),
    phides = phi_switch_u(j_switch_u);
    if j_switch_u < length(t_switch_u),
      j_switch_u = j_switch_u +1;
    endif
  endif

  if phides!=phidesold,
    static_err = [static_err,abs(phi-phides)];

    di = T1_now/dt;
    rdtest = arda(i_band:end);
    if length(rdtest)>0
      aa = std(rdtest);
      ardmax = [ardmax, aa];
    end
     

    intdphi  = 0;
    intdw  = 0;
    phidesold = phides;
    flag_in_band =0;
    wait_for_overshoot=0;
    t_old = t(i);
  end

  dphi = (phides-phi);  %-180..180

  
  if flag_in_band==0 && abs(dphi) < 5,
    flag_in_band = 1;
    wait_for_overshoot=0;
    tau = t(i)-t_old;
    if tau > 0, 
       T_transient = [T_transient, tau];
    end
    dir_dhdg = sign(dphi);
    i_band = i;
  end

  if flag_in_band==1 && (dphi*dir_dhdg < 0),
    wait_for_overshoot=1;
  end


  if wait_for_overshoot && abs(dphi) > max_overshoot, 
   max_overshoot = abs(dphi);
  end

  intdphi = intdphi+dphi*dt;

  if abs(dphi)>3,
    intdphi = 0;
  endif

  wdes=0;
  dw = wdes-w;
  rd = ap_coeffs(1)*dphi+ap_coeffs(2)*dw+ap_coeffs(3)*intdphi;


  if rd>rdmax,
   rd = rdmax;
  elseif rd<-rdmax,
   rd = -rdmax;
  end

 
  drd_dt = 0;
  err_rd = rd - rd_actual;
  if err_rd > 1, 
    drd_dt = rdmaxrate; 
  elseif err_rd <-1, 
    drd_dt = -rdmaxrate; 
  end
  rd_actual = rd_actual + drd_dt*dt;

  dw_dt = 1/T1_now*(Kw_now*(rd_actual-f_dist_rd)-w);
  phi = phi+w*dt;
  w = w+dw_dt*dt;
  awu=[awu, w];
  awdes = [awdes,wdes];
  au=[au, rd];
  arda =[arda, rd_actual];
  aphiu=[aphiu, phi];
  aphides = [aphides,phides];
end



scale1 = 100;  % s    
scale2 = 2; %deg
scale3 = 15; % s
scale4  = 1;


J = mult1*sum(T_transient)/length(T_transient)/scale1 + mult2*max_overshoot/scale2+mult3*sum(ardmax)/length(ardmax)/scale3+mult4*sum(static_err)/length(static_err)/scale4;



if flag_plot,
disp( max_overshoot);
disp( T_transient);
disp(J);

figure(2)
subplot(211), plot(t, au, t, arda);grid, title('rudder u(t)')
hold on
%subplot(312), plot(t, awu, t, awdes);grid, title('w')
subplot(212),
%if k==1, 
plot(t, aphides);
%end
title('heading (t)')
grid on
hold on

plot(t,aphiu);

end
