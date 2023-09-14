function [angle1] = gyrate(I)
%gyrate函数              使倾斜的图像翻转过来
%参数I输入图像
%参数dw输出图像
bw = I;
BW=edge(bw,'canny');
%imshow(BW);title('canny 边界图像');
[H,T,R]=hough(BW);
%figure,imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
%xlabel('\theta'),ylabel('\rho');
%axis on, axis normal,hold on;
P=houghpeaks(H,4,'threshold',ceil(0.3*max(H(:))));
%x=T(P(:,2)); y = R(P(:,1));
%plot(x,y,'s','color','white');
lines=houghlines(BW,T,R,P,'FillGap',50,'MinLength',7);
%figure,imshow(BW),title('直线标识图像');
max_len = 0;
%hold on;
for k=1:length(lines)
    xy=[lines(k).point1;lines(k).point2];
    % 标出线段
    %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    % 标出线段的起始和终端点
    %plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    len=norm(lines(k).point1-lines(k).point2);
    Len(k)=len;
    if (len>max_len)
        max_len=len;
        xy_long=xy;
    end
end
% 强调最长的部分
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');
[L1 Index1]=max(Len(:));
% 最长线段的起始和终止点
x1=[lines(Index1).point1(1) lines(Index1).point2(1)];
y1=[lines(Index1).point1(2) lines(Index1).point2(2)];
% 求得线段的斜率
K1=-(lines(Index1).point1(2)-lines(Index1).point2(2))/...
    (lines(Index1).point1(1)-lines(Index1).point2(1));
angle1=atan(K1)*180/pi;
angle1
A = imrotate(I,-angle1,'bilinear');% imrate 是逆时针的所以取一个负号
end
%figure,imshow(A);