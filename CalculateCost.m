function cost = CalculateCost( timesArray, numCars )
%CALCULATECOST Calculate cost given waiting times and numbers of cars

avgHourlySalary = 30000/175;
carCost = 300000;
waitingTimes = sum(timesArray(1:2,:)); % Sum time to trip match with time to pickup
scaledWaitingTimes = waitingTimes((waitingTimes > 15)); 
scaledWaitingTimes = sum(scaledWaitingTimes)/60; % Hours

cost = scaledWaitingTimes*avgHourlySalary + numCars*carCost;

end

