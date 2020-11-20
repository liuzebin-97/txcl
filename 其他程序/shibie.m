%  clear all;clc;
% I=imread('C:\Users\liuzebin\Desktop\道路.bmp');
% I=im2double(I);
% % imshow(I);
%  resX=I(:,:,1);
%  resY=I(:,:,2);
%  resZ=I(:,:,3);
% x=imshow(r);
% figure;
% y=imshow(g);
% figure;
% z=imshow(b);
% record=5;
% FunK_mean3D(resX,resY, resZ,record);reshape
% t = 1000;
  resX=I(:,:,1);
  x=reshape(resX,[1,320*240]);
 resY=I(:,:,2);
 y=reshape(resY,[1,320*240]);
 resZ=I(:,:,3);
 z=reshape(resZ,[1,320*240]);

data = T;
k = 5;
[res, record] = FunK_meanPolyD(data,k);

[h, w] = size(res);
if h/k == 2
    hold on
    for i = 1:k
        plot(res(i*2-1,1:record(i)),res(i*2,1:record(i)),'*')
        plot(mean(res(i*2-1,1:record(i)),2),mean(res(i*2,1:record(i)),2),'Marker','square','Color','k','MarkerFaceColor','k','LineStyle','none')
    end
    hold off
elseif h/k == 3
    for i = 1:k
        plot3(res(i*3-2,1:record(i)),res(i*3-1,1:record(i)),res(i*3,1:record(i)),'*')
        plot3(mean(res(i*3-2,1:record(i)),2),mean(res(i*3-1,1:record(i)),2),mean(res(i*3,1:record(i)),2),'Marker','square','Color','k','MarkerFaceColor','k','LineStyle','none')
        hold on%注意：hold on 要写在plot3之后，这样三维图形才会正常绘制
    end
    hold off
else
    disp(['结果维度大于3维，不能进行绘制'])
end