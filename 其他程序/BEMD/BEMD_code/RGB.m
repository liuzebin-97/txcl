image=imread('C:\Users\liuzebin\Desktop\��2.jpg');
subplot(3,3,1);
imshow(image);
title('ԭͼ');
%%Rͨ��
r = image(:,:,1);
%%imshow(R)
subplot(3,3,2);
imshow(r);
title('Rͨ��ͼ��');
% imwrite(r,'C:\Users\liuzebin\Desktop\R.bmp');
%%Gͨ��
g = image(:,:,3);
subplot(3,3,3);
imshow(g);
title('Gͨ��ͼ��');
%%imshow(G)
% imwrite(g,'C:\Users\liuzebin\Desktop\G.bmp');
%%Bͨ��
b = image(:,:,3);
subplot(3,3,4);
imshow(b);
title('Bͨ��ͼ��');
%%imshow(B)
% imwrite(b,'C:\Users\liuzebin\Desktop\B.bmp');
hsi=rgb2hsi(image);
subplot(3,3,5);
imshow(hsi);
title('HSIͼ��');
h=hsi(:,:,1);
subplot(3,3,6);
imshow(h);
title('hsi��ͨ��ͼ��');
subplot(3,3,7);
imhist(r,64);
title('�Ҷ�ֱ��ͼ')
r(r>110)=255;
r(r<110)=0;
subplot(3,3,8);
imshow(r);
title('�Ҷ�ֱ��ͼ��ֵ�ָ��ͼ��')
gray=rgb2gray(image);
gray=mat2gray(gray);%�Ҷ�ͼ��
subplot(3,3,9);
imshow(gray);
title('�Ҷ�ͼ��');
gray_1=reshape(gray,1,[]);
gray_1=gray_1'-0.5*ones(76800,1);
figure;
plot(gray_1);
title('gray_1ͼ��');
X=1:1:76800;
X=X';
[imf,residual] = emd(gray_1);