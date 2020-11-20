clear;clc;
I=imread('2.jpg');
I=hsi(I);
%% ��ʼ��
s=15;
errth=10^-2;
wDs=0.5^2;
%% ����դ��
m=size(I,1);
n=size(I,2);

%% ����դ�񶥵������ĵ�����
h=floor(m/s);%��
w=floor(n/s);%��
rowR=floor((m-h*s)/2); %���ಿ����β����,����ȡ��
colR=floor((n-w*s)/2);
rowStart=(rowR+1):s:(m-s+1);
rowStart(1)=1;
rowEnd=rowStart+s;
colStart=(colR+1):s:(n-s+1);
colStart(1)=1;
colEnd=colStart+s;
colEnd(1)=colR+s;
colEnd(end)=n;
%% ȷ��դ�����ĵ�����
rowC=floor((rowStart+rowEnd-1)/2);
colC=floor((colStart+colEnd-1)/2);
%% դ��
temp=zeros(m,n);%240*320ȫ��
temp(rowStart,:)=1;
temp(:,colStart)=1;
for i=1:h
    for j=1:w
        temp(rowC(i),colC(j))=1;
    end
end
imshow(temp);

%% ת��ͼ��
Y=I(:,:,1);
f1=fspecial('sobel');
f2=f1';
gx=imfilter(Y,f1);
gy=imfilter(Y,f2);
G=sqrt(gx.^2+gy.^2); %sobel�����˲�
%%  ѡ��դ�����ĵ�3*3�������ݶ���С����Ϊ��ʼ��
rowC_std=repmat(rowC',[1,w]);
colC_std=repmat(colC,[h,1]);
rowC=rowC_std;
colC=colC_std;
for i=1:h
      for j=1:w
        block=G(rowC(i,j)-1:rowC(i,j)+1,colC(i,j)-1:colC(i,j)+1);
        [minVal,idxArr]=min(block(:));%�����Сֵ�Լ�λ��
        jOffset=floor((idxArr(1)+2)/3);
        iOffset=idxArr(1)-3*(jOffset-1);
        rowC(i,j)=rowC(i,j)+iOffset;
        colC(i,j)=colC(i,j)+jOffset;
      end
end
temp1=zeros(m,n);%240*320ȫ��
 temp1(rowStart,:)=1;
 temp1(:,colStart)=1;
for i=1:h
    for j=1:w
        temp1(rowC(i,j),colC(i,j))=1;
    end
end
imshow(temp1);














