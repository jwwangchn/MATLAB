clc
clear
close all
%% ��ά�ź�
x = randn(128,128);    %�����ź�
meanOfx = mean(x);   %�������źŵľ�ֵ
[eigenVectorOfx,eigenValueOfx] = eig(x);     %�������źŵ���������
covOfx=cov(x);