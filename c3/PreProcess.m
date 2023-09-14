function bw = PreProcess(mask)
[Height,Width] = size(mask);
bw = ~mask;

Thr = ceil(Height*0.1*0.1*Width);
bw = bwareaopen(bw,Thr);
%bw = imfill(bw,'holes');
end