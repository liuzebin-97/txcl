%% �����ݶ�����
clear;clc;
I=imread('4.jpg');%��ȡͼ��
imshow(I);
HSI_I=hsi(I);%HSIͼ��任
load dat H S I;
block_5_5=[];%�½�10*5����
block_H_mean_10_5=[];
block_S_mean_10_5=[];
block_I_mean_10_5=[];

%% 10*5���ھ�ֵ�˲�
for i=3:5:318
    for j=5:10:235  %�������ĵ�λ��
        block_H=[];%ÿ�����ĵ�H�Ĵ���
        block_S=[];%ÿ�����ĵ�S�Ĵ���
        block_I=[];%ÿ�����ĵ�I�Ĵ���
        for m=i-2:i+2
            for n=j-4:j+5
                block_H=[block_H H(n,m)]; 
                block_S=[block_S S(n,m)]; 
                block_I=[block_I I(n,m)]; %����HSI���ڵ�10*5����
            end
        end
        block_H_mean=mean(block_H(:));
        block_H_mean_10_5=[block_H_mean_10_5 block_H_mean];
        block_S_mean=mean(block_S(:));
        block_S_mean_10_5=[block_S_mean_10_5 block_S_mean];
        block_I_mean=mean(block_I(:));
        block_I_mean_10_5=[block_I_mean_10_5 block_I_mean];%10*5���ڵ�HSI��ֵ
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







