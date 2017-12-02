%Initialization


clc, clf, clear
%Parameters
numCars = 6;
numHubs = 5;
endTime = 1440; %1440 for 24 hours
delayTime = 15;
startTime = 0;
counter_busy = zeros(1,endTime);

totalNumberOfTrips = 10;
functionCalls = 100; % change this depending on nr of loop iterations

load('fitdata.mat') % loads data for curve fits


%Creating graph
G = InitializeGraph();

probGen = ProbabilityGenerator();
probGen.SetTimeProbabilities(x,y,totalNumberOfTrips,functionCalls,startTime,endTime);
probGen.SetTypeProbabilities(G);

selection_para = 0;
%Selection parameter [0, 1] to decide how to assign trips;
%0 ignores the distance, 1 ignores the queue

%Variables
ID_trip = 1; %Id for each trip
timesArray =  []; %row 1 pairing time row 2 trip length


%Initializing TripQueue
tripQueue = TripQueue(delayTime);

%Creating graph
G = InitializeGraph();

%Retrieving positions of the most connected nodes
D = degree(G);
[B,positions] = maxk(D,numHubs);
positions = num2cell(positions);

%Initializing vehicles
vec = InitializeVehicles(numCars,positions);

%Main loop

for t=1:endTime
    subplot(1,2,1)
    DisplayGraph(G, vec, tripQueue)
    
    
    pause(0.0001)
    %Update generate and add trip
    [origin,destination] = probGen.GenerateTrip(t);
    
    if ((origin ~=0) && (destination ~=0) )
        tripQueue.AddTrip(origin,destination,t,ID_trip);
        ID_trip = ID_trip + 1;
    end
    
    %Pair cars with trip
    [vec, tripQueue, timesArray] = MatchTrips(vec,tripQueue,G,t,timesArray, selection_para);
    
    %Uppdate cars
    [vec,  timesArray] = UpdateCars(G,vec,t,timesArray);
    timesArray
    t
    
    
    for i=1:numCars
        if vec(i).Busy==1
            counter_busy(t) = counter_busy(t) + 1;
        end
    end
    
    
    subplot(1,2,2)
    axis([0 endTime 0 numCars])
    scatter(t, counter_busy(t),'s')
     hold on
    
    title('#BusyCars')
    
    
end
