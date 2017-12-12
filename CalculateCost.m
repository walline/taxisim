function cost = CalculateCost( timesArray, numCars, notPairedTime )
%CALCULATECOST Calculate cost given waiting times and numbers of cars

avgHourlySalary = 25000/175;
carCost = 300000/(5*365); % Car cost per day assuming 5yrs life length
waitingTimes = sum(timesArray(1:2,:)); % Sum time to trip match with time to pickup
scaledWaitingTimes = waitingTimes((waitingTimes > 15)); 
scaledWaitingTimes = (sum(scaledWaitingTimes) + notPairedTime)/60; % Hours

cost = scaledWaitingTimes*avgHourlySalary + numCars*carCost;

end

