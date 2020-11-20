%ת��ΪHSIͼ��
function hsi=hsi(Image)
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
save dat H S I;
load dat H S I;
hsi=cat(3,H,S,I);