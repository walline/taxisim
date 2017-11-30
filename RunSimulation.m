%Initialization
clc, clf, clear
%Parameters
numCars = 200; 
numHubs = 5;
endTime = 100; %1440 for 24 hours
delayTime = 15;

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
 
    %Update generate and add trip
    [origin,destination] = GenerateTrip(t,G);

    if ((origin ~=0) && (destination ~=0) )
        tripQueue.AddTrip(origin,destination,t,ID_trip);
        ID_trip = ID_trip + 1;
    end

    %Pair cars with trip
    [vec, tripQueue, timesArray] = MatchTrips(vec,tripQueue,G,t,timesArray, selection_para);
    %Uppdate cars
%     vec = UpdateCars(G,vec,t,timesArray)
end

