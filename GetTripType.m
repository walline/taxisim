function [origin,destination] = GetTripType(time,graph)

% just random nodes so far
% need to implement this with time depending probabilities

numberOfNodes = height(graph.Nodes);
origin = randi(numberOfNodes);
destination = randi(numberOfNodes);

while(origin==destination)
    destination = randi(numberOfNodes);
end
 
    
    



