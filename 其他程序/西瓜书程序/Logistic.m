
old_l = 0;
n = 0;
b = [0;0;1]; %��Ӧ���У�3.25���µ�B=(w;b)����Ϊx���������ԣ��ܶȣ������ʣ�������b���У�����һ����w*x+b�е�b��

x = xlsread('C:\Users\liuzebin\Desktop\��������.xlsx', 'Sheet1', 'A1:Q3');
y = xlsread('C:\Users\liuzebin\Desktop\��������.xlsx', 'Sheet1', 'A4:Q4');

while(1)
  cur_l = 0;
  bx = zeros(17,1); %��17������,bxΪB'*X����W^T+b

  for i=1:17
    bx(i) = b.'*x(:,i); % ÿ��ѭ��ȡһ������
    cur_l = cur_l + (-y(i)*bx(i)) + log(1+exp(bx(i))); %��Ӧʽ��3.27��
  end

  if abs(cur_l-old_l) < 0.0001 %whileѭ���˳���������cur_1����,�ѵõ����Ž�
    break;
  end

  n=n+1; %�����������
  old_l = cur_l;
  dl = 0;
  d2l = 0;

  for i=1:17 %ţ�ٷ���⣨3.29��
    pl(i) = 1 - 1 / (1+exp(bx(i))); %��Ӧ��ʽ��3.23��3.24������p1(i)=1-p0(i)
    dl = dl - x(:,i) * (y(i) - pl(i)); %��3.30��
    d2l=d2l+ x(:,i) * x(:,i).'* pl(i)*(1-pl(i)); %��3.31��
  end
  b=b- d2l \ dl; % d1/d2,��Ӧ��ʽ(3.29)
end

%��ͼ
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

%�����ֱ�߽߱�� ������ֱ�ߣ�w1*�ܶ�+w2*������+b=0��
ply = -(0.1*b(1)+b(3))/b(2);
pry = -(0.9*b(1)+b(3))/b(2)   ;
line([0.1 0.9],[ply pry]);        

xlabel('�ܶ�');
ylabel('������');
title('���ʻع�');
