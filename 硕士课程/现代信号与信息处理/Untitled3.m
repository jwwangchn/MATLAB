clc
clear
close all
X=imread('cameraman.tif'); %读图像 X是一个7波段图像图像的宽和高均为 256

XX=reshape(X,[256*256,1]); %将图像转换化为一个波段的图像

pic1=XX(:,1);

pic1=reshape(pic1,[256, 256]);

figure(1);

imshow(pic1,[]);

title('Original Image');

XX=im2double(XX); %图像转化为双精度

covx = cov(XX); % 求图像的协方差

[pc,variances,explained] = pcacov(covx); % 求解K_L变换矩阵，即PCA

pc

myKL=XX*pc; %进行K_L变换

pic2=myKL(:,1);

pic2=reshape(pic2,[256,256]);

figure(2);

imshow(pic2,[]);

title('K_L第一分量');

figure(3);

pic3=myKL(:,2);

pic3=reshape(pic3,[256 256]);

imshow(pic3,[]);

title('K_L 第二分量');

my=myKL*pc;

my1=my(:,1);

my1=reshape(my1,[256,256]);

figure(4);

imshow(my1,[]);