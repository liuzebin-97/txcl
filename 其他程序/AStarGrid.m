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

cmap = [1 1 1; %��ɫ
    0 0 0; %��ɫ
    1 0 0; %��ɫ
    0 0 1; %��ɫ
    0 1 0; %��ɫ
    1 1 0; %��ɫ
    0.5 0.5 0.5];%��ɫ

colormap(cmap);

% variable to control if the map is being visualized on every
% iteration
drawMapEveryTime = true;

[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;   % Mark free cells��ɫ
map(input_map)  = 2;   % Mark obstacle cells��ɫ

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));%���±�ת��Ϊ������������ʼ��
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));%�յ�
%��ʼ����յ��λ��

map(start_node) = 5;%��ɫ
map(dest_node)  = 6;%��ɫ ��ʼ�㡢�յ����ɫ

% meshgrid will `replicate grid vectors' nrows and ncols to produce
% a full grid
% type `help meshgrid' in the Matlab command prompt for more information
parent = zeros(nrows,ncols);%CLOSE��

% 
[X, Y] = meshgrid (1:ncols, 1:nrows);

xd = dest_coords(1);%�յ������
yd = dest_coords(2);%�յ�������

% Evaluate Heuristic function, H, for each grid cell
% Manhattan distance
H = abs(X - xd) + abs(Y - yd);%�����پ���  g����
H = H';
% Initialize cost arrays
f = Inf(nrows,ncols);%��ʼfΪ10*10�����
g = Inf(nrows,ncols);%��ʼgΪ10*10�����

g(start_node) = 0;%��ʼ�㵽��ǰ��
f(start_node) = H(start_node);%��ǰ�㵽Ŀ�����ֵ

% keep track of the number of nodes that are expanded
numExpanded = 0;%��չ��ڵ���

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
    [min_f, current] = min(f(:));%min_f������Сֵ
    %�Լ�current��Сֵ��λ������

    if ((current == dest_node) || isinf(min_f))
        break;
    end

    % Update input_map
    map(current) = 3;%��ɫ
    f(current) = Inf; % remove this node from further consideration

    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(f), current);

    % *********************************************************************
    % ALL YOUR CODE BETWEEN THESE LINES OF STARS
    % Visit all of the neighbors around the current node and update the
    % entries in the map, f, g and parent arrays
    %
    numExpanded = numExpanded + 1;%����Χ
    if(i-1>=1) %upper����Ѱ��
        id = sub2ind(size(map), i-1, j);    
        if((map(id) ~= 2) ... %if not obst�����ϰ���
            && (map(id) ~= 3) ... % if not visitedû��̽��
            && (map(id) ~= 5)) ... % if not start���ǳ�ʼ��
            
            if(g(id) >= g(current) + 1)%��ʼ�㵽ID��ľ���>=��ʼ��
                %���ϵ�ľ���
                g(id) = g(current) + 1;%��ֵ��ID��
                f(id) = g(id) + H(id);
                parent(id) = current;
                map(id) = 4;%����ɫ

            end            
        end
    end

    if(i+1 <= nrows) %lower��������
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

    if(j-1 >= 1) %left��������
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

    if(j+1 <= ncols) %��������
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
    route = dest_node;%���·���������ֵ

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