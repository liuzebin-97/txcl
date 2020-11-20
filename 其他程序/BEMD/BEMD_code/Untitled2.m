%% 傅里叶变换
clear;clc;
I=imread('C:\Users\liuzebin\Desktop\道路.bmp');
I=rgb2gray(I);%灰度
I=im2double(I);%类型转换
F=fft2(I);%傅里叶变换
F=fftshift(F);%对傅里叶变换后的图像进行象限转换
F=abs(F);%求傅里叶变换的模
T=log(F+1);
figure;
imshow(T,[]);