function test_1(block)
    setup(block);
end

function setup(block)

    block.NumInputPorts = 3;
    block.NumOutputPorts = 1;
    for i=1:3
    block.InputPort(i).Dimensions=[320 240];
    block.InputPort(i).DatatypeID  = 0;  % double
    block.InputPort(i).Complexity  = 'Real';
    end
    
    block.OutputPort(1).Dimensions=[320 240];
    block.OutputPort(1).DatatypeID  = 0; % double
    block.OutputPort(1).Complexity  = 'Real';
    
    block.RegBlockMethod('Outputs', @Outputs);
%     block.RegBlockMethod('Update', @Update);
end

function Outputs( block )

r=block.InputPort(1).Data;
g=block.InputPort(2).Data;
b=block.InputPort(3).Data;
 
num=0.5*((r-g)+(r+b));
den=sqrt((r-g).^2+(r-b).*(g-b));
theta=acos(num./(den+eps));
% 
H=theta;
H(b>g)=2*pi-H(b>g);
H=H/(2*pi);
% 
num=min(min(r,g),b);
den=r+g+b;
den(den==0)=eps;
S=1-3.*num./den;
H(S==0)=0;
I=(r+g+b)/3;
% 
hsi=cat(3,H,S,I);
block.OutputPort(1).Data =hsi(:,:,3);
end

% function Update(block)
%   
%   block.Dwork(1).Data = block.InputPort(1).Data;
% end
%     