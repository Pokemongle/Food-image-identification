function [trainFeatures,testFeatures] = PCA_DimensionReduct(trainFeatures,testFeatures,dimensionReduct)
%PCA降维
% 主成分分析(PCA)， 是一种统计方法。通过正交变换将一组可能存在相关性的变量转换为一组线性不相关的变量，转换后的这组变量叫主成分。

% 最大方差理论：在信号处理中认为信号具有较大的方差，噪声有较小的方差，信噪比就是信号与噪声的方差比，越大越好。

[totalTrainNum,~] = size(trainFeatures);
[totalTestNum,~] = size(testFeatures);
[~,score,~,~] = pca([trainFeatures;testFeatures]);
trainFeatures = score(1:totalTrainNum,1:dimensionReduct);
testFeatures = score(totalTrainNum+1:totalTrainNum+totalTestNum,1:dimensionReduct);
end

