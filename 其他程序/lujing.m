map = false(10); %Input map parameters，10*10逻辑矩阵
map (2:10, 6) = true; %Obstacle Declaration，2-10行第六列为真
start_coords = [6, 2]; %Starting coordinates起始点
dest_coords  = [8, 9]; %Destination Coordinates终点
drawMapEveryTime = false; %Display Outputs
[route, numExpanded] = AStarGrid(map, start_coords, dest_coords,drawMapEveryTime) %Implementatio