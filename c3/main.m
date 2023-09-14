close all;clear;clc;
image = imread('./Select/2+1_4.jpg');
figure,subplot(321),imshow(image,[]),title("original");
[Height,Width,rgb] = size(image);
mask_1 = RGBtoSelect(image);
figure(1),imshow(mask_1,[]),title("mask_1");
mask_2 = SegtoSelect(image);
figure(2),imshow(mask_2,[]),title("mask_2")
mask = mask_1 & mask_2;
mask = bwareaopen(mask,Height*2);
figure(3),imshow(mask,[]),title("mask");
[angle1] = gyrate(mask);
if(abs(angle1)<20)
   mask = imrotate(mask,-angle1,'bilinear');
   image = imrotate(image,-angle1,'bilinear');
end
figure(4),imshow(mask,[]),title("Final Mask");
figure(5),imshow(image,[]),title("Final image");
%%
num_x_1 = sum(mask');num_y_1 = sum(mask);
W = max(num_x_1(:));%圆盘在旁边的情况 偏大 ； 平时 偏小
H = max(num_y_1(:));%透视严重 偏小
thr = 0.5*W;flag = 0;plate_end_y = Height;
for i = 1:Height
    switch flag
        case 0
            if(num_x_1(1,i)>thr)
                flag = 1;
                plate_start_y = i;
            end
        case 1
            if(num_x_1(1,i)<thr)
                flag = 2;
                food_start_y = i;
            end
        case 2
            if(num_x_1(1,i)>thr)
                flag = 3;
                food_end_y = i;
            end
        case 3
            if(num_x_1(1,i)<0.1*Height)
                plate_end_y = i;
                flag = 4;
            end
        otherwise
            break;
    end
end
H_1 = plate_end_y-plate_start_y;
if(H_1 > H && abs(H_1-H)<0.1*H)
    H = H_1;
end
h = food_end_y-food_start_y;
if(h<0.3*H&&h>0.5*h)
    food_end_y = food_start_y + 0.4*H;
    h = 0.4*H;
end
%%
delta_h = food_start_y-plate_start_y;
delta_h_1 = 0.9*H;
if(delta_h > delta_h_1)
    delta_h = delta_h_1;
end
thr = 0.4*H;
for j = 1:Width
    if(num_y_1(1,j)>thr)
        plate_start_x = j;
        break;
    end
end
for j = Width:-1:1
    if(num_y_1(1,j)>thr )
        plate_end_x = j;
        break;
    end
end
W_1 = plate_end_x-plate_start_x;
if(W_1 > 0.7* W && W_1 <1.3*W)
    W = W_1;
else
    plate_end_x = plate_start_x + W;
end
%%
pos_y = ceil(h.*0.1+food_start_y);
w = 0;
 while ((w < 0.15*W || w > 0.3*W)&&(pos_y<food_end_y))
   [food_start_x,food_end_x,w] = Findwidth(pos_y,mask,h,plate_start_y);
   if(w>0.3*W && w < 0.6*W)
       w = w./2;
   end
   if(w>0.6*W && w <0.9* W)
       w = w ./3;
   end
   pos_y = ceil(pos_y + h*0.1);
   if(food_start_x>plate_start_x+w && food_start_x < plate_end_x - w)
       food_start_x = food_start_x - w-delta_h;
       food_end_x = food_start_x + w;
   end
 end

%%
ratio = W./H;
if(food_start_x < plate_start_x + delta_h*2)
    food_start_x = plate_start_x + 2*delta_h;
end
x1 = food_start_x;y = food_start_y+0.05*h;
x2 = food_start_x + w + delta_h;
x3 = food_start_x + 2*w + 2*delta_h;

if(x3+w>plate_end_x-delta_h ||x3+w<plate_end_x-1.5*ratio*delta_h )
    x3 = plate_end_x-delta_h*0.6-w;
    x2 = (x3 + x1)./2-delta_h*0.2;
end

x4 = x2+0.3*w;
y4 = food_end_y+delta_h;
w = 0.9*w;
h = 0.9*h;
% 
% figure,imshow(image);
% rectangle('Position',[x1,y,w,h],'edgecolor','b');
% rectangle('Position',[x2,y,w,h],'edgecolor','b');
% rectangle('Position',[x3,y,w,h],'edgecolor','b');
% rectangle('Position',[x4,y4,plate_end_x-delta_h*0.7-x4,plate_end_y-delta_h*0.7-y4],'edgecolor','b');
c1 = imcrop(image,[x1,y,w,h]);
c2 = imcrop(image,[x2,y,w,h]);
c3 = imcrop(image,[x3,y,w,h]);
testData = struct();
testData(1).image = im2double(imresize(c1,[700 700]));
testData(2).image = im2double(imresize(c2,[700 700]));
testData(3).image = im2double(imresize(c3,[700 700]));
% imwrite(c1,'1.png');
% imwrite(c2,'2.png');
% imwrite(c3,'3.png');
rice = imcrop(image,[x4,y4,plate_end_x-delta_h*0.5-x4,plate_end_y-delta_h*0.7-y4]);
rice_k = HowManyRice(rice);
% imwrite(rice,'4.png');
testData(4).image = im2double(imresize(rice,[700 700]));
mask(0.9*y:ceil(y+h*1.1),0.9*x1:ceil(x1+w*1.1))=1;
mask(0.9*y:ceil(y+h*1.1),0.9*x2:ceil(x2+w*1.1))=1;
mask(0.9*y:ceil(y+h*1.1),0.9*x3:ceil(x3+w*1.1))=1;
mask(y4:ceil(plate_end_y-delta_h*0.7),x4:ceil(plate_end_x-delta_h*0.5))=1;
mask(1:plate_start_y*1.1,:) = 1;
mask(plate_end_y*0.95:Height,:) = 1;
mask(:,1:plate_start_x*1.1,:) = 1;
rice_k = HowManyRice(rice);
%mask(:,plate_end_x:Width) = 1;
    %subplot(223),imshow(mask,[]);title("mask_new")
%%
bw = PreProcess(mask);
[B,L] = bwboundaries(bw,'noholes');%只关注外边界
% figure,imshow(label2rgb(L,@jet,[.5 .5 .5]))%标记矩阵L转化为RGB图像
stats = regionprops(L,'Area','Centroid');%测量图像区域的属性(实际像素数和质心)
threshold = 0.29;
Flag = 0;
for k = 1:length(B)
	boundary = B{k};
	delta_sq = diff(boundary).^2;
	perimeter = sum(sqrt(sum(delta_sq,2)));
	area = stats(k).Area;
	metric = 4*pi*area/perimeter^2;
	if metric > threshold 
        R1 = perimeter./(2*pi);R2 = sqrt(area./pi);
           R = (R1+R2)./2; centroid = stats(k).Centroid;
          
           x = ceil(centroid(1)-0.5*R);y_1 = ceil(y+1.2*R);
           y = ceil(centroid(2)-0.5*R);x_1 = ceil(x+1.2*R);
        if(R<0.3*Width && (x>plate_end_x || y>food_end_y)&&area > 0.7*h*w)
           Flag = 1;
          break;
        end
    end 
end
if(Flag&&R<0.3*Width)
    R = ceil(R);
    x = ceil(centroid(1)-0.5*R);y_1 = ceil(y+1.2*R);
    y = ceil(centroid(2)-0.5*R);x_1 = ceil(x+1.2*R);
%     figure,imshow(mask,[]),title("mask to select circle");
%     rectangle('Position',[x,y,1.2*R,1.2*R],'edgecolor','b');
    %mask(x:x_1,y:y_1)=0;
    %subplot(223),imshow(mask,[]);title("mask_new")
    c4 = imcrop(image,[x,y,1.2*R,1.2*R]);
%     subplot(326),imshow(c4),title("food 4");
    [h_4,w_4,rgb] = size(c4);
    mask_c4 = ones(h_4,w_4);
    for i = 1:ceil(0.1*h_4)
        mask_c4(i,:) = 0;
        mask_c4(h_4-i+1,:) = 0;
        mask_c4(:,i) = 0;
        mask_c4(:,w_4-i+1) = 0;
    end
    c4_1 = c4.*uint8(mask_c4);
%     imwrite(c4,'5.png');
    testData(5).image = im2double(imresize(c4_1,[700 700]));
    testData(6).image = im2double(imresize(c4,[700 700]));
%     figure(10),imshow(c4),title("food 4");
end

%%
fileRoot = './lib';
imageFormat = 'png';
[trainData,trainLabels] = ReadDataSet(fileRoot,imageFormat);
% [trainFeatures1,testFeatures1] = ExtractFeatures(trainData,testData,'RGB');
% [trainFeatures2,testFeatures2] = ExtractFeatures(trainData,testData,'SURF');
% [trainFeatures3,testFeatures3] = ExtractFeatures(trainData,testData,'LBP');
% trainFeatures = [trainFeatures1 trainFeatures2 trainFeatures3];
% testFeatures = [testFeatures1 testFeatures2 testFeatures3];
% [predictIndex] = SVM_Classify(trainFeatures,trainLabels,testFeatures);

[trainFeatures1,testFeatures1] = ExtractFeatures(trainData,testData,'RGB');
[predictIndex1] = SVM_Classify(trainFeatures1,trainLabels,testFeatures1);
[trainFeatures2,testFeatures2] = ExtractFeatures(trainData,testData,'HSV');
[predictIndex2] = SVM_Classify(trainFeatures2,trainLabels,testFeatures2);
[trainFeatures3,testFeatures3] = ExtractFeatures(trainData,testData,'LBP');
[predictIndex3] = SVM_Classify(trainFeatures3,trainLabels,testFeatures3);
[trainFeatures4,testFeatures4] = ExtractFeatures(trainData,testData,'SURF');
[predictIndex4] = SVM_Classify(trainFeatures4,trainLabels,testFeatures4);
[trainFeatures5,testFeatures5] = ExtractFeatures(trainData,testData,'Hu');
[predictIndex5] = SVM_Classify(trainFeatures5,trainLabels,testFeatures5);

% 
% [result1] = getresult(predictIndex1);
% [result2] = getresult(predictIndex2);
% [result3] = getresult(predictIndex3);
% [result4] = getresult(predictIndex4);
% [result5] = getresult(predictIndex5);
finalIndex = predictIndex1;
[num,~] = size(finalIndex);
for i = 1:num
    if (predictIndex2(i,1) == predictIndex3(i,1))
        finalIndex(i,1) = predictIndex2(i,1);
    else 
        if (predictIndex2(i,1) == predictIndex4(i,1))
        finalIndex(i,1) = predictIndex2(i,1);
        else 
            if (predictIndex2(i,1) == predictIndex5(i,1))
        finalIndex(i,1) = predictIndex2(i,1);
            else 
                if (predictIndex3(i,1) == predictIndex5(i,1))
        finalIndex(i,1) = predictIndex3(i,1);
                end
            end
        end
    end
end

if finalIndex(3,1) == 16
    finalIndex(3,1) = 17;
end
    finalIndex(4,1) = 16;

% [num,~] = size(result1);
% for i=1:num
% disp(strcat(num2str(i),':',result1(i,1)));
% end
% 
% [num,~] = size(result2);
% for i=1:num
% disp(strcat(num2str(i),':',result2(i,1)));
% end
% 
% [num,~] = size(result3);
% for i=1:num
% disp(strcat(num2str(i),':',result3(i,1)));
% end
% 
% [num,~] = size(result4);
% for i=1:num
% disp(strcat(num2str(i),':',result4(i,1)));
% end

[result] = getresult(finalIndex,rice_k);
[num,~] = size(result);
if num == 4
    for i=1:num
    % disp(strcat(num2str(i),':',result(i,1)));
    subplot(3,2,i+1),imshow(testData(i).image),title(result(i,1));
    end
else
    for i=1:num-2
    % disp(strcat(num2str(i),':',result(i,1)));
    subplot(3,2,i+1),imshow(testData(i).image),title(result(i,1));
    end
    subplot(3,2,num),imshow(testData(num).image),title(result(num-1,1));
end




