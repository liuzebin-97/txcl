%% ����Ҷ�任
clear;clc;
I=imread('C:\Users\liuzebin\Desktop\��·.bmp');
I=rgb2gray(I);%�Ҷ�
I=im2double(I);%����ת��
F=fft2(I);%����Ҷ�任
F=fftshift(F);%�Ը���Ҷ�任���ͼ���������ת��
F=abs(F);%����Ҷ�任��ģ
T=log(F+1);
figure;
imshow(T,[]);