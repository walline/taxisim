classdef ProbabilityGenerator < handle
    properties
        scalingFactor
        fitResult
        numberOfNodes
    end
    
    methods
        function obj = ProbabilityGenerator()
            obj.scalingFactor=0;
            obj.fitResult = 0;
            obj.numberOfNodes = 0;
        end
        
        function SetTimeProbabilities(obj,xdata,ydata,totalNumberOfTrips,functionCalls,startTime,endTime)
            xdata = xdata*endTime;
            
            [X,Y] = prepareCurveData(xdata,ydata);
            ft = fittype('smoothingspline');
            [obj.fitResult,~] = fit(X,Y,ft);

            meanProbability = integral(@(x) obj.fitResult(x),startTime,endTime,'ArrayValued',true)/ ...
                endTime;
            obj.scalingFactor = totalNumberOfTrips/(functionCalls*meanProbability);
            
            [~,maxProbability] = fminbnd(@(x) -obj.scalingFactor*obj.fitResult(x),startTime,endTime);
            maxProbability = -maxProbability;

            if maxProbability > 1
                disp(['ERROR: Probability greater than one. Needs more function calls or lower ' ...
                      'total number of trips.'])
                return
            end
        end
        
        function SetTypeProbabilities(obj,graph)
            obj.numberOfNodes = height(graph.Nodes);
        end
        
        function tripProbability = GetTripProbability(obj,currentTime)            
            tripProbability = obj.fitResult(currentTime)*obj.scalingFactor;            
        end
        
        function [origin,destination] = GetTripType(obj,time)
        % just random nodes so far
        % need to implement this with time depending probabilities
            
           origin = randi(obj.numberOfNodes);
           destination = randi(obj.numberOfNodes);
           while (origin==destination)
               destination = randi(numberOfNodes);
           end
       end
        
       function [origin,destination] = GenerateTrip(obj,currentTime)
          r = rand;
          if r < obj.GetTripProbability(currentTime)
              [origin,destination] = obj.GetTripType(currentTime);
          else
              origin = 0;
              destination = 0;
          end
          
       end
                
    end
end