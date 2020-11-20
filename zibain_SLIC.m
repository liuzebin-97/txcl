clear;clc;
I=imread('2.jpg');
I=hsi(I);
%% 初始化
s=15;
errth=10^-2;
wDs=0.5^2;
%% 划分栅格
m=size(I,1);
n=size(I,2);

%% 计算栅格顶点与中心的坐标
h=floor(m/s);%行
w=floor(n/s);%列
rowR=floor((m-h*s)/2); %多余部分首尾均分,向下取整
colR=floor((n-w*s)/2);
rowStart=(rowR+1):s:(m-s+1);
rowStart(1)=1;
rowEnd=rowStart+s;
colStart=(colR+1):s:(n-s+1);
colStart(1)=1;
colEnd=colStart+s;
colEnd(1)=colR+s;
colEnd(end)=n;
%% 确定栅格中心点坐标
rowC=floor((rowStart+rowEnd-1)/2);
colC=floor((colStart+colEnd-1)/2);
%% 栅格
temp=zeros(m,n);%240*320全黑
temp(rowStart,:)=1;
temp(:,colStart)=1;
for i=1:h
    for j=1:w
        temp(rowC(i),colC(j))=1;
    end
end
imshow(temp);

%% 转换图像
Y=I(:,:,1);
f1=fspecial('sobel');
f2=f1';
gx=imfilter(Y,f1);
gy=imfilter(Y,f2);
G=sqrt(gx.^2+gy.^2); %sobel算子滤波
%%  选择栅格中心点3*3邻域中梯度最小点作为起始点
rowC_std=repmat(rowC',[1,w]);
colC_std=repmat(colC,[h,1]);
rowC=rowC_std;
colC=colC_std;
for i=1:h
      for j=1:w
        block=G(rowC(i,j)-1:rowC(i,j)+1,colC(i,j)-1:colC(i,j)+1);
        [minVal,idxArr]=min(block(:));%输出最小值以及位置
        jOffset=floor((idxArr(1)+2)/3);
        iOffset=idxArr(1)-3*(jOffset-1);
        rowC(i,j)=rowC(i,j)+iOffset;
        colC(i,j)=colC(i,j)+jOffset;
      end
end
temp1=zeros(m,n);%240*320全黑
 temp1(rowStart,:)=1;
 temp1(:,colStart)=1;
for i=1:h
    for j=1:w
        temp1(rowC(i,j),colC(i,j))=1;
    end
end
imshow(temp1);














