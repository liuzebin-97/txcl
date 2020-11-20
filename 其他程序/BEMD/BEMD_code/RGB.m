image=imread('C:\Users\liuzebin\Desktop\彪2.jpg');
subplot(3,3,1);
imshow(image);
title('原图');
%%R通道
r = image(:,:,1);
%%imshow(R)
subplot(3,3,2);
imshow(r);
title('R通道图像');
% imwrite(r,'C:\Users\liuzebin\Desktop\R.bmp');
%%G通道
g = image(:,:,3);
subplot(3,3,3);
imshow(g);
title('G通道图像');
%%imshow(G)
% imwrite(g,'C:\Users\liuzebin\Desktop\G.bmp');
%%B通道
b = image(:,:,3);
subplot(3,3,4);
imshow(b);
title('B通道图像');
%%imshow(B)
% imwrite(b,'C:\Users\liuzebin\Desktop\B.bmp');
hsi=rgb2hsi(image);
subplot(3,3,5);
imshow(hsi);
title('HSI图像');
h=hsi(:,:,1);
subplot(3,3,6);
imshow(h);
title('hsi分通道图像');
subplot(3,3,7);
imhist(r,64);
title('灰度直方图')
r(r>110)=255;
r(r<110)=0;
subplot(3,3,8);
imshow(r);
title('灰度直方图阈值分割处理图像')
gray=rgb2gray(image);
gray=mat2gray(gray);%灰度图像
subplot(3,3,9);
imshow(gray);
title('灰度图像');
gray_1=reshape(gray,1,[]);
gray_1=gray_1'-0.5*ones(76800,1);
figure;
plot(gray_1);
title('gray_1图像');
X=1:1:76800;
X=X';
[imf,residual] = emd(gray_1);