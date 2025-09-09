
if ship==1,
 %Kalash
 L = 95;
 V0 = 6*0.514
 V1 = 3.8*0.514
 
 tmax = 8*60;
 rd = 30;
 Tv = 120;
 T1 = 20;
 Kw = 2.0/35;

 apc1 = [1, 0, 0.7, 0];
 apc2 = [1, 12, 0.01];


elseif ship==2,
 %Pobeda
 L = 242;
 V0 = 15*0.514
 V1 = 8.6*0.514

 tmax = 8*60;
 rd = 35;
 Tv = 120;   %10 min
 T1 = 30;
 Kw = 1.0/35;


 apc1 = [2, 0, 0.7, 0];
 apc2 = [3, 25, 0.01];

elseif ship==3,
 %Tikhonov
 L = 198;
 V0 = 19*0.514
 V1 = 14*0.514

 tmax = 5.7*60;
 rd = 35;
 Tv = 100;   %10 min
 T1 = 30;
 Kw = 1.5/35;


 apc1 = [1, 0, 0.7, 0.];
 apc2 = [4, 40, 0.01];

elseif ship==4,
 %M Uli
 L = 257;
 V0 = 16*0.514
 V1 = 7*0.514

 tmax = 4*60;
 rd = 30;
 Tv = 120;  %depends on L  
 T1 = 15;
 Kw = 3/30;
  

 apc1 = [1, 0, 0.7, 0.];
 apc2 = [3, 20, 0.015];

elseif ship==5,
 %RSD59
 L = 140;
 V0 = 10*0.514
 V1 = 4*0.514

 tmax = 4*60;
 rd = 30;
 Tv = 70;  %depends on L  
 T1 = 12;
 Kw = 2.5/30;
  

 apc1 = [1, 0, 0.7, 0.];
 apc2 = [2, 15, 0.01];

elseif ship==6,
 %Tug
 L = 26;
 V0 = 12*0.514
 V1 = 4*0.514

 tmax = 1.5*60;
 rd = 30;
 Tv = 40;  %depends on L  
 T1 = 8;
 Kw = 9/30;
  

 apc1 = [1, 0, 0.7, 0.];
 apc2 = [4, 12, 0.003];

elseif ship==7,
 %barg
 L = 67;
 V0 = 10*0.514
 V1 = 5*0.514

 tmax = 5*60;
 rd = 35;
 Tv = 100;  %depends on L  
 T1 = 20;
 Kw = 1.5/30;
  

 apc1 = [1, 0, 0.7, 0.];
 apc2 = [3, 30, 0.01];

end

%35 deg
