% matlab自带了该方法——rgb2lab
function [L,a,b]=RGB_Lab(image)
image=double(image);
[M,N]=size(image(:,:,1));
R=reshape(image(:,:,1),1,M*N);
G=reshape(image(:,:,2),1,M*N);
B=reshape(image(:,:,3),1,M*N);
t=(6/29)^3;
mat=[0.412453 0.357580 0.180423;
         0.212671 0.715160 0.072169;
         0.019334 0.119193 0.950227];
XYZ=mat*[R;G;B];
X=XYZ(1,:)/0.950456;
Y=XYZ(2,:);
Z=XYZ(3,:)/1.088754;

fX=(X(X>t)).^1/3;
if X(X<=t)
    fX=(X(X<=t).*(29/6)^2)/3+4/29;
end

fY=(Y(Y>t)).^1/3;
if Y(Y<=t)
    fY=(Y(Y<=t).*(29/6)^2)/3+4/29;
end

fZ=(Z(Z>t)).^1/3;
if Z(Z<=t)
    fZ=(Z(Z<=t).*(29/6)^2)/3+4/29;
end

L=reshape(116*fY-16,M,N);
a=reshape(500*(fX-fY),M,N);
b=reshape(200*(fY-fZ),M,N);

Lab=cat(3,L,a,b);
imshow(Lab);
end