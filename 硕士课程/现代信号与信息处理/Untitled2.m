clc
clear
close all
I=imread('cameraman.tif');
figure(1)
imshow(I)
I=im2double(I);

covx = cov(I);
[COEFF,latent,explained] = pcacov(covx);
myKL = I * COEFF;
figure(2)
imshow(myKL)