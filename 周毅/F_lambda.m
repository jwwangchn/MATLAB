function y=F_lambda(lambda)
%lambdaΪ���� ��λ um
lambda=lambda*10^-6;  %������λת��Ϊ m
chi=0.78;               %����
c=3*10^8;               %���� ��λ m/s
h=6.63*10^(-34);        %���ʿ˳��� ��λ J.s
k=1.3806488*10^(-23);   %������������ ��λ J/K 
T_Rad=1600;             %�����¶� ��λ K 
fenmu=(lambda.^4).*(exp(h.*c./(lambda.*k.*T_Rad))-1);
fenzi=2*pi*c;
y=chi*fenzi./fenmu;

 