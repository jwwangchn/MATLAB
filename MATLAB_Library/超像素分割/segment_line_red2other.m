function disp_img=segment_line_red2other(disp_img)
%====================================================================
%将分割线的颜色强制转换为其他颜色（ling）
%disp_img=segment_line_red2other(disp_img)
%====================================================================
%输入参数：
%   [1] disp_img 为图像矩阵
%====================================================================
%输出参数：
%   [1] disp_img 为转换后的图像矩阵
%====================================================================

[img_length,img_width,deepth]=size(disp_img);

for k=1:img_length
    for m=1:img_width
        if(disp_img(k,m,1)==255 && disp_img(k,m,2)==0 && disp_img(k,m,3)==0)
            disp_img(k,m,2)=0;
            disp_img(k,m,3)=0;
            disp_img(k,m,1)=255;
        end
    end
end