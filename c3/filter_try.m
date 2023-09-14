    clc;close all;clear;
    image = imread('./lib/s2/3.png');
    h = ones(5,5)/25;
    image2 = imfilter(image,h);
    figure
    subplot(121);
    imshow(image);
    subplot(122);
    imshow(image2);
    %%
    clc;close all;clear;
    image = rgb2gray(imread('./lib/s2/3.png'));
    H1 = [0 -1 0;-1 5 -1 ;0 -1 0];
    image2 = imfilter(image,H1);%Laplacian锐化滤波
    figure
    subplot(121);
    imshow(image);
    subplot(122);
    imshow(image2);

    %%
clc;close all;clear;
I1 = imread('./lib/s1/3.png');
H=fspecial('disk',5);
blurred = imfilter(I1,H,'replicate');
I2 = im2bw(blurred,0.25);
I2 = ~I2;
se1 = strel('rectangle', [3 1]);
se2 = strel('disk', 1);
I2 = imclose(I2,se1);
I2 = imopen(I2,se2);
result=imdilate(I2,se2); 
result = ~result;
   
    figure
    subplot(121);
    imshow(I1);
    subplot(122);
    imshow(result,[]);
%%
clc;close all;clear;

I = rgb2gray(imread('./lib/s8/3.png'));

%对输入的图像检测SURF特征；

points = detectSURFFeatures(I);

%显示最强的十个SURF特征点；

imshow(I);hold on;

plot(points.selectStrongest(30));
