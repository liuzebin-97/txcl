clear;
clc;
imIn = imread('cameraman.tif');
[imOut,C,U,iter] = My_FLICM( imIn,5);
figure
subplot(1, 2, 1), imshow(imIn, [0 255]), title('‘≠Õº');
subplot(1, 2, 2),imshow(uint8(imOut),[0 255]), title('æ€¿‡Õº');