function [trainData,trainLabels,testData] = ReadDataSet(fileRoot,imageFormat)
%读取数据集
dataSetFiles = dir(strcat(fileRoot,'/s*'));
classNum = length(dataSetFiles);
trainLabels = [];
%testLabels = [];
trainData= struct();
testData = struct();
for i = 1 : classNum
    imageData = dir(strcat(fileRoot,'/s',string(i),'/*.',imageFormat));
    trainNum = length(imageData);
    for j = 1 : trainNum
%         image = im2double(rgb2gray(imread(strcat(fileRoot,'/',dataSetFiles(i).name,'/',imageData(j).name))));
          image = im2double(imresize(imread(strcat(fileRoot,'/s',string(i),'/',imageData(j).name)),[700 700]));
        trainData((trainNum)*(i-1)+j).image = image;
        trainLabels = [trainLabels;i];
    end
end
% %  imageData = dir(strcat(fileRoot,'/test/','/*.',imageFormat));
%  imageData = dir(strcat('*.',imageFormat));
%  testNum = length(imageData);
%     for j = 1: testNum-1
% %         image = im2double(rgb2gray(imread(strcat(fileRoot,'/',dataSetFiles(i).name,'/',imageData(j).name))));
% %           image = im2double(imresize(imread(strcat(fileRoot,'/test/',string(j),'.',imageFormat)),[400 400]));
%             image = im2double(imresize(imread(strcat(string(j),'.',imageFormat)),[700 700]));
% %         testData(:,:,j) = image;
%         testData(j).image = image;
%     end
end


