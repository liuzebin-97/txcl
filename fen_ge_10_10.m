clear;clc;
image=imread('4.jpg');%��ȡͼ��
imshow(image);
hsi_image=hsi(image);%ת��ΪHSIͼ��
% I=rgb2gray(image);
% imshow(I);
load dat H S I;%����HSIͼ���и���ͨ������
% imshow(H);%��ʾHͨ��ͼ��
block_10_10=[];%�½�һ��*��*�ľ���

%% 10*10����
for i=16:32:304
    for j=12:24:228
        block=[];%�½�һ������
        for m=i-15:i+16
            for n=j-11:j+12
                block=[block H(n,m)];
            end
        end
         block_std2=std2(block(:));%����32*24��ķ���
         block_10_10=[block_10_10 block_std2];%����ͼ������
    end
end

block_post=reshape(block_10_10,10,10);%ȷ��10*10����
% block_post=round(block_post);
figure;
imshow(block_post);

%% ��ͼ���Ϊ10*10
M=10;N=10;
[m,n,c]=size(H);
xb=round(m/M)*M;
yb=round(n/N)*N;%�ҵ��ܱ�������M,N
rgb=imresize(H,[xb,yb]);
[m,n,c]=size(H);
count =1;
for i=1:M
    for j=1:N
        % 1�� �ֿ�
        block_100 = rgb((i-1)*m/M+1:m/M*i,(j-1)*n/N+1:j*n/N,:); % ͼ��ֳɿ�
   %д��Ҫ��ÿһ��Ĳ���
      subplot(M,N,count);
      a=block_post(i,j);
      imshow(block_100);
      title(a);
        count = count+1;
    end
end
[td1,td2,td3]=tidu(block_post);%����������ݶ�
















