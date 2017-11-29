function [cars, trips, timesArray] = MatchTrips(cars, trips, graph, currentTime, timesArray, parameter)

%takes a selection parameter [0, 1] to decide how to assign trips;
%0 ignores the distance, 1 ignores the queue

%trips.tripMatrix =
%[origin,destination,callTime,id]

queueSize = size(trips.tripMatrix, 1);

if(queueSize == 0)
   return
end

tripOrigin = trips.tripMatrix(1,1);
trip =  trips.tripMatrix(1,4);
[firstTripDistance, car0] = FindClosestCar(cars, tripOrigin, graph);

if(car0 == 0)
    return
end

bestDistance = firstTripDistance*parameter;

for i = 2:queueSize
    tripOrigin = trips.tripMatrix(i,1);
    [tripDistance, car] = FindClosestCar(cars, tripOrigin, graph);
    if tripDistance < bestDistance
        trip = i;
        car0 = car;
        bestDistance = tripDistance;
    end
end

path = shortestpath(graph, cars(car0).CurrentNode, trips.tripMatrix(trip,1));

cars(car0).Path = path;
cars(car0).FinalDest = trips.tripMatrix(trip,2);
cars(car0).Busy = 1;

waitingTime = trips.PopTrip(id, currentTime);
timesArray = [timesArray, [waitingTime;0]];

end