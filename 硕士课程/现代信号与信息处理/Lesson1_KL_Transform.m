clc
clear
close all
%% 二维信号
x = randn(128,128);    %输入信号
meanOfx = mean(x);   %求输入信号的均值
[eigenVectorOfx,eigenValueOfx] = eig(x);     %求输入信号的特征向量
covOfx=cov(x);