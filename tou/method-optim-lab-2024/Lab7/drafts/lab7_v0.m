clear

%close all

f_dist_rd = 1*1*1;


L = 67;
V0 = 10*0.514;
V1 = 5*0.514;
tmax = 5*60;
rd = 35;
Tv = 100;    
T1 = 20;
Kw = 1.5/30;
%ap_coeffs = [4, 12, 0.003];
ap_coeffs = [4, 100, 0.003];
  

rdmax = 15;
rdmaxrate = 5; 


dt = 0.1;
T1_ = T1*V0/L;
Kw_ = Kw*L/V0;

t = 0:dt:tmax;
arda  =[];


testmodel =0;
if testmodel==1,
% T1*dw/dt+w=Kw*delta


w = 0;
V = V0;
aV = [];
aw = [];
aphi=[];
phi = 0;
for i=1:length(t),
  V = V+dt*(V1-V)/Tv;
  T1_now = T1_*L/V;
  Kw_now = Kw_*V/L;
  dw_dt = 1/T1_now*(Kw_now*rd-w);
  w = w+dw_dt*dt;
  phi = phi+w*dt;
  aw=[aw, w];
  aV=[aV, V];
  aphi=[aphi, phi];
end

figure(1)
subplot(411), plot(t, aV);grid, title('V')
subplot(412), plot(t, aw); grid, title('w')
subplot(413), plot(t, aphi);grid, title('phi')
subplot(414), plot(t, (aw*pi/180*L)./aV);grid, title('w_')

end


%ap





phi = 20;
phides = phi;
intdphi = 0;
intdw = 0;
w  =0;

wmax  = 60/60;
 
rd_actual = 0;

awu=[];
au=[];
aphiu = [];
awdes=[];
phidesold = phi;
aphides=[];
for i=1:length(t),
  V = V0;
  T1_now = T1_*L/V;
  Kw_now = Kw_*V/L;
  if t(i)>20,
    phides = 50;
  endif
  if t(i)>220,
    phides = 45;
  endif

  if phides!=phidesold,
    intdphi  = 0;
    intdw  = 0;
    phidesold = phides;
  endif

  dphi = (phides-phi);  %-180..180


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

