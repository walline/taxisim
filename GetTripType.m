function [origin,destination] = GetTripType(time)

if time < 500
    origin = randomHomeNode();
    destination = randomWorkNode();
elseif time < 1000
    origin = randomWorkNode();
    destination = randomHomeNode();
else
    origin = randomHomeNode();
    destination = randomOtherNode();
    


