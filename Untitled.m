%% 计算梯度特征
clear;clc;
I=imread('4.jpg');%读取图像
imshow(I);
HSI_I=hsi(I);%HSI图像变换
load dat H S I;
block_5_5=[];%新建10*5窗口
block_H_mean_10_5=[];
block_S_mean_10_5=[];
block_I_mean_10_5=[];

%% 10*5窗口均值滤波
for i=3:5:318
    for j=5:10:235  %窗口中心点位置
        block_H=[];%每个中心点H的窗口
        block_S=[];%每个中心点S的窗口
        block_I=[];%每个中心点I的窗口
        for m=i-2:i+2
            for n=j-4:j+5
                block_H=[block_H H(n,m)]; 
                block_S=[block_S S(n,m)]; 
                block_I=[block_I I(n,m)]; %创建HSI窗口的10*5窗口
            end
        end
        block_H_mean=mean(block_H(:));
        block_H_mean_10_5=[block_H_mean_10_5 block_H_mean];
        block_S_mean=mean(block_S(:));
        block_S_mean_10_5=[block_S_mean_10_5 block_S_mean];
        block_I_mean=mean(block_I(:));
        block_I_mean_10_5=[block_I_mean_10_5 block_I_mean];%10*5窗口的HSI均值
    end
end

block_post_H=reshape(block_H_mean_10_5,24,64);
block_post_S=reshape(block_S_mean_10_5,24,64);
block_post_I=reshape(block_I_mean_10_5,24,64);
figure;
imshow(block_post_H);
title('block_post_H');
figure;
imshow(block_post_S);
title('block_post_S');
figure;
imshow(block_post_I);
title('block_post_I');







