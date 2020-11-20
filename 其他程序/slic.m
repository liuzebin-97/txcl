clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ȡͼ��Ԥ����%%%%%%%%%%%%%%%
he = imread('C:\Users\liuzebin\Desktop\��·.bmp');%��ȡͼ��
cform = makecform('srgb2lab');%ͼ����RGBתΪlab
lab_he = applycform(he,cform);%
lab_he=double(lab_he);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ó�ֵ%%%%%%%%%%%%%%%%%%
color=[250,0,0];
thre=0.02;%�������ɷָ�ͼ���ݶ���ֵ
m=40;%Ȩֵ
k=1;%����Ϊ300����
die=20;%kmeans����die��
x=size(he);s=(x(1)*x(2)/k)^0.5;s=ceil(s);%��ʼ�ָ�������s
r=ceil(x(1)/s);%��������r
w=ceil(x(2)/s);%��������w
ct=r*w;
belong=ones(x(1),x(2));
center=zeros(ct,5);
%��ʼÿ�����ص�ľ���
dist=9999*ones(x(1),x(2));
%��ʼ���Ľڵ�center
for i=1:r
    for j=1:w
        if (i<r)
            x1=(i-1)*s+fix(s/2);
        else
            x1=(i-1)*s+fix(rem(x(1),s)/2);
        end
        if (j<w)
            y1=(j-1)*s+fix(s/2);
        else
            y1=(j-1)*s+fix(rem(x(2),s)/2);
        end
        z=lab_he(x1,y1,:);
        center((i-1)*w+j,:)=[z(:,:,1) z(:,:,2) z(:,:,3) x1 y1];%��ʼ���Ľڵ�center
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�������ദ��%%%%%%%%%%%%%%%
t1=clock;
move=99999;
for c=1:die    %���е���die��
    if move<10
        break;
    end
    move=0;
    c1=zeros(ct);
    ct_x=zeros(ct);
    ct_y=zeros(ct);
    ct_l=zeros(ct);
    ct_a=zeros(ct);
    ct_b=zeros(ct);
    for i=1:ct
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for u=center(i,4)-s:center(i,4)+s
            if(u>=1)&&(u<=x(1))
                for v=center(i,5)-s:center(i,5)+s
                    if(v>=1)&&(v<=x(2))
                        dc=((lab_he(u,v,1)-center(i,1))^2+(lab_he(u,v,2)-center(i,2))^2+(lab_he(u,v,3)-center(i,3))^2)^0.5;
                        ds=((u-center(i,4))^2+(v-center(i,5))^2)^0.5;
                        d=((dc)^2+(ds*m/s)^2)^0.5;%�������
                        if d<dist(u,v)
                            dist(u,v)=d;
                            belong(u,v)=i; 
                            move=move+1;
                        end
                    end
                end
            end
        end
    end 
    for k=1:x(1)
        for g=1:x(2)
            i=belong(k,g);
            c1(i)=c1(i)+1;
            ct_x(i)=ct_x(i)+k;
            ct_y(i)=ct_y(i)+g;
            ct_l(i)=ct_l(i)+lab_he(k,g,1);
            ct_a(i)=ct_a(i)+lab_he(k,g,2);
            ct_b(i)=ct_b(i)+lab_he(k,g,3);
            
        end
    end
    for i=1:ct
        center(i,4)=fix(ct_x(i)/c1(i));
        center(i,5)=fix(ct_y(i)/c1(i));
        center(i,1)=fix(ct_l(i)/c1(i));
        center(i,2)=fix(ct_a(i)/c1(i));
        center(i,3)=fix(ct_b(i)/c1(i));
    end
end
t2=clock;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ȥ����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:ct
    bw=zeros(x(1),x(2));
    for k=1:x(1)
        for g=1:x(2)
            if belong(k,g)==i
                bw(k,g)=1;
            end
        end
    end
    [L, num] = bwlabel(bw, 4);%������ͨ�ĵ�
    for k=1:num
        [rr, cc] = find(L==k);
        c1=size(rr);
        if c1(1)>0&&c1(1)<100
            for g=1:c1(1)
                if rr(1)-1>=1
                    belong(rr(g),cc(g))=belong(rr(1)-1,cc(1));
                elseif cc(1)-1>=1
                    belong(rr(g),cc(g))=belong(rr(1),cc(1)-1);
                elseif cc(1)+1<=x(2)
                    belong(rr(g),cc(g))=belong(rr(1),cc(1)+1);
                elseif rr(1)+1<=x(1)
                    belong(rr(g),cc(g))=belong(rr(1)+1,cc(1));
                end
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ʾ�����ͼ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hehe=uint8(lab_he);
cform = makecform('lab2srgb');%ͼ����labתΪRGB
hehe = applycform(hehe,cform);
hehe=double(hehe);
%hehe=255+zeros(x(1),x(2),3);
for i=1:x(1)
    for j=1:x(2)
        b=0;
        if ((i-1)>=1)&&((j-1)>=1)
            if belong(i-1,j-1)~=belong(i,j)
                hehe(i,j,1)=color(1);
                hehe(i,j,2)=color(2);
                hehe(i,j,3)=color(3);
                b=1;
            end
            if belong(i-1,j)~=belong(i,j)
                hehe(i,j,1)=color(1);
                hehe(i,j,2)=color(2);
                hehe(i,j,3)=color(3);
                b=1;
            end
            if belong(i,j-1)~=belong(i,j)
                hehe(i,j,1)=color(1);
                hehe(i,j,2)=color(2);
                hehe(i,j,3)=color(3);
                b=1;
            end   
        elseif ((i-1)>=1)&&((j+1)<=x(2))
            if belong(i-1,j+1)~=belong(i,j)
                hehe(i,j,1)=color(1);
                hehe(i,j,2)=color(2);
                hehe(i,j,3)=color(3);
                b=1;
            end
            if belong(i,j+1)~=belong(i,j)
                hehe(i,j,1)=color(1);
                hehe(i,j,2)=color(2);
                hehe(i,j,3)=color(3);
                b=1;
            end
        elseif ((i+1)<=x(1))&&((j-1)>=1)
            if belong(i+1,j-1)~=belong(i,j)
                hehe(i,j,1)=color(1);
                hehe(i,j,2)=color(2);
                hehe(i,j,3)=color(3);
                b=1;
            end
            if belong(i+1,j)~=belong(i,j)
                hehe(i,j,1)=color(1);
                hehe(i,j,2)=color(2);
                hehe(i,j,3)=color(3);
                b=1;
            end
        elseif ((i+1)<=x(1))&&((j+1)<=x(2))
            if belong(i+1,j+1)~=belong(i,j)
                hehe(i,j,1)=color(1);
                hehe(i,j,2)=color(2);
                hehe(i,j,3)=color(3);
                b=1;
            end
        end
        %if(b==1)&&((i-1)>=1)&&((j-1)>=1)&&((i+1)<=x(1))&&((j+1)<=x(2))
        %    hehe(i,j+1,1)=color(1);
        %    hehe(i,j+1,2)=color(2);
        %    hehe(i,j+1,3)=color(3);
        %    hehe(i+1,j,1)=color(1);
        %    hehe(i+1,j,2)=color(2);
        %    hehe(i+1,j,3)=color(3);
        %end 
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%�����ͼ��������ʾ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hehe=uint8(hehe);
figure(1)
imshow(he), title('ԭʼͼ��');%��ʾͼ��
figure(20)
imshow(hehe), title('SLIC�ָ�k=400,m=40')
etime(t2,t1)