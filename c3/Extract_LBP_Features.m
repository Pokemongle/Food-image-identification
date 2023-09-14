function total_LBP_Features = Extract_LBP_Features(data)
%提取LBP特征
% [~,~,totalNum] = size(data);
[~,totalNum] = size(data);
total_LBP_Features = [];
for i = 1 : totalNum
    % Extract unnormalized LBP features
    image = rgb2gray(data(i).image);
    H1 = [0 -1 0;-1 5 -1 ;0 -1 0];
    image2 = imfilter(image,H1);%Laplacian锐化滤波
    LBP_Features = extractLBPFeatures(image2,'CellSize',[16,16],'Upright',true);
    % Reshape the LBP features into a number of neighbors -by- number of cells array to access histograms for each individual cell.
    numNeighbors = 8;
    numBins = numNeighbors*(numNeighbors-1)+3;
    LBP_CellHists = reshape(LBP_Features,numBins,[]);
    % Normalize each LBP cell histogram using L1 norm.
    LBP_CellHists = bsxfun(@rdivide,LBP_CellHists,sum(LBP_CellHists));
    % Reshape the LBP features vector back to 1-by- N feature vector.
    LBP_Features = reshape(LBP_CellHists,1,[]);
    total_LBP_Features = [total_LBP_Features;LBP_Features];
end
end


