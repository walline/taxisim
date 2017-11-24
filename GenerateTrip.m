function [origin,destination] = GenerateTrip(currentTime)

r = rand;

if r < GetTripProbability(currentTime)
    [origin,destination] = GetTripType(time);
else
    [origin, destination] = [0,0];
end

    