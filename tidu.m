%% �ݶȼ���
function [TD1,TD2,TD3]=tidu(block_post)
x=size(block_post);
TD3=zeros(x(1),x(2));
TD1(:,:)=(block_post(1:end-1,:)-block_post(2:end,:));%x�����ݶ�
TD1(end+1,:)=TD1(end,:);
TD2(:,:)=(block_post(:,1:end-1)-block_post(:,2:end));%y�����ݶ�
TD2(:,end+1)=TD2(:,end);
%% 45�㷽���ݶ�
for p=2:x(1)
    for q=2:x(2)
        if p==q
TD3(p-1,q-1)=(block_post(p-1,q-1)-block_post(p,q));%45�㷽���ݶ�
        end
    end
end
end