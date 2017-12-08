function [updatedCars, timesArray] = UpdateCars( G, cars, currentTime, timesArray )
%UPDATECARS

numberOfCars = length(cars);
for i=1:numberOfCars
    car = cars(i);
    if car.Busy
        if length(car.Path) == 1 % If driver starts at pickup node
            [path, ~] = shortestpath(G, car.CurrentNode, car.FinalDest);
            car.Path = path;
            timesArray(2, car.TimesArrayPosition) = 0;
        end
        weight = G.Edges.Weight(findedge(G, car.CurrentNode, car.Path(find(car.CurrentNode)+1)));
        if isempty(car.LastNodeTime)
            elapsedTime = currentTime - car.PairingTime;
        else
            elapsedTime = currentTime - car.LastNodeTime;
        end
        if (weight - elapsedTime) <= 0
            car.CurrentNode = car.Path(2);
            car.Path = car.Path(2:end);
            car.LastNodeTime = currentTime;
            if length(car.Path) == 1 % Car reached end of path
                if car.CurrentNode == car.FinalDest % Trip complete
                    car.FinalDest = [];
                    car.Path = [];
                    car.LastNodeTime = [];
                    car.Busy = 0;
                    tripTime = currentTime - timesArray(2, car.TimesArrayPosition) - car.PairingTime;
                    car.PairingTime = 0;
                    timesArray(3, car.TimesArrayPosition) = tripTime;
                else % Car reached passenger, find path to final dest
                    [path, ~] = shortestpath(G, car.CurrentNode, car.FinalDest);
                    car.Path = path;
                    pickupTime = currentTime - car.PairingTime;
                    timesArray(2, car.TimesArrayPosition) = pickupTime;
                end
            end  
        end
    elseif car.CurrentNode ~= car.FinalDest % Car on its way to hub
        if G.Nodes.Type(findnode(G, car.CurrentNode)) ~= 0 && car.FinalDest ~= car.CurrentNode && currentTime-car.LastNodeTime == 0
            [path, ~] = shortestpath(G, car.CurrentNode, car.FinalDest);
            car.Path = path;
            car.LastNodeTime = currentTime;
        end
        
        weight = G.Edges.Weight(findedge(G, car.CurrentNode, car.Path(find(car.CurrentNode)+1)));
        elapsedTime = currentTime - car.LastNodeTime; 
        if (weight - elapsedTime) <= 0
            car.CurrentNode = car.Path(2);
            car.Path = car.Path(2:end);
            car.LastNodeTime = currentTime;
            if length(car.Path) == 1 % Car reached hub
                car.FinalDest = [];
                car.Path = [];
                car.LastNodeTime = [];
            end  
        end
    end
    cars(i) = car;
end
updatedCars = cars;
end
