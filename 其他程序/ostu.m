%% OSTU聚类
% I = imread('道路.bmp');
% I=I(:,:,2);
img = imread('prescan.png');
img=double(img(:,:,1));
[row,col]=size(img);
img=img(col/3:end,:);
subplot(1,2,1),imshow(img,[]);
data = img(:);
%分成4类
[center,U,obj_fcn] = fcm(data,4);
[~,label] = max(U); %找到所属的类
%变化到图像的大小
img_new = reshape(label,size(img));
subplot(1,2,2),imshow(img_new,[]);
 %% 中值滤波
 clear;clc;
I=imread('prescan.png');      %读取保存路径下的图片
I=rgb2gray(I);
J=imnoise(I,'salt & pepper',0.02);
subplot(331),imshow(I);title('原图像');
subplot(332),imshow(J);title('添加椒盐噪声图像');
k1=medfilt2(J);               %进行3*3模板中值滤波
k2=medfilt2(J,[5,5]);       %进行5*5模板中值滤波
k3=medfilt2(J,[7,7]);       %进行7*7模板中值滤波
k4=medfilt2(J,[9,9]);       %进行9*9模板中值滤波
subplot(333),imshow(k1);title('3*3模板中值滤波');
subplot(334),imshow(k2);title('5*5模板中值滤波 ');
subplot(335),imshow(k3);title('7*7模 板中值滤波');
subplot(336),imshow(k4);title('9*9 模板中值滤波');
%% sobel算子
% K=fspecial('sobel');     %选择sobel算子
% J1=filter2(K,k1);            %卷积运算
BW1=edge(k1,'sobel'); 
subplot(337),imshow(BW1);title('sobel算子检测图');
BW2=edge(k1,'canny'); %用Canny算子进行边缘检测
subplot(338),imshow(BW2);title('Canny算子检测图');
BW3=edge(k1,'roberts');%用Roberts算子进行边缘检测
subplot(339),imshow(BW3);title('Roberts算子检测图');
%% 