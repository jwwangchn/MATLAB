clc
clear
close all
X=imread('cameraman.tif'); %��ͼ�� X��һ��7����ͼ��ͼ��Ŀ�͸߾�Ϊ 256

XX=reshape(X,[256*256,1]); %��ͼ��ת����Ϊһ�����ε�ͼ��

pic1=XX(:,1);

pic1=reshape(pic1,[256, 256]);

figure(1);

imshow(pic1,[]);

title('Original Image');

XX=im2double(XX); %ͼ��ת��Ϊ˫����

covx = cov(XX); % ��ͼ���Э����

[pc,variances,explained] = pcacov(covx); % ���K_L�任���󣬼�PCA

pc

myKL=XX*pc; %����K_L�任

pic2=myKL(:,1);

pic2=reshape(pic2,[256,256]);

figure(2);

imshow(pic2,[]);

title('K_L��һ����');

figure(3);

pic3=myKL(:,2);

pic3=reshape(pic3,[256 256]);

imshow(pic3,[]);

title('K_L �ڶ�����');

my=myKL*pc;

my1=my(:,1);

my1=reshape(my1,[256,256]);

figure(4);

imshow(my1,[]);