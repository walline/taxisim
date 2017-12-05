classdef ProbabilityGenerator < handle
    properties
        scalingFactor
        fitResult
        fitHomeOrigin
        fitHomeDestination
        fitWorkOrigin
        fitWorkDestination
        workNodes
        otherNodes
        homeNodes
    end
    
    methods
        function obj = ProbabilityGenerator()
            obj.scalingFactor=0;
            obj.fitResult = 0;
            obj.fitHomeOrigin=0;
            obj.fitHomeDestination=0;
            obj.fitWorkOrigin=0;
            obj.fitWorkDestination=0;
            obj.workNodes=0;
            obj.otherNodes=0;
            obj.homeNodes=0;
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
                error('ERROR: Probability greater than one. Needs more function calls or lower total number of trips.')
            end
        end
        
        function SetTypeProbabilities(obj,graph,homeDestData,homeOriData,workDestData,workOriData,xData)
            obj.workNodes = find(graph.Nodes.Type==1);
            obj.homeNodes = find(graph.Nodes.Type==3);
            obj.otherNodes = find(graph.Nodes.Type==2);           
            
            [X1,Y1] = prepareCurveData(xData,homeDestData);
            [X2,Y2] = prepareCurveData(xData,homeOriData);
            [X3,Y3] = prepareCurveData(xData,workDestData);
            [X4,Y4] = prepareCurveData(xData,workOriData);
            
            ft = fittype('smoothingspline');
            [obj.fitHomeDestination,~] = fit(X1,Y1,ft);
            [obj.fitHomeOrigin,~] = fit(X2,Y2,ft);
            [obj.fitWorkDestination,~] = fit(X3,Y3,ft);
            [obj.fitWorkOrigin,~] = fit(X4,Y4,ft);
            
            
        end
        
        function tripProbability = GetTripProbability(obj,currentTime)            
            tripProbability = obj.fitResult(currentTime)*obj.scalingFactor;            
        end
        
        function [origin,destination] = GetTripType(obj,time)
           r = rand;
           
           if r < obj.fitHomeOrigin(time)
               origin = datasample(obj.homeNodes,1);
           elseif r < obj.fitHomeOrigin(time)+obj.fitWorkOrigin(time)
               origin = datasample(obj.workNodes,1)
           else
               origin = datasample(obj.otherNodes,1)
           end
           
           r = rand;
           
           if r < obj.fitHomeDestination(time)
               destination = datasample(obj.homeNodes,1);
               typeDest = 3;
           elseif r < obj.fitHomeDestination(time)+obj.fitWorkDestination(time)
               destination = datasample(obj.workNodes,1);
               typeDest = 1;
           else
               destination = datasample(obj.otherNodes,1);
               typeDest = 2;
           end
                     
           while (origin==destination)
               switch typeDest
                 case 1
                   destination = datasample(obj.workNodes,1);
                 case 2
                   destination = datasample(obj.otherNodes,1);
                 case 3                   
                   destination = datasample(obj.homeNodes,1);
               end
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