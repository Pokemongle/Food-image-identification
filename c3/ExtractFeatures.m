function [trainFeatures,testFeatures] = ExtractFeatures(trainData,testData,method)
%提取特征
switch method
    case 'LBP'
        trainFeatures = Extract_LBP_Features(trainData);
        testFeatures = Extract_LBP_Features(testData);
    case 'Hu'
        trainFeatures = Extract_Hu_Features(trainData);
        testFeatures = Extract_Hu_Features(testData);
    case 'SURF'
        trainFeatures = Extract_SURF_Features(trainData);
        testFeatures = Extract_SURF_Features(testData);
    case 'RGB'
        trainFeatures = Extract_RGB_Features(trainData);
        testFeatures = Extract_RGB_Features(testData);
    case 'HSV'
        trainFeatures = Extract_HSV_Features(trainData);
        testFeatures = Extract_HSV_Features(testData);
    otherwise
        disp("'method' should be 'LBP' or 'Hu' or 'SURF' or 'RGB' or 'HSV' ");
end
[~,dimension] = size(trainFeatures);
if dimension > 20
    [trainFeatures,testFeatures] = PCA_DimensionReduct(trainFeatures,testFeatures,20);
end
end

