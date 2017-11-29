%Initialization
clc, clf, clear
%Parameters
numCars = 200; 
numHubs = 5;
endTime = 1440;

%Variables
ID_trip = 1; %Id for each trip


%Initializing TripQueue
tripQueue = TripQueue;

%Creating graph
G = InitializeGraph();

%Retrieving positions of the most connected nodes 
D = degree(G);
[B,positions] = maxk(D,numHubs);

%Initializing vehicles
vec = InitializeVehicles(numCars,positions)

%Main loop

for t=1:endTime
    %Update generate and add trip
    [origin,destination] = GenerateTrip(t);
    if ((origin ~=0) && (destination ~=0) )
        AddTrip(tripQueue,origin,destination,t,ID_trip); %might need ID here aswell
        ID_trip = ID_trip + 1;
    end
    
    %Pair cars with trip
    MatchTrips(vec,tripQueue)
    %Uppdate cars
    UppdateCars(vec)
end

