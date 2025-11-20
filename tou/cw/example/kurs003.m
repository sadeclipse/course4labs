clear
global flagplot parmodel
% for part 2
needOpt = 0; % 0 – simulation only

%PUT YOUR DATA HERE
kv = 0.000874; % 0.5*Omega*C/m
vmax = 14*0.514; %m/s
reverse = 1; %enable reverese
kregv = 6; % av: kv*(V*-v)
kregi = 0.001; % ai
distance_nm = 5; %mileage
distance = distance_nm*1852; %m:
vset = 12*0.514; %m/s
vcur = 0*0.514; % current spd, m/s
vwind = 6; % wind spd, m/s

% Simulation settings
dt = 0.5;
tmax = 10*distance/vmax;    
if reverse==0,
tmax = tmax*2;
end
vend = 0.1; %v<vend in the end of trackstop
parmodel = [distance, vset, kregv, kv, vmax, dt, tmax, reverse, vend, vcur, kregi ];
%SIMULATION
%PUT YOUR PARAMS HERE
t1 = 5;
stopdistance = 800;
params = [t1, stopdistance];
flagplot = 1;
J = kurscrit(params);
% fmins optimization (Nelder-Mead method)
if needOpt,
opt = optimset ("fminsearch")
opt.Display = "iter"
flagplot = 0;
paropt = fminsearch('kurscrit',params, opt);
%disp(paropt)
flagplot = 1;

J = kurscrit(paropt)

 time1 = 0:20:300;
sur2 = 0:500:10000;
J1 = [];
for i = 1:1:16
for j = 1:1:21
        J1(i,j) = kurscrit([time1(i), sur2(j)]);
end
end
figure;
mesh(time1, sur2, J1');
hold on
scatter3(paropt(1), paropt(2), J, '*r');
hold off
xlabel('t1, c');
ylabel('S2, м');
zlabel('J');
end
