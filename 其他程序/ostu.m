%% OSTU����
% I = imread('��·.bmp');
% I=I(:,:,2);
img = imread('prescan.png');
img=double(img(:,:,1));
[row,col]=size(img);
img=img(col/3:end,:);
subplot(1,2,1),imshow(img,[]);
data = img(:);
%�ֳ�4��
[center,U,obj_fcn] = fcm(data,4);
[~,label] = max(U); %�ҵ���������
%�仯��ͼ��Ĵ�С
img_new = reshape(label,size(img));
subplot(1,2,2),imshow(img_new,[]);
 %% ��ֵ�˲�
 clear;clc;
I=imread('prescan.png');      %��ȡ����·���µ�ͼƬ
I=rgb2gray(I);
J=imnoise(I,'salt & pepper',0.02);
subplot(331),imshow(I);title('ԭͼ��');
subplot(332),imshow(J);title('��ӽ�������ͼ��');
k1=medfilt2(J);               %����3*3ģ����ֵ�˲�
k2=medfilt2(J,[5,5]);       %����5*5ģ����ֵ�˲�
k3=medfilt2(J,[7,7]);       %����7*7ģ����ֵ�˲�
k4=medfilt2(J,[9,9]);       %����9*9ģ����ֵ�˲�
subplot(333),imshow(k1);title('3*3ģ����ֵ�˲�');
subplot(334),imshow(k2);title('5*5ģ����ֵ�˲� ');
subplot(335),imshow(k3);title('7*7ģ ����ֵ�˲�');
subplot(336),imshow(k4);title('9*9 ģ����ֵ�˲�');
%% sobel����
% K=fspecial('sobel');     %ѡ��sobel����
% J1=filter2(K,k1);            %�������
BW1=edge(k1,'sobel'); 
subplot(337),imshow(BW1);title('sobel���Ӽ��ͼ');
BW2=edge(k1,'canny'); %��Canny���ӽ��б�Ե���
subplot(338),imshow(BW2);title('Canny���Ӽ��ͼ');
BW3=edge(k1,'roberts');%��Roberts���ӽ��б�Ե���
subplot(339),imshow(BW3);title('Roberts���Ӽ��ͼ');
%% 