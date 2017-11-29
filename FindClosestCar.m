function [bestDistance, car] = FindClosestCar(cars, node, graph)

bestDistance = Inf;
nCars = length(cars);
car = 0;

for i = 1:nCars
    if(~cars(i).Busy)
        [~, distance] = shortestpath(graph, cars(i).CurrentNode, node);
        if(distance < bestDistance)
            car = i;
            bestDistance = distance;
        end
    end
end

end