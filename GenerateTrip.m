function [origin,destination] = GenerateTrip(currentTime,graph)

r = rand;

if r < GetTripProbability(currentTime)
    [origin,destination] = GetTripType(time,graph);
else
    [origin, destination] = [0,0];
end

    