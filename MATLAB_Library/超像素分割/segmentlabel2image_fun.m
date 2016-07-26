function [image]=segmentlabel2image_fun(image,segments,k)
[a,b,h]=size(image);
for m=1:a
    for n=1:b
        if (m==1)||(n==1)||(m==a)||(n==b)
            image(m,n)=image(m,n);
        elseif (segments(m,n)~=segments(m-1,n)||segments(m,n)~=segments(m+1,n)||segments(m,n)~=segments(m,n-1)||segments(m,n)~=segments(m,n+1))
            image(m,n,1)=255;
            image(m,n,2)=0;
            image(m,n,3)=0;
        end
    end
end

image=segment_line_red2other(image);
figure
imshow(image);
