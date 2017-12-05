function newGraph = InitializeGraph()
%Added 12 node
%INITIALIZEGRAPH Creates a weighted, undirected graph
names = {'Backaplan' 'Brunnsparken' 'Avenyn' 'Andra långgatan' ...
    'Järntorget' 'Gamlestadstorget' 'Korsvägen' 'Backa' 'Angered' 'Bergsjön' ...
    'Lunden' 'Guldheden' 'Majorna' 'Stampen' 'Svingeln' 'Partille'  ...
    'Kviberg' 'Chalmers' 'Wavrinskys plats' 'Marklandsgatan' 'Frölunda' }';

type = [1 1 2 2 1 1 1 3 3 3 3 3 3 3 1 3 1 3 3 3 1]'; % Declare type of node
s = {'Backaplan' 'Brunnsparken' 'Brunnsparken' 'Brunnsparken' 'Avenyn' ...
    'Avenyn' 'Gamlestadstorget' 'Järntorget' 'Backa' 'Angered' 'Kviberg' ...
    'Lunden' 'Chalmers' 'Guldheden' 'Chalmers' 'Majorna' 'Brunnsparken'...
    'Svingeln' 'Svingeln' 'Svingeln' 'Chalmers' 'Guldheden' 'Wavrinskys plats' 'Marklandsgatan' 'Marklandsgatan' 'Kviberg' 'Bergsjön'}; % From
t = {'Brunnsparken' 'Gamlestadstorget' 'Avenyn' 'Järntorget' 'Järntorget' ...
    'Korsvägen' 'Korsvägen' 'Andra långgatan' 'Backaplan' 'Gamlestadstorget' ...
    'Gamlestadstorget' 'Korsvägen' 'Korsvägen' 'Avenyn' 'Järntorget' ...
    'Järntorget' 'Stampen' 'Stampen' 'Gamlestadstorget' 'Partille' ...
    'Wavrinskys plats' 'Wavrinskys plats' 'Marklandsgatan' 'Frölunda' 'Majorna' 'Bergsjön' 'Partille'}; % To
times = [9 14 5 10 7 3 13 1 10 10 6 7 2 4 5 9 5 4 7 12 2 2 10 10 11 8 9]'; % Weights/Times
x = [722 707 701 699 700 729 697 750 798 756 707 682 695 709 712 736 733 690 689 674 649];
y = [953 969 978 947 952 1000 986 981 1050 1073 1001 974 926 985 991 1120 1028 973 968 934 928];
capacity = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]'; % Not implemented
currentLoad = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]'; % Not implemented
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

%Adding new nodes 
NodeProps = table({'Redbergsplatsen' 'Biskopsgården' 'Linnéplatsen' 'Mölndal'}', [1 3 1 3]', 'VariableNames', {'Name' 'Type'});
newGraph = addnode(newGraph,NodeProps);

%Adding new edges 
startDest = {'Redbergsplatsen' 'Redbergsplatsen' 'Redbergsplatsen' 'Biskopsgården' 'Mölndal' 'Mölndal'...
    'Mölndal' 'Järntorget' 'Linnéplatsen' 'Backa'};
endDest = {'Svingeln' 'Gamlestadstorget' 'Brunnsparken' 'Backaplan' 'Korsvägen' 'Frölunda' 'Guldheden' ...
    'Linnéplatsen' 'Avenyn' 'Angered'};
travelTimes = [4 8 13 7 11 10 8 4 8 13];
x2 = [716 724 691 655];
y2 = [1004 890 952 1012];
newGraph = addedge(newGraph,startDest,endDest,travelTimes);
end
