classdef TripQueue < handle
    properties
        tripMatrix
        delayTime
    end
    
    methods
        function obj = TripQueue(delayTime)
            obj.tripMatrix = [];
            obj.delayTime = delayTime;
        end
        
        function AddTrip(obj,origin,destination,callTime,id)
            obj.tripMatrix = [obj.tripMatrix; [origin,destination,callTime,id]];
        end
        
        function waitingTime = PopTrip(obj,id,pickUpTime)
            index = find(obj.tripMatrix(:,4)==id);

            if isempty(index)
                disp('ERROR: Trip ID not found')
                return
            end
            
            callTime = obj.tripMatrix(index,3);
            
            if callTime > pickUpTime
                disp('ERROR: Pick up time small than call time')
                return
            end
            
            waitingTime = max(pickUpTime - (obj.delayTime + callTime),0);
            obj.tripMatrix(index,:) = [];
        end
        
        
        
        
    end
end
    
    



