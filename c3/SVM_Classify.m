function [predictIndex] = SVM_Classify(trainFeatures,trainLabels,testFeatures)
%SVM分类器
classifer = fitcecoc(trainFeatures,trainLabels);
[predictIndex,~] = predict(classifer,testFeatures);
end

