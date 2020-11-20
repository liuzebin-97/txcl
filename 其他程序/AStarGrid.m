function [route,numExpanded] = AStarGrid (input_map, start_coords, dest_coords, drawMapEveryTime)
% Run A* algorithm on a grid.
% Inputs : 
%   input_map : a logical array where the freespace cells are false or 0 and
%   the obstacles are true or 1
%   start_coords and dest_coords : Coordinates of the start and end cell
%   respectively, the first entry is the row and the second the column.
% Output :
%    route : An array containing the linear indices of the cells along the
%    shortest route from start to dest or an empty array if there is no
%    route. This is a single dimensional vector
%    numExpanded: Remember to also return the total number of nodes
%    expanded during your search. Do not count the goal node as an expanded node. 

% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

cmap = [1 1 1; %白色
    0 0 0; %黑色
    1 0 0; %红色
    0 0 1; %蓝色
    0 1 0; %绿色
    1 1 0; %黄色
    0.5 0.5 0.5];%灰色

colormap(cmap);

% variable to control if the map is being visualized on every
% iteration
drawMapEveryTime = true;

[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;   % Mark free cells白色
map(input_map)  = 2;   % Mark obstacle cells黑色

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));%将下标转换为线性索引，初始点
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));%终点
%起始点和终点的位置

map(start_node) = 5;%绿色
map(dest_node)  = 6;%黄色 起始点、终点的颜色

% meshgrid will `replicate grid vectors' nrows and ncols to produce
% a full grid
% type `help meshgrid' in the Matlab command prompt for more information
parent = zeros(nrows,ncols);%CLOSE集

% 
[X, Y] = meshgrid (1:ncols, 1:nrows);

xd = dest_coords(1);%终点横坐标
yd = dest_coords(2);%终点纵坐标

% Evaluate Heuristic function, H, for each grid cell
% Manhattan distance
H = abs(X - xd) + abs(Y - yd);%曼哈顿距离  g函数
H = H';
% Initialize cost arrays
f = Inf(nrows,ncols);%初始f为10*10无穷大
g = Inf(nrows,ncols);%初始g为10*10无穷大

g(start_node) = 0;%起始点到当前点
f(start_node) = H(start_node);%当前点到目标估计值

% keep track of the number of nodes that are expanded
numExpanded = 0;%扩展点节点数

% Main Loop

while true

    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;

    % make drawMapEveryTime = true if you want to see how the 
    % nodes are expanded on the grid. 
    if (drawMapEveryTime)
        image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;
    end

    % Find the node with the minimum f value
    [min_f, current] = min(f(:));%min_f返回最小值
    %以及current最小值的位置索引

    if ((current == dest_node) || isinf(min_f))
        break;
    end

    % Update input_map
    map(current) = 3;%颜色
    f(current) = Inf; % remove this node from further consideration

    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(f), current);

    % *********************************************************************
    % ALL YOUR CODE BETWEEN THESE LINES OF STARS
    % Visit all of the neighbors around the current node and update the
    % entries in the map, f, g and parent arrays
    %
    numExpanded = numExpanded + 1;%扩大范围
    if(i-1>=1) %upper向上寻找
        id = sub2ind(size(map), i-1, j);    
        if((map(id) ~= 2) ... %if not obst不是障碍物
            && (map(id) ~= 3) ... % if not visited没有探测
            && (map(id) ~= 5)) ... % if not start不是初始点
            
            if(g(id) >= g(current) + 1)%初始点到ID点的距离>=初始点
                %到老点的距离
                g(id) = g(current) + 1;%赋值给ID点
                f(id) = g(id) + H(id);
                parent(id) = current;
                map(id) = 4;%蓝颜色

            end            
        end
    end

    if(i+1 <= nrows) %lower向下搜索
        id = sub2ind(size(map), i+1, j);
        if((map(id) ~= 2) ... %if not obst
            && (map(id) ~= 3) ... % if not visited
            && (map(id) ~= 5)) ... % if not start
            
            if(g(id) >= g(current) + 1)
                g(id) = g(current) + 1;
                f(id) = g(id) + H(id);
                parent(id) = current;
                map(id) = 4;

            end                     
        end
    end

    if(j-1 >= 1) %left向左搜索
        id = sub2ind(size(map), i, j-1);
        if((map(id) ~= 2) ... %if not obst
            && (map(id) ~= 3) ... % if not visited
            && (map(id) ~= 5)) ... % if not start
            
            if(g(id) >= g(current) + 1)
                g(id) = g(current) + 1;
                f(id) = g(id) + H(id);
                parent(id) = current;
                map(id) = 4;

            end                    
        end
    end

    if(j+1 <= ncols) %向右搜索
        id = sub2ind(size(map), i, j+1);
        if((map(id) ~= 2) ... %if not obst
            && (map(id) ~= 3) ... % if not visited
            && (map(id) ~= 5)) ... % if not start
            
            if(g(id) >= g(current) + 1)
                g(id) = g(current) + 1;
                f(id) = g(id) + H(id);
                parent(id) = current;
                map(id) = 4;

            end                   
        end
    end




    %*********************************************************************


end

%% Construct route from start to dest by following the parent links
if (isinf(f(dest_node)))
    route = [];
else
    route = dest_node;%最短路径块的索引值

    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end

    % Snippet of code used to visualize the map and the path
    for k = 2:length(route) - 1        
        map(route(k)) = 7;
        pause(0.1);
        image(1.5, 1.5, map);
        grid on;
        axis image;
    end
end

end