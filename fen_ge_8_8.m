clear;clc

RGB_Image=imread('��·ͼ��1.jpg');%��ȡͼ��
% HSV_Image=rgb2hsv(RGB_Image);
% HSV_Image_V=HSV_Image(:,:,3);
HSV_Image_V=RGB_Image(:,:,3);
HSV_Image_V=hsi(RGB_Image);
HSV_Image_V=HSV_Image_V(:,:,1);
block_avg_V_30_40=[];%��¼ƽ��ֵ����
imshow(HSV_Image_V);
for i=20:40:300
    for j=15:30:225
        block_sample_30_40=[];
        for m=i-19:i+20
            for n=j-14:j+15
                block_sample_30_40=[block_sample_30_40 HSV_Image_V(n,m)];
            end
        end
        block_sample_30_40_avge=mean(block_sample_30_40(:));%10*10�Ŀ�ȡƽ��ֵ
        block_avg_V_30_40=[block_avg_V_30_40 block_sample_30_40_avge];%����ͼ������
    end
    
end
            
HSV_Image_V_30_40_Avge_Post=reshape(block_avg_V_30_40,8,8);%����8*8����
% HSV_Image_V_30_40_Avge_Post=round(HSV_Image_V_30_40_Avge_Post);
% HSV_Image_V_30_40_Avge_Post(HSV_Image_V_30_40_Avge_Post>)
figure
imshow(HSV_Image_V_30_40_Avge_Post)

%% 8*8��
M=8;N=8;
[m,n,c]=size(RGB_Image);
xb=round(m/M)*M;yb=round(n/N)*N;%�ҵ��ܱ�������M,N
rgb=imresize(RGB_Image,[xb,yb]);
[m,n,c]=size(RGB_Image);
count =1;
for i=1:M
    for j=1:N
        % 1�� �ֿ�
        block = rgb((i-1)*m/M+1:m/M*i,(j-1)*n/N+1:j*n/N,:); % ͼ��ֳɿ�
   %д��Ҫ��ÿһ��Ĳ���
     subplot(M,N,count);
     a=HSV_Image_V_30_40_Avge_Post(i,j);
     imshow(block);
     title(a);
        count = count+1;
    end
end










    