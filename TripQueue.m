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
            pass
        end
        
        
        
        
    end
end
    
    



