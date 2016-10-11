clc
clear
close all
%% [1] 生成原始数据
x=(0:0.2:10)';  %横坐标
y=2*sin(x)+3*cos(x)+1+wgn(length(x),1,10*log(0.2)); %纵坐标
figure(1)
plot(x,y,'*')
title('原始数据')   %绘制原始数据图像

%% [2] 数据模型为5次多项式
% 求观测矩阵
H0=[];  %初始化矩阵
for i=1:6
    H0_add = x.^(6-i);
    H0 = [H0,H0_add];
end
% MVU的估计量
theta_ba0 = ((H0'*H0)^-1)*H0'*y;
% 协方差矩阵
C_theta_ba0 = 0.2 * (H0'*H0)^(-1);

% 验证多项式拟合效果
x0 = x;
y0 = theta_ba0(6)*x0.^0 + theta_ba0(5)*x0.^1 + theta_ba0(4)*x0.^2 + theta_ba0(3)*x0.^3 + theta_ba0(2)*x0.^4 + theta_ba0(1)*x0.^5; 
figure(2)
plot(x0,y0,'r');
title('数据模型为线性模型')

%% [3] 数据模型为正余弦函数的线性组合
% 求观测矩阵
H1=[];
for i=1:3
    H1 = [sin(abs(x)),cos(abs(x)),ones(length(x),1)];
end
% MVU的估计量
theta_ba1 = ((H1'*H1)^-1)*H1'*y;
% 协方差矩阵
C_theta_ba1 = 0.2 * (H1'*H1)^(-1);
% 验证多项式拟合效果
x1 = x;
y1 = theta_ba1(3)*x1.^0 + theta_ba1(2).*cos(x1) + theta_ba1(1).* sin(x1); 
figure(3)
plot(x1,y1,'g-.');
title('数据模型为正余弦')

%% [4] 将所有模型绘制在一起
figure(4)
plot(x,y,'*',x0,y0,'r',x1,y1,'g-.')
legend('原始数据','线性模型','正余弦组合模型')
