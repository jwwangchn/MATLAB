function [segments, numlabels]=mex_SLIC_fun(im, SuperpixelsNum, CompactnessFactor)
%====================================================================
%使用 SLIC 的 C 源程序库编写的 SLIC 超像素分割程序（ling）
%[segments, numlabels] = VLfeat_SLIC_fun(im, regionsize, regularizer)
%====================================================================
%输入参数：
%   [1] im 为图像矩阵
%   [2] SuperpixelsNum 为超像素数量 默认值为 150
%   [3] CompactnessFactor 为紧密度 默认值为 20
%====================================================================
%输出参数：
%   [1] segments 为分割之后的超像素块的标签
%   [2] numlabels 为超像素数量
%====================================================================
%   函数运行完之后 显示分割之后的图像 并将分割之后的图像写入 image_mex_SLIC.jpg 文件中

%% 函数默认值设定部分
if nargin==0
    im=imread('coloredChips.png');
    SuperpixelsNum=150;     %SuperpixelsNum默认值为150
    CompactnessFactor=20;   %CompactnessFactor默认值为20
elseif nargin==1
    SuperpixelsNum=150;     %SuperpixelsNum默认值为150
    CompactnessFactor=20;   %CompactnessFactor默认值为20
end

%%
[segments, numlabels] = slicmex(im,SuperpixelsNum,CompactnessFactor);%numlabels is the same as number of superpixels
% imagesc(labels);
%以下注释部分并非无用代码，而是较粗的分割线代码！！！
% [a,b,h]=size(im);
% for m=1:a
%     for n=1:b
%         if (m==1)||(n==1)||(m==a)||(n==b)
%             im(m,n)=im(m,n);
%         elseif (segments(m,n)~=segments(m-1,n)||segments(m,n)~=segments(m+1,n)||segments(m,n)~=segments(m,n-1)||segments(m,n)~=segments(m,n+1))
%             im(m,n,1)=255;
%             im(m,n,2)=0;
%             im(m,n,3)=0;
%         end
%     end
% end


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

%将分割线转换成白色
imp=segment_line_red2other(imp);
figure
imshow(imp);

imwrite(imp,'image_mex_SLIC_3.jpg');

end