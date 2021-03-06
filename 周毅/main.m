clc
clear all
%% [0] 常数
T_cell=300;                                  %温度 单位 K
Eg=0.813-((6*10^-4).*T_cell.^2)./(T_cell+265);    %禁带宽度 单位 eV
Eg=Eg*1.6*10^-19;                       %禁带宽度 单位 J
h=6.63*10^(-34);                        %普朗克常数 单位 J.s
k=1.3806488*10^(-23);                   %玻尔兹曼常数 单位 J/K 
c=3*10^8;                               %光速 单位 m/s
q=1.6021892*10^-19;                     %电子电荷量
S=0.03*0.04;                            %面积 单位 m^2
%% [1] lambda_max
lambda_max=h*c./Eg;                     %最大波长
lambda_max=lambda_max*10^6;             %单位转换成 um

%% [2] I_Ph
I_Ph=quadgk(@I_Ph_fun,0,lambda_max)    %积分得到I_Ph

%% [3] I0 和 ID

[ID,I0]=I0_fun(T_cell);

%% [4] I_Total
I_Total=I_Ph-ID;

%% [5] V_oc(chi=0.8时)
I_sc=0.4/1000;                          %chi=0.8 时
FF = 0.772                              %chi=0.8 时
P_inc = 28.84                           %w/m^2 T_rad=1600K 时
P_ret = 0.7616*28.84                    % T_rad=1600K 时
V_oc=(1*k*T_cell/q)*log(I_sc/I0+1)

%% [6] 效率mu
mu=(I_sc*V_oc*FF)/(P_inc-P_ret)
