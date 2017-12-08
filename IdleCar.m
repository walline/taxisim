function cars = IdleCar(cars, G, threshold, t)
%Threshold is the lowest degree of a node to be classified as input;
%for the test city, 4 works well
nCars = length(cars);

for i = 1:nCars
    if(~cars(i).Busy && isempty(cars(i).FinalDest))
        node = cars(i).CurrentNode;
        currentDegree = degree(G, node);
        if(currentDegree < threshold)
            %if the current node isn't a hub, neighboring nodes are checked
            IDs = neighbors(G, node);
            maxDegree = currentDegree;
            for j = 1:currentDegree
                if(degree(G, IDs(j)) > maxDegree)
                   cars(i).FinalDest = IDs(j);
                   cars(i).LastNodeTime = t;
                   maxDegree = degree(G, IDs(j));
                end
            end
        end
    end
end

end