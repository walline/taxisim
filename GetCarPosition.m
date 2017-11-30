function currentPositions = GetCarPosition( cars )
%GETCARMOVEMENT 
% Returns a struct of nodes and edges depending on if the car busy/not 
% busy and if it is moving or not. Output can be used as input in
% highlight func of graph. Assumes all positions are integers, not strings.

numberOfVehicles = length(cars);
currentPositions = cell(1, numberOfVehicles);
for i=1:numberOfVehicles
    car = cars(i);
    if ~car.Busy
        if car.CurrentNode == car.FinalDest % Car is standing still
            currentPositions{1, i} = [car.CurrentNode];
        else
            currentPositions{1, i} = [car.CurrentNode car.FinalDest]; % Car moving to hub
        end
    else
        currentPositions{1, i}=[car.CurrentNode car.Path(find(car.CurrentNode)+1)];
    end
end
end

