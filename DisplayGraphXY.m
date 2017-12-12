function DisplayGraphXY(h, cars, trips)

calls = [];
busy = [];
idle = [];
tripsWaiting = [];
idleMoving = [];

numberOfVehicles = length(cars);
numberOfTrips = size(trips.tripMatrix, 1);
%currentPositions = cell(1, numberOfVehicles);

for i=1:numberOfVehicles
    car = cars(i);
    if ~car.Busy
        if isempty(car.FinalDest)
            idle = [idle, [car.CurrentNode]];
        elseif car.CurrentNode == car.FinalDest % Car is standing still
            idle = [idle, [car.CurrentNode]];
        else
            idleMoving = [idleMoving; [car.CurrentNode, car.Path(find(car.CurrentNode)+1)]]; % Car moving to hub
        end
    else
        if(car.FinalDest ~= car.Path(length(car.Path)))
            tripsWaiting = [tripsWaiting, car.Path(length(car.Path))];
        end
        busy = [busy; [car.CurrentNode, car.Path(find(car.CurrentNode)+1)]];
    end
end

for i = 1:numberOfTrips 
    calls = [calls, trips.tripMatrix(i,1)];
end

%display

highlight(h,calls,'NodeColor', [1, 80/255, 0], 'MarkerSize', 6); %calls
highlight(h,tripsWaiting,'NodeColor', [1, 200/255, 0], 'MarkerSize', 6);
highlight(h,idle,'NodeColor',[0 200/255 1], 'MarkerSize', 6); %idle cars

for i = 1:size(busy, 1)
highlight(h,busy(i,:),'EdgeColor','b', 'LineWidth', 4); %busy moving
end

for i = 1:size(idleMoving, 1)
highlight(h,idleMoving(i,:),'EdgeColor',[0 200/255 1], 'LineWidth', 4); %idle moving
end

end

