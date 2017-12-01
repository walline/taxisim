function newGraph = InitializeGraph()
%Added 1 node
%INITIALIZEGRAPH Creates a weighted, undirected graph
names = {'Backaplan' 'Brunnsparken' 'Avenyn' 'Andra långgatan' ...
    'Järntorget' 'Gamlestadstorget' 'Korsvägen' 'Backa' 'Angered' 'Bergsjön' ...
    'Home4' 'Home5' 'Majorna' 'Home7'}';
type = [1 1 2 2 1 1 1 3 3 3 3 3 3 3]'; % Declare type of node
s = {'Backaplan' 'Brunnsparken' 'Brunnsparken' 'Brunnsparken' 'Avenyn' ...
    'Avenyn' 'Gamlestadstorget' 'Järntorget' 'Backa' 'Angered' 'Bergsjön' ...
    'Home4' 'Home5' 'Home5' 'Home5' 'Majorna' 'Brunnsparken'}; % From
t = {'Brunnsparken' 'Gamlestadstorget' 'Avenyn' 'Järntorget' 'Järntorget' ...
    'Korsvägen' 'Korsvägen' 'Andra långgatan' 'Backaplan' 'Gamlestadstorget' ...
    'Gamlestadstorget' 'Korsvägen' 'Korsvägen' 'Avenyn' 'Järntorget' ...
    'Järntorget' 'Home7'}; % To
times = [9 14 5 10 7 3 13 1 10 4 14 7 2 4 5 9 5]'; % Weights/Times
capacity = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]'; % Not implemented
currentLoad = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]'; % Not implemented
EdgeTable = table([s' t'],capacity,times, currentLoad, ...
    'VariableNames',{'EndNodes' 'Capacity' 'Weight' 'CurrentLoad'});
NodeTable = table(names, type, 'VariableNames',{'Name', 'Type'});
newGraph = graph(EdgeTable, NodeTable); % Create graph
h = plot(newGraph, 'NodeLabel', newGraph.Nodes.Name,'EdgeLabel',newGraph.Edges.Weight);
% Increase size of nodes wrt their type
highlight(h, find(newGraph.Nodes.Type == 1), 'MarkerSize', 8) 
highlight(h, find(newGraph.Nodes.Type == 2), 'MarkerSize', 6)

% How to find shortest path:
[path, d] = shortestpath(newGraph, 'Backaplan', 'Brunnsparken'); %Dijkstras

% Retrieve adjacency matrix (if we need it):
nn = numnodes(newGraph);
[s,t] = findedge(newGraph);
A = sparse(s,t,newGraph.Edges.Weight,nn,nn);
full(A);

end

