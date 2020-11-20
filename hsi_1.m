%% HSIͼ��任
Image=imread('��·.bmp');
% Image=rgb2gray(Image);
imshow(Image);
Image=im2double(Image);
R=Image(:,:,1);
G=Image(:,:,2);
B=Image(:,:,3);
st=0.5*((R-G)+(R-B));%theta����
sx=sqrt((R-G).^2+(R-B).*(G-B));%theta��ĸ
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
title('H����');
figure
imshow(S);
title('S����');
figure
imshow(I);
title('I����');
hsi=cat(3,H,S,I);

%% �����������
H1=nlfilter(H,[3 3],'std2');%3*3���ڷ����˲�
fun=@(x) max(x(:));
H2=nlfilter(H,[3 3],fun);
H3=nlfilter(H,[6 6],fun);%��ͬ��С�������ֵ�˲�
figure
imshow(H1);title('H1');
figure
imshow(H2);title('H2');
figure
imshow(H3);title('H3');
%% ����NaN����
% z=H1(find(~isnan(H1)));
% i=find(~isnan(H1));
H1(isnan(H1))=1;

%% ���ݳ�8
[i,j]=size(H);
cols=i/8;%��
rows=j/8;%��
%% ��ȡ8*8����
%���ڴ�С30*40
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














