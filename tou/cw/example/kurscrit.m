function J = kurscrit(params)
global flagplot parmodel
v0 = 0;
%PUT YOUR PARAMS HERE
distance = parmodel(1);
vset = parmodel(2);
kregv = parmodel(3);
kv = parmodel(4);
vmax = parmodel(5);
dt = parmodel(6);
tmax = parmodel(7);
reverse = parmodel(8);
vend = parmodel(9);
vcur = parmodel(10);
kregi = parmodel(11);
tnorm = distance/vmax; % s
anorm = 1;
kcrit_R1 = 4;
kcrit_R2 = 1;
x = [0;v0];
t1 = params(1);
%stopdistance = S2 (optimized parameter)
stopdistance = params(2);
if flagplot==1,
disp('t1')
disp(t1)
disp('S2')
disp(stopdistance)
end
pend = 0;
if t1<0,
pend = pend+1e3*abs(t1);
t1 = 0;
end
d_max = distance*0.9;
ve = vend/5;

if stopdistance>d_max,
pend = pend+(stopdistance-d_max)^2;
stopdistance=d_max;
end
dmin = 0;
if stopdistance < dmin,
stopdistance = dmin;
pend = pend+(dmin-stopdistance)^2;
end
xe = distance-stopdistance;
vmin = vend/10; % stop maneuver
int_dv = 0;
dv_max_int = 1;
umax = vmax^2;
if reverse==0,
umin = 0;
else
umin = -umax;
end
for i=1:tmax/dt,
s = x(1);
v = x(2);
aS(i) = s;
aV(i) = v;
t = i*dt;
at(i) = t;
if s<xe,
vdes = vset;
if t < t1,
mnv(i) = 1;
vdes = vset/t1*t;
end
else
mnv(i) = 1;
vdes = ve*(1+(s-xe)/(distance-xe));
end    
aVdes(i) = vdes;
dv = vdes-v;
if abs(dv)<dv_max_int,
int_dv = int_dv + dv*dt;
else
int_dv = 0;
end
u = vdes^2+kregv*dv+kregi*int_dv;
if u > umax,
u = umax;
end
if u < umin,
u = umin;
end
aU(i) = u/umax;
aP(i) = abs(aU(i))^(3/2);
z = kurs_rp(x,u,at(i));
adv_dt(i) = z(2);
x = x+z*dt;
if s > distance || (s>xe && v<vmin),
break
end
end

if v > vend,
  pend = pend + 100*(v-vend)^2;
end


if s<distance, 
 pend = pend+0.01*(s-distance)^2;  
end


timeend = max(at);
maxacc= max(abs(adv_dt));
idx = find(mnv==1);
Pmean = mean(aP(idx));
useAcc = 1;
% 0 – useP
J = kcrit_R1*timeend/tnorm +pend;
if useAcc==1,
J = J + kcrit_R2*maxacc/anorm;
else
J = J + kcrit_R2*Pmean;
end
if flagplot==1,
disp('Time of maneuver')
disp(timeend)
disp('Max acc, m/s^2')
disp(maxacc)
disp('Mean power of start/stop')
disp(Pmean)
disp('Final speed, m/s')
disp(v)
disp('Final distance')
disp(s)
disp('des distance')
disp(distance)
disp('Pending function')
disp(pend)
disp('Total criteria')
disp(J)
subplot(311), plot(at, aS), grid, title('S(t)')
subplot(312), plot(at, aV, at, aVdes),
grid, title('v(t)'), legend('v(t)','vdes(t)')
subplot(313), plot(at, aU, at, aP), grid,
title('U/Umax(t), Power/Powermax'), legend('U/Umax(t)', 'P/Pmax(t)')
end