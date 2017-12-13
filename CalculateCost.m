function cost = CalculateCost( timesArray, numCars, notPairedTime )
%CALCULATECOST Calculate cost given waiting times and numbers of cars

avgHourlySalary = 22750/175; %Median salary gothenburg
carCost = 400000/(2*365); % Car cost per day assuming 2yrs life length
fuelCost = (6570/365) * 0.7 * 14; %(mil/day) * (l/mil) * 14 (kr/l)  
waitingTimes = sum(timesArray(1:2,:)); % Sum time to trip match with time to pickup
scaledWaitingTimes = waitingTimes((waitingTimes > 15)); 
scaledWaitingTimes = (sum(scaledWaitingTimes) + notPairedTime)/60; % Hours

cost = scaledWaitingTimes*avgHourlySalary + numCars*(carCost+fuelCost);

end

