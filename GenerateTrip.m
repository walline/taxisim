function [origin,destination] = GenerateTrip(currentTime,graph)

r = rand;

if r < GetTripProbability(currentTime)
    [origin,destination] = GetTripType(currentTime,graph);
else
    origin = 0;
    destination = 0;
end

    