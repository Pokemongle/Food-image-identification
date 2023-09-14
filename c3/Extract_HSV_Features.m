function total_HSV_Features = Extract_HSV_Features(data)
%提取颜色矩特征
[~,totalNum] = size(data);
total_HSV_Features = [];
for i = 1 : totalNum
image = data(i).image;
h = ones(5,5)/25;
image2 = imfilter(image,h);  % 5*5均值滤波
hsv = rgb2hsv(image2);%RGB转hsv
h=hsv(:,:,1);
s=hsv(:,:,2);
v=hsv(:,:,3);
H=double(h);
S=double(s);
V=double(v);
[m,n]=size(H);
%一阶矩（均值）
Hmean=mean2(H);
Smean=mean2(S);
Vmean=mean2(V);
%二阶矩（标准差）
Hstd=std2(H);
Sstd=std2(S);
Vstd=std2(V);
%三阶矩（偏差）
sum=0.0;
for i=1:m
    for j=1:n
        sum=sum+(H(i,j)-Hmean)^3;
    end
end
Hske=(sum/(m*n))^(1/3);
sum=0.0;
for i=1:m
    for j=1:n
        sum=sum+(S(i,j)-Smean)^3;
    end
end
Sske=(sum/(m*n))^(1/3);
sum=0.0;
for i=1:m
    for j=1:n
        sum=sum+(V(i,j)-Vmean)^3;
    end
end
Vske=(sum/(m*n))^(1/3);
HSV = [Hmean,Smean,Vmean,Hmean-Smean,Hmean-Vmean,Smean-Vmean,Hstd,Sstd,Vstd,Hske,Sske,Vske];
HSV = abs(HSV);
    total_HSV_Features = [total_HSV_Features;HSV];
end
end



