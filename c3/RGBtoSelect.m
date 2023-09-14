function mask = RGBtoSelect(image)
imager = image(:,:,1);R2 = im2double(imager);
imageg = image(:,:,2);G2 = im2double(imageg);
imageb = image(:,:,3);B2 = im2double(imageb);
[Height Width rgb] = size(image);
ave_R2 = sum(R2(:))./(Height*Width);
mask = zeros(Height,Width);
for i=1:Height
    for j=1:Width  %±éÀú
        del1 = R2(i,j)-B2(i,j);
        del2 = R2(i,j)-G2(i,j);
        if(abs(del1)<0.15*ave_R2&&abs(del2)<0.15*ave_R2&&R2(i,j)>1*ave_R2);
           mask(i,j) = 1;
        end
    end
end
mask=uint8(mask);
end