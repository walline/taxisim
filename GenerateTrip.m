function [origin,destination] = GenerateTrip(currentTime)

r = rand;

if r < TripProbability(currentTime)
    [origin,destination] = GetTripType(time);
else
    [origin, destination] = [0,0];
end

    