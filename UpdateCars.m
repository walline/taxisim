function updatedCars = UpdateCars( graph, cars )
%UPDATECARS 

numberOfCars = length(cars);
for i=1:numberOfCars
   car = cars(i);
   if car.Busy
       weight = graph.Edges.Weight(findedge(graph, car.CurrentNode, car.Path(find(car.CurrentNode)+1)));

       
   end
end


end

