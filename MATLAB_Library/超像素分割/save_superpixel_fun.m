function [image_mat,numlabels]=save_superpixel_fun(image,str1)
%====================================================================
%生成 AdaBoost 算法训练图片信息的函数（ling）
%make_train_matfile_fun(image_mat,numlabels,tree_label_init)
%====================================================================
%输入参数：
%   [1] image_mat 将训练图片分割出来的超像素块转换成行向量并存储在一起之后的矩阵（每行一个超像素块） 由
%   save_superpixel_fun 函数生成
%   [2] numlabels 超像素数量 由 save_superpixel_fun 函数生成
%   [3] tree_label_init 为超像素块中树所在超像素块的命名编号 即训练数据的原始标签
%====================================================================
%   函数运行完之后 将训练图片的数据写入到 SLIC_train.mat 文件中

%% [1] 读取并显示原始图像
% image = imread('很多大树.jpg');
% image = imread('coloredChips.png'); %测试图像
% image = imread('测试图片.jpg');
figure
imshow(image);
[image_width,image_length,image_high]=size(image);
%% [2] 高斯滤波处理
%获得高斯低通滤波器,HSIZE为滤波器大小，SIGMA为参数
HSIZE=400;
SIGMA=0.5;
%缺省为和0.5
H = fspecial('gaussian',HSIZE,SIGMA);
%用图像滤波函数imfilter处理
Blurimage = imfilter(image,H,'replicate');

figure
imshow(Blurimage)
imwrite(Blurimage,'高斯滤波.jpg')
%% [3] 超像素分割

[segments, numlabels] = mex_SLIC_fun(Blurimage,100,20);
numlabels=double(numlabels)

%计算单个超像素块的大小
size_single_superpixel=(image_width*image_length/numlabels)^(1/2);

%% [4] 提取单个超像素块

for k=0:numlabels-1
    [row_0,col_0]=find(segments==k);
    min_row=min(row_0);
    min_col=min(col_0);
    clear image_temp
    for i=1:length(row_0)    
        image_temp(row_0(i)-min_row+1,col_0(i)-min_col+1,1)=Blurimage(row_0(i),col_0(i),1);
        image_temp(row_0(i)-min_row+1,col_0(i)-min_col+1,2)=Blurimage(row_0(i),col_0(i),2);
        image_temp(row_0(i)-min_row+1,col_0(i)-min_col+1,3)=Blurimage(row_0(i),col_0(i),3);
    end
    str=[str1,num2str(k) ,'.jpg'];                          %超像素块命名字符串
    
%     new_image_temp=imresize(image_temp,[fix(size_single_superpixel),fix(size_single_superpixel)],'bilinear'); %对图像进行重采样 50*50
    
    new_image_temp=imresize(image_temp,[100,100],'bilinear'); %对图像进行重采样 50*50
    imwrite(new_image_temp,str);
    
    %将数据存储成 mat 文件
    image_mat_temp=rgb2gray(new_image_temp);%将3维矩阵转换为2维矩阵
    image_mat_temp=im2double(image_mat_temp);%数据类型转换为double 
    image_mat_temp=image_mat_temp(:);
    image_mat(k+1,:)=image_mat_temp;
end
        
