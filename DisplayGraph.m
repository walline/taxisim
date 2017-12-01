function DisplayGraph(graph, cars, trips)
%GETCARMOVEMENT 
% Returns a struct of nodes and edges depending on if the car busy/not 
% busy and if it is moving or not. Output can be used as input in
% highlight func of graph. Assumes all positions are integers, not strings.

calls = [];
busy = [];
idle = [];
idleMoving = [];
h = plot(graph, 'NodeLabel', graph.Nodes.Name,'EdgeLabel', graph.Edges.Weight);

numberOfVehicles = length(cars);
numberOfTrips = size(trips.tripMatrix, 1);
%currentPositions = cell(1, numberOfVehicles);

for i=1:numberOfVehicles
    car = cars(i);
    if ~car.Busy
        if car.CurrentNode == car.FinalDest % Car is standing still
            idle = [idle, [car.CurrentNode]];
        else
            idleMoving = [idleMoving; [car.CurrentNode, car.FinalDest]]; % Car moving to hub
        end
    else
        busy = [busy; [car.CurrentNode, car.Path(find(car.CurrentNode)+1)]];
    end
end

for i = 1:numberOfTrips 
    calls = [calls, trips.tripMatrix(i,1)];
end

%display

highlight(h,calls,'NodeColor', [1, 101/255, 0], 'MarkerSize', 7); %calls
highlight(h,idle,'NodeColor',[101/255, 0, 1], 'MarkerSize', 7); %idle cars

for i = 1:size(busy, 1)
highlight(h,busy(i,:),'EdgeColor','b', 'LineWidth', 3); %busy moving
end

for i = 1:size(idleMoving, 1)
highlight(h,idleMoving(:,1),'EdgeColor','c', 'LineWidth', 3); %idle moving
end

end
