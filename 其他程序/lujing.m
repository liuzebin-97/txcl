map = false(10); %Input map parameters��10*10�߼�����
map (2:10, 6) = true; %Obstacle Declaration��2-10�е�����Ϊ��
start_coords = [6, 2]; %Starting coordinates��ʼ��
dest_coords  = [8, 9]; %Destination Coordinates�յ�
drawMapEveryTime = false; %Display Outputs
[route, numExpanded] = AStarGrid(map, start_coords, dest_coords,drawMapEveryTime) %Implementatio