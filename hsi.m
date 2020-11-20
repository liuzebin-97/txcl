%转换为HSI图像
function hsi=hsi(Image)
Image=im2double(Image);
R=Image(:,:,1);
G=Image(:,:,2);
B=Image(:,:,3);

st=0.5*((R-G)+(R-B));%theta分子
sx=sqrt((R-G).^2+(R-B).*(G-B));%theta分母
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
title('H分量');
figure
imshow(S);
title('S分量');
figure
imshow(I);
title('I分量');
save dat H S I;
load dat H S I;
hsi=cat(3,H,S,I);