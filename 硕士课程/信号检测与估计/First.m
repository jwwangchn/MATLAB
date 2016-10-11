clc
clear
close all
%% [1] ����ԭʼ����
x=(0:0.2:10)';
y=2*sin(x)+3*cos(x)+1+wgn(length(x),1,10*log(0.2));
figure(1)
plot(x,y,'*')
title('ԭʼ����')

%% [2] ����ģ��Ϊ5�ζ���ʽ
% ���۲�����
H0=[];
for i=1:6
    H0_add = x.^(i-1);
    H0 = [H0,H0_add];
end
% MVU�Ĺ�����
theta_ba0 = ((H0'*H0)^-1)*H0'*y;
% Э��������
C_theta_ba0 = 0.2 * (H0'*H0)^(-1);

% ��֤����ʽ����Ч��
x0 = x;
y0 = theta_ba0(1)*x0.^0 + theta_ba0(2)*x0.^1 + theta_ba0(3)*x0.^2 + theta_ba0(4)*x0.^3 + theta_ba0(5)*x0.^4 + theta_ba0(6)*x0.^5; 
figure(2)
plot(x0,y0,'r');
title('����ģ��Ϊ����ģ��')

%% [3] ����ģ��Ϊ�����Һ�������������
% ���۲�����
H1=[];
for i=1:3
    H1 = [ones(length(x),1),cos(abs(x)),sin(abs(x))];
end
% MVU�Ĺ�����
theta_ba1 = ((H1'*H1)^-1)*H1'*y;
% Э��������
C_theta_ba1 = 0.2 * (H1'*H1)^(-1);
% ��֤����ʽ����Ч��
x1 = x;
y1 = theta_ba1(1)*x1.^0 + theta_ba1(2).*cos(x1) + theta_ba1(3).* sin(x1); 
figure(3)
plot(x1,y1,'g-.');
title('����ģ��Ϊ������')

%% [4] ������ģ�ͻ�����һ��
figure(4)
plot(x,y,'*',x0,y0,'r',x1,y1,'g-.')
legend('ԭʼ����','����ģ��','����������ģ��')
