function tripProbability = GetTripProbability(time)

% assuming time is in minutes

startingProbability = 0.1;
maxProbability = 0.5;
peakTime1 = 400;
peakTime2 = 1000;
endTime = 1440;

if time < peakTime1;
    tripProbability = time*maxProbability/peakTime1;
elseif time < (peakTime1+peakTime2)/2;
    tripProbability = maxProbability - (time-peakTime1)*maxProbability/peakTime1;
elseif time < peakTime2;
    tripProbability = time*maxProbability/peakTime1-peakTime2*maxProbability/peakTime1;
else
    tripProbability = -time*(maxProbability-startingProbability)/(endTime-peakTime2)+endTime* ...
        (maxProbability-startingProbability)/(endTime-peakTime2)+startingProbability;
end

    