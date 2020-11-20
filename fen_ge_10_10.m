clear;clc;
image=imread('4.jpg');%读取图像
imshow(image);
hsi_image=hsi(image);%转换为HSI图像
% I=rgb2gray(image);
% imshow(I);
load dat H S I;%保存HSI图像中各个通道分量
% imshow(H);%显示H通道图像
block_10_10=[];%新建一个*×*的矩阵

%% 10*10窗口
for i=16:32:304
    for j=12:24:228
        block=[];%新建一个矩阵
        for m=i-15:i+16
            for n=j-11:j+12
                block=[block H(n,m)];
            end
        end
         block_std2=std2(block(:));%计算32*24块的方差
         block_10_10=[block_10_10 block_std2];%生成图像数组
    end
end

block_post=reshape(block_10_10,10,10);%确定10*10矩阵
% block_post=round(block_post);
figure;
imshow(block_post);

%% 将图像分为10*10
M=10;N=10;
[m,n,c]=size(H);
xb=round(m/M)*M;
yb=round(n/N)*N;%找到能被整除的M,N
rgb=imresize(H,[xb,yb]);
[m,n,c]=size(H);
count =1;
for i=1:M
    for j=1:N
        % 1） 分块
        block_100 = rgb((i-1)*m/M+1:m/M*i,(j-1)*n/N+1:j*n/N,:); % 图像分成块
   %写上要对每一块的操作
      subplot(M,N,count);
      a=block_post(i,j);
      imshow(block_100);
      title(a);
        count = count+1;
    end
end
[td1,td2,td3]=tidu(block_post);%计算各方向梯度
















