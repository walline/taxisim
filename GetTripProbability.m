function tripProbability = GetTripProbability(time)

% assuming time is in minutes

totalNumberOfTrips = 1000;
functionCalls = 3000;
endTime = 1440;
startTime = 0;

load('fitdata.mat');
x=x*endTime;

[fitresult,~] = SplineFit(x,y);

meanProbability = integral(@(x) fitresult(x),startTime,endTime,'ArrayValued',true)/endTime;

scalingFactor = totalNumberOfTrips/(functionCalls*meanProbability);

[~,maxProbability] = fminbnd(@(x) -scalingFactor*fitresult(x),startTime,endTime);
maxProbability = -maxProbability;
if maxProbability > 1
    disp('Probability greater than one. Needs more function calls or lower total number of trips.')
    tripProbability = NaN;
    return
end

tripProbability = fitresult(time)*scalingFactor;

    