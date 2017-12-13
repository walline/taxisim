%Initialization


clc, clf, clear all, close all
%Parameters
numCars = linspace(1, 50, 50);
numHubs = 5;
endTime = 1440; %1440 for 24 hours
delayTime = 15;
startTime = 0;
counter_busy = zeros(1,endTime);

totalNumberOfTrips = 70;
functionCalls = 1440; % change this depending on nr of loop iterations

% numberOfPeople = totalNumberOfTrips/3.5; % very rough approximation

load('fitdata.mat') % loads data for curve fits
load('typedata.mat') % loads data for trip types

%Creating graph
[G, X, Y] = InitializeGraph();
G_old = G;
[G, X, Y] = AddEmptyNodes(G, 2, X, Y);
h = InitializePlot(G, X, Y);

iterations = 2;

for ppl=1:3
    if ppl == 1
        totalNumberOfTrips = 70;
    elseif ppl == 2
        totalNumberOfTrips = 123;
    else
        totalNumberOfTrips = 175;
    end
    
    costs = zeros(1, length(numCars));
    for iteration=1:iterations
        disp('Ppl')
        disp(ppl)
        disp('iteration')
        disp(iteration)
        % set last input true if you want to generate plots
        probGen = ProbabilityGenerator();
        probGen.SetTimeProbabilities(x,y,totalNumberOfTrips,functionCalls,startTime,endTime,false);
        probGen.SetTypeProbabilities(G,homeDest,homeOrigin,workDest,workOrigin,xType,false);
        
        
        selection_para = 0;
        %Selection parameter [0, 1] to decide how to assign trips;
        %0 ignores the distance, 1 ignores the queue
        
        for carAmount=1:length(numCars)
            carNbr = numCars(carAmount);
            disp(carNbr)
            %Variables
            ID_trip = 1; %Id for each trip
            timesArray =  []; %row 1 pairing time row 2 trip length
            
            
            %Initializing TripQueue
            tripQueue = TripQueue(delayTime);
            
            
            %Retrieving positions of the most connected nodes
            D = degree(G);
            positions = zeros(1, numHubs);
            for i=1:numHubs
                [~,I] = max(D);
                D(I) = 0;
                positions(i) = I;
            end
            positions = num2cell(positions);
            
            %Initializing vehicles
            vec = InitializeVehicles(carNbr,positions);
            
            %Main loop
          
            
            for t=1:endTime

                numBusy = 0;
                for i=1:carNbr
                    if vec(i).Busy==1
                        numBusy = numBusy + 1;
                    end
                end
                
                %Update generate and add trip
                [origin,destination] = probGen.GenerateTrip(t);
                
                if ((origin ~=0) && (destination ~=0) )
                    tripQueue.AddTrip(origin,destination,t,ID_trip);
                    ID_trip = ID_trip + 1;
                end
                
                %Pair cars with trip
                [vec, tripQueue, timesArray] = MatchTrips(vec,tripQueue,G,t,timesArray, selection_para);
                
                vec = IdleCar(vec, G_old, 4, t);
                
                
                %Uppdate cars
                [vec,  timesArray] = UpdateCars(G,vec,t,timesArray);
            

            end
            timeNotPaired = sum(endTime - tripQueue.tripMatrix(:, 3));
            costs(carNbr) = costs(carNbr) + CalculateCost(timesArray, carNbr, timeNotPaired);
        end
    end
    costs = costs ./ iterations;
    if ppl == 1
        save('costs_20ppl_2iter', 'costs')
    elseif ppl == 2
        save('costs_35ppl_2iter', 'costs')
    else
        save('costs_50ppl_2iter', 'costs')
    end 
end

%%

numCars = linspace(1, 50, 50);
fifty_ppl = load('costs_50ppl_2iter.mat');
thirty_ppl = load('costs_35ppl_2iter.mat');
twenty_ppl = load('costs_20ppl_2iter.mat');
figure()
plot(numCars, twenty_ppl.costs, 'r')
hold on
plot(numCars, thirty_ppl.costs, 'b')
plot(numCars, fifty_ppl.costs, 'g')
legend('20 ppl', '35 ppl', '50 ppl')
xlabel('Number of cars')
ylabel('Cost')