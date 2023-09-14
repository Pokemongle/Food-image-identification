function [rice_k] = HowManyRice(rice)
I = rgb2gray(rice);
BW=edge(I,'canny'); %��canny���ӽ��б�Ե���
b=[0 1 0;1 1 1;0 1 0];
I1 = imdilate(BW,b);
I1 = imdilate(I1,b);
se1 = strel('rectangle',[15 15]);
se2 = strel('disk',5);
I2 = imclose(I1,se1);
I2 = imopen(I2,se2);
I2 = imclose(I2,se2);
I2 = imfill(I2,'holes');
%figure
%subplot(131),imshow(I,[]);
%subplot(132),imshow(I1,[]);
%subplot(133),imshow(I2,[]);

[B,L] = bwboundaries(I2,'noholes');%ֻ��ע��߽�
%figure,imshow(label2rgb(L,@jet,[.5 .5 .5]))%��Ǿ���Lת��ΪRGBͼ��

stats = regionprops(L,'Area','Centroid');%����ͼ�����������(ʵ��������������)

area_max = 0;rice_k = 0;
for k = 1:length(B)
	area = stats(k).Area;
	if(area > area_max)
        area_max = area;
    end
end
[H_rice,W_rice] = size(I2);
AREA = H_rice*W_rice;
if(area_max<AREA*0.5)
    rice_k = 1;
else
    rice_k = 2;
end
end