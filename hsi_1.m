%% HSI图像变换
Image=imread('道路.bmp');
% Image=rgb2gray(Image);
imshow(Image);
Image=im2double(Image);
R=Image(:,:,1);
G=Image(:,:,2);
B=Image(:,:,3);
st=0.5*((R-G)+(R-B));%theta分子
sx=sqrt((R-G).^2+(R-B).*(G-B));%theta分母
theta=acos(st./sx);
H=theta;
H(B>G)=2*pi-H(B>G);
H=H/(2*pi);
min_RGB=min(min(R,G),B);
RGB=R+G+B;
S=1-3.*min_RGB./RGB;
H(S==0)=0;
I=RGB/3;
imshow(H);
title('H分量');
figure
imshow(S);
title('S分量');
figure
imshow(I);
title('I分量');
hsi=cat(3,H,S,I);

%% 滑动邻域操作
H1=nlfilter(H,[3 3],'std2');%3*3窗口方差滤波
fun=@(x) max(x(:));
H2=nlfilter(H,[3 3],fun);
H3=nlfilter(H,[6 6],fun);%不同大小窗口最大值滤波
figure
imshow(H1);title('H1');
figure
imshow(H2);title('H2');
figure
imshow(H3);title('H3');
%% 消除NaN数据
% z=H1(find(~isnan(H1)));
% i=find(~isnan(H1));
H1(isnan(H1))=1;

%% 横纵除8
[i,j]=size(H);
cols=i/8;%列
rows=j/8;%行
%% 提取8*8矩阵
%窗口大小30*40
q=imread('prescan.png');
% q=rgb2gray(q);
fun=@(blk_struct) std2(blk_struct.data);  
I1=blkproc(q,[100 100],fun);
fun=@(block_struct) std2(bolck_struct.data);
I2=blockproc(q,[32 32],fun);
fun=@(block_struct) block_struct.data(:,:,[3 1 2]);
blockproc(q,[100 100],fun,'Destination','brg_prppers.tif');

figure,
subplot(131),imshow(I1);
subplot(132),imshow(I2,[]);
subplot(133),imshow('brg_prppers.tif');














