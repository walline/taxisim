classdef TripQueue
    properties
        tripMatrix
    end
    
    methods
        function obj = TripQueue()
            obj.tripMatrix = [];
        end
        
        function AddTrip(origin,destination,callTime,id)
            tripMatrix = [tripMatrix; [origin,destination,callTime,id]];
        end
        
        function waitingTime = PopTrip(id,pickUpTime)
            index = find(tripMatrix(:,3)==id)
            waitingTime = pickUpTime - callTime;
            tripMatrix[index,:] = [];
        end
        
        
        
        
    end
end
    
    



