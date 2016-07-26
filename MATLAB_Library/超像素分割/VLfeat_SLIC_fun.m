function segments=VLfeat_SLIC_fun(im,regionsize,regularizer)
%====================================================================
%使用 VLfeat 库编写的 SLIC 超像素分割程序（ling）
%segments = VLfeat_SLIC_fun(im, regionsize, regularizer)
%====================================================================
%输入参数：
%   [1] im 为图像矩阵
%   [2] regionsize 为超像素块区域大小 默认值为 200
%   [3] regularizer 为 默认值为 200
%====================================================================
%输出参数：
%   [1] segments 为分割之后的超像素块的标签
%   [2] numlabels 为超像素数量
%====================================================================
%   函数运行完之后 显示分割之后的图像 并将分割之后的图像写入 image_VLfeat_SLIC.jpg 文件中

%% 函数默认值设定部分
if nargin==0
    im=imread('coloredChips.png');
    regionsize = 200;     %SuperpixelsNum默认值为200
    regularizer = 200;   %CompactnessFactor默认值为200
elseif nargin==1
    regionsize = 200;     %SuperpixelsNum默认值为200
    regularizer = 200;   %CompactnessFactor默认值为200
end

%%
[a,b,h]=size(im);

segments=vl_slic(single(im),regionsize,regularizer);

% overaly segmentation
[sx,sy]=vl_grad(double(segments), 'type', 'forward') ;
s = find(sx | sy) ;
imp = im ;
imp([s s+numel(im(:,:,1)) s+2*numel(im(:,:,1))]) = 0 ;
[m,n,k]=size(imp)
for a=1:m
    for b=1:n
        if imp(a,b,1)==0
            imp(a,b,1)=255;
            imp(a,b,2)=0;
            imp(a,b,3)=0;
        end
    end
end
figure
imshow(imp)
imwrite(imp,'image_VLfeat_SLIC.jpg');
