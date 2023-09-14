function total_RGB_Features = Extract_RGB_Features(data)
%提取颜色矩特征
[~,totalNum] = size(data);
total_RGB_Features = [];
for i = 1 : totalNum
    image = data(i).image;
    h = ones(5,5)/25;
    image2 = imfilter(image,h);  % 5*5均值滤波
R=image2(:,:,1);
G=image2(:,:,2);
B=image2(:,:,3);
R=double(R);
G=double(G);
B=double(B);
[m,n]=size(R);
%一阶矩（均值）
Rmean=mean2(R);
Gmean=mean2(G);
Bmean=mean2(B);
%二阶矩（标准差）
Rstd=std2(R);
Gstd=std2(G);
Bstd=std2(B);
%三阶矩（偏差）
sum=0.0;
for i=1:m
    for j=1:n
        sum=sum+(R(i,j)-Rmean)^3;
    end
end
Rske=(sum/(m*n))^(1/3);
sum=0.0;
for i=1:m
    for j=1:n
        sum=sum+(G(i,j)-Gmean)^3;
    end
end
Gske=(sum/(m*n))^(1/3);
sum=0.0;
for i=1:m
    for j=1:n
        sum=sum+(B(i,j)-Bmean)^3;
    end
end
Bske=(sum/(m*n))^(1/3);
RGB = [Rmean,Gmean,Bmean,Rmean-Gmean,Rmean-Bmean,Gmean-Bmean,Rstd,Gstd,Bstd,Rske,Gske,Bske];
RGB = abs(RGB);
% RGB = -1*sign(RGB).*log10(abs(RGB));
    total_RGB_Features = [total_RGB_Features;RGB];
end
end

