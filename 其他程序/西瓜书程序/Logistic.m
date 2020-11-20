
old_l = 0;
n = 0;
b = [0;0;1]; %对应书中（3.25）下的B=(w;b)，因为x有两个属性：密度，含糖率，所以有b三行，还有一个是w*x+b中的b。

x = xlsread('C:\Users\liuzebin\Desktop\西瓜数据.xlsx', 'Sheet1', 'A1:Q3');
y = xlsread('C:\Users\liuzebin\Desktop\西瓜数据.xlsx', 'Sheet1', 'A4:Q4');

while(1)
  cur_l = 0;
  bx = zeros(17,1); %有17组数据,bx为B'*X，即W^T+b

  for i=1:17
    bx(i) = b.'*x(:,i); % 每次循环取一列数据
    cur_l = cur_l + (-y(i)*bx(i)) + log(1+exp(bx(i))); %对应式（3.27）
  end

  if abs(cur_l-old_l) < 0.0001 %while循环退出的条件：cur_1收敛,已得到最优解
    break;
  end

  n=n+1; %计算迭代次数
  old_l = cur_l;
  dl = 0;
  d2l = 0;

  for i=1:17 %牛顿法求解（3.29）
    pl(i) = 1 - 1 / (1+exp(bx(i))); %对应于式（3.23和3.24）即：p1(i)=1-p0(i)
    dl = dl - x(:,i) * (y(i) - pl(i)); %（3.30）
    d2l=d2l+ x(:,i) * x(:,i).'* pl(i)*(1-pl(i)); %（3.31）
  end
  b=b- d2l \ dl; % d1/d2,对应于式(3.29)
end

%绘图
for i=1:17
  if y(i) == 1
    plot(x(1,i),x(2,i),'+r');
    hold on;
  else if y(i) == 0
    plot(x(1,i),x(2,i),'ob');
    hold on;
       end
 end
end  

%计算出直线边界点 并绘制直线（w1*密度+w2*含糖量+b=0）
ply = -(0.1*b(1)+b(3))/b(2);
pry = -(0.9*b(1)+b(3))/b(2)   ;
line([0.1 0.9],[ply pry]);        

xlabel('密度');
ylabel('含糖率');
title('对率回归');
