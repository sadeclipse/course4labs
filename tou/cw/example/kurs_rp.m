function z = kurs_rp(x,u,t)
global parmodel
s = x(1);
v = x(2);
kv = parmodel(4);
vcur = parmodel(10);

% todo faero 
faero = 0;
fdist = 0; % additional resistance
v_lq = v-vcur;
dv_dt = -kv*v_lq*abs(v_lq)+kv*u+fdist;
dx_dt = v;
z = [dx_dt;dv_dt];