function currentPosition = GetCarMovement( car )
%GETCARMOVEMENT 
% Returns a node or an edge depending on if the car is moving or not.
% Output can be used as input in highlight func of graph. Assumes all
% positions are integers, not strings.

if ~car.Busy
    if car.CurrentNode == car.FinalDest % If car is standing still
        currentPosition = [car.CurrentNode];
        return 
    else
        currentPosition = [car.CurrentNode car.FinalDest];
        return
    end
else
    if length(find(car.Path==car.CurrentNode))<1 % Car on its way to customer, need some kind of attribute here
        currentPosition=[car.CurrentNode car.Path(1)];
        return
    else
        currentPosition=[car.CurrentNode car.Path(find(car.CurrentNode)+1)];
        return
    end
end
end

