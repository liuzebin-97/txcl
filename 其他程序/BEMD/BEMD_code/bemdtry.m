z = imread('C:\Users\liuzebin\Desktop\µÀÂ·.bmp');
hsi=rgb2hsi(z);
%imshow(hsi)
% z=z(:,:,2);
% hsi=hsi(:,:,2); 
% figure;imshow(hsi)
imf = bemd(hsi);