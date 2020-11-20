function imf=bemd(z)%m=r通道值
%if nargin~=1 
 % [filename, pathname] = uigetfile( {'*.bmp', 'Bitmap Files (*.bmp)';'*.jpg', 'Jpeg Files (*.jpg)';'*.jpeg', 'Jpeg Files (*.jpeg)'}, 'Open a image file');
 % fn=strcat(pathname,filename);
 % im=imread(fn);
%end
%x=1:120;
%y=1:110;
%[x,y]=meshgrid(y,x);
%im=40*sin(2*pi/40*x)+40*sin(2*pi/60*y)+30*sin(2*pi/14*x)+50*sin(2*pi/17*y)+190*sin(2*pi/0.2*x)+190*sin(2*pi/0.3*y);
%im=5*sin(2*pi/40*x+2*pi/60*y)+6*sin(2*pi/14*x+2*pi/17*y)+50*sin(2*pi/0.2*x+2*pi/0.3*y);
dim=size(z);
if size(dim,2)>2
    z=rgb2gray(z);
end
figure;
imshow(z);
z=imresize(z,[320,240],'bicubic');%双三次差值算法，缩放大小为320*240
i=0;
z=double(z);%uint8转化为double
figure; 
surf(z);
title('original mesh');
ch=1.4;
cw=1.4;%ch,cw:控制网格的点数是缩放后的图象大小的1/(ch*cw)
rim=z;
while 1
    if max(max(z))<8
        i=i+1;
        imf(i,:,:)=z;
        figure;imshow(z);
        surf(z);
        break;
    else
        maxs=maxsurf(z,ch,cw);
        title('maxsurf');
        mins=minsurf(z,ch,cw);
        title('minsurf');
        m=(maxs+mins)/2;%原信号的均值包络面
        z=z-m;%余项作为新信号
        sd=std(std(z));
        if sd<8
            i=i+1;
            imf(i,:,:)=z;
           figure;%imshow(z);
           surf(z);
            rim=rim-z;
            z=rim;
        end
   end
end
disp(strcat(num2str(i),'imfs was decomposed'));%将数值转换为字符串并横向连接并输出
dim=size(z);
z=zeros(dim);
z1=z;
 for j=1:i
     d=imf(j,:,:);
    [z,x,y]=size(d);
   %z1(x,y)=imf(j,:,:);

   %figure;%imshow(c)
   z=z+z1(x,y);
end
   figure;
   imshow(z);
for x=1:220
    for y = 1:220
        z2(x,y)=imf(1,x,y); z3=1/(pi^2*x*y);      
    end
end
H=conv2(z2,z3);%z2与z3的二维卷积
figure;
imshow(H);

%z=uint8(z);
%figure;imshow(z);

%x=1:243;
%y=1:305;
%h(x,y)=1/(pi^2*x*y);
%dim=size(im);
%b=zeros(dim);
%b1=b;
%for  j=1:i
%    b1(:,:)=imf(j,:,:)
%   b= b1
%    c=conv2(b,1/(pi^2*x*y);
 %  figure;imshow(c);
% end
    
