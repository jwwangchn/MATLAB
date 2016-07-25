function y=F_lambda(lambda)
%lambda为波长 单位 um
lambda=lambda*10^-6;  %波长单位转换为 m
chi=0.78;               %常数
c=3*10^8;               %光速 单位 m/s
h=6.63*10^(-34);        %普朗克常数 单位 J.s
k=1.3806488*10^(-23);   %玻尔兹曼常数 单位 J/K 
T_Rad=1600;             %辐射温度 单位 K 
fenmu=(lambda.^4).*(exp(h.*c./(lambda.*k.*T_Rad))-1);
fenzi=2*pi*c;
y=chi*fenzi./fenmu;

 