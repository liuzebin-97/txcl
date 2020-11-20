clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%读取图像，预处理%%%%%%%%%%%%%%%
he = imread('C:\Users\liuzebin\Desktop\道路.bmp');%读取图像
cform = makecform('srgb2lab');%图像由RGB转为lab
lab_he = applycform(he,cform);%
lab_he=double(lab_he);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%设置初值%%%%%%%%%%%%%%%%%%
color=[250,0,0];
thre=0.02;%最终生成分割图像梯度阈值
m=40;%权值
k=1;%划分为300个簇
die=20;%kmeans迭代die次
x=size(he);s=(x(1)*x(2)/k)^0.5;s=ceil(s);%初始分割网格间距s
r=ceil(x(1)/s);%网格行数r
w=ceil(x(2)/s);%网格列数w
ct=r*w;
belong=ones(x(1),x(2));
center=zeros(ct,5);
%初始每个像素点的距离
dist=9999*ones(x(1),x(2));
%初始中心节点center
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
        center((i-1)*w+j,:)=[z(:,:,1) z(:,:,2) z(:,:,3) x1 y1];%初始中心节点center
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%迭代聚类处理%%%%%%%%%%%%%%%
t1=clock;
move=99999;
for c=1:die    %进行迭代die次
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
                        d=((dc)^2+(ds*m/s)^2)^0.5;%计算距离
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%去坏点%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:ct
    bw=zeros(x(1),x(2));
    for k=1:x(1)
        for g=1:x(2)
            if belong(k,g)==i
                bw(k,g)=1;
            end
        end
    end
    [L, num] = bwlabel(bw, 4);%查找连通的点
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%显示聚类后图像%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hehe=uint8(lab_he);
cform = makecform('lab2srgb');%图像由lab转为RGB
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
%%%%%%%%%%%%%%%%%%%%%%%%聚类后图像网格显示%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hehe=uint8(hehe);
figure(1)
imshow(he), title('原始图像');%显示图像
figure(20)
imshow(hehe), title('SLIC分割k=400,m=40')
etime(t2,t1)