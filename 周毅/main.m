%% [0] 常数
T=300;                                  %温度 单位 K
Eg=0.813-((6*10^-4).*T.^2)./(T+265);    %禁带宽度 单位 eV
Eg=Eg*1.6*10^-19;                       %禁带宽度 单位 J
h=6.63*10^(-34);                        %普朗克常数 单位 J.s
c=3*10^8;                               %光速 单位 m/s
q=1.6021892*10^-19;                     %电子电荷量
S=0.03*0.04;                            %面积 单位 m^2
%% [1] lambda_max
lambda_max=h*c./Eg;                     %最大波长
lambda_max=lambda_max*10^6;             %单位转换成 um

%% [2] I_Ph
I_Ph=quadgk(@I_Ph_fun,0,lambda_max);    %积分得到I_Ph

%% [3] I0
I0=qS