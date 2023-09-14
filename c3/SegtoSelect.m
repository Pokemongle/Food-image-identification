function mask = SegtoSelect(image)
img = histeq(image);
I2 = im2bw(img,0.6);

I2 = ~I2;
se1 = strel('rectangle',[2 2]);
se2 = strel('disk',2);
I2 = imclose(I2,se1);
I2 = imopen(I2,se2);
I2 = imclose(I2,se2);
mask = ~I2;
mask = uint8(mask);
end