function [ID,I0]=I0_fun(T_cell)
%使用修正公式标记进行计算
q = 1.6021892*10^-19;          %电子电荷量
S=0.03*0.04;                   %面积 单位 m^2
NA = (10^18)/(100^-3);                    %cm^-3
ND = (10^17)/(100^-3);                    %cm^-3
SF = 10^6/100;                     %cm*s^-1
SB = 10^2/100;                     %cm*s^-1
u_max_e = 5650/(100^2);                %cm^2 (VS)^-1
u_max_h = 875/(100^2);                 %cm^2 (VS)^-1
u_min_e = 1050/(100^2);                %cm^2 (VS)^-1
u_min_h = 190/(100^2);                 %cm^2 (VS)^-1
theta1_e = 2.0;
theta1_h = 1.7;
theta2_e = 2.8;
theta2_h = 2.7;
ni = 1.405*10^12/(100^-3);              %cm^-3
alpha_e = 1.05;
alpha_h = 0.65;
N_ref_e = 2.8*10^17/(100^-3);           %cm^-3
N_ref_h = 9*10^17/(100^-3);             %cm^-3
k = 1.3806488*10^(-23);        %玻尔兹曼常数 单位 J/K  在修正文献中标记为 kB
B_opt = 8.5*10^-11/(100^-3);            %cm^-3 s^-1
tao_SRH_e = 10*10^-9;                %ns
tao_SRH_h = 10*10^-9;                %ns
Lambda = 5*10^-30/(10^6);              % cm^6*S^-1
H=200*10^-9;                          %nm
X=4000*10^-9;                         %nm

u_e = u_min_e + (u_max_e*(300/T_cell)^(theta1_e)-u_min_e)/(1+((NA/N_ref_e)*(T_cell/300)^theta2_e)^(alpha_e));
u_h = u_min_h + (u_max_h*(300/T_cell)^(theta1_h)-u_min_h)/(1+((ND/N_ref_h)*(T_cell/300)^theta2_h)^(alpha_h));

D_e = k*T_cell*u_e/q;
D_h = k*T_cell*u_h/q;

tao_e = ((B_opt*NA)^-1+tao_SRH_e^-1+(Lambda*NA^2))^-1;
tao_h = ((B_opt*ND)^-1+tao_SRH_h^-1+(Lambda*ND^2))^-1;

L_e = sqrt(D_e*tao_e);
L_h = sqrt(D_h*tao_h);

I0=(q*(ni^2)*D_h/(ND*L_h))*((sinh(H/L_h)+(SB*L_h/D_h)*cosh(H/L_h))/(cosh(H/L_h)+(SB*L_h/D_h)*sinh(H/L_h)))+(q*(ni^2)*D_e/(NA*L_e))*((sinh(X/L_e)+(SF*L_e/D_e)*cosh(X/L_e))/(cosh(X/L_e)+(SB*L_e/D_e)*sinh(X/L_e)));

V=0.5; %工作电压
I0;
ID=I0*(exp(q*V/(k*T_cell))-1);
