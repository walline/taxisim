%Initialization


clc, clf, clear all, close all
%Parameters
numCars = 10;
numHubs = 5;
endTime = 1440; %1440 for 24 hours
delayTime = 15;
startTime = 0;
counter_busy = zeros(1,endTime);

totalNumberOfTrips = 400;
functionCalls = 1440; % change this depending on nr of loop iterations

numberOfPeople = totalNumberOfTrips/3.5; % very rough approximation

load('fitdata.mat') % loads data for curve fits
load('typedata.mat') % loads data for trip types

%Creating graph
[G, X, Y] = InitializeGraph();
G_old = G;
[G, X, Y] = AddEmptyNodes(G, 2, X, Y);
h = InitializePlot(G, X, Y);

% set last input true if you want to generate plots
probGen = ProbabilityGenerator();
probGen.SetTimeProbabilities(x,y,totalNumberOfTrips,functionCalls,startTime,endTime,false);
probGen.SetTypeProbabilities(G,homeDest,homeOrigin,workDest,workOrigin,xType,false);


selection_para = 0;
%Selection parameter [0, 1] to decide how to assign trips;
%0 ignores the distance, 1 ignores the queue

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
vec = InitializeVehicles(numCars,positions);

%Main loop
vid = VideoWriter('simsim.avi','Motion JPEG AVI');
vid.FrameRate = 24;
vid.Quality=75;
open(vid); 

for t=1:endTime
%     subplot(1,2,1)
    h = InitializePlot(G, X, Y);
    DisplayGraphXY(h, vec, tripQueue)
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    
    numBusy = 0;
    for i=1:numCars
        if vec(i).Busy==1
            numBusy = numBusy + 1;
        end
    end
   
    %title({sprintf('Number of cars: %d', numCars); sprintf('Time: %02d:%02d', mod(3+floor(t/60),24), mod(t,60))},'FontSize', 18)
    dim = [.2 .65 .1 .2];
    str = {sprintf('Busy cars: %d/%d', numBusy, numCars); sprintf('Time: %02d:%02d', mod(3+floor(t/60),24), mod(t,60)); sprintf('Number of people: %d', round(numberOfPeople))};
    a = annotation('textbox',dim,'String',str,'FontSize', 16, 'FitBoxToText','on');
    %zoom(1.2)
    set(gcf, 'outerposition', [0, 0, 1200, 850])
    pause(0.0001)
    frame = getframe(gcf); %get image of whats displayed in the figure
    writeVideo(vid, frame);
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
    timesArray
    t
    
    for i=1:numCars
        if vec(i).Busy==1
            counter_busy(t) = counter_busy(t) + 1;
        end
    end
    
%     subplot(1,2,2)
%     axis([0 endTime 0 numCars])
%     scatter(t, counter_busy(t),'s')
%      hold on
%     
%     title('Number of busy cars', 'FontSize', 18)
    delete(a);
end
close(vid);