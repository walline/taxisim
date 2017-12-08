function [newGraph, X, Y] = InitializeGraph()
%Added 12 node
%INITIALIZEGRAPH Creates a weighted, undirected graph
names = {'Backaplan' 'Brunnsparken' 'Avenyn' 'Andra langgatan' ...
    'Jarntorget' 'Gamlestadstorget' 'Korsvagen' 'Backa' 'Angered' 'Bergsjon' ...
    'Lunden' 'Guldheden' 'Majorna' 'Stampen' 'Svingeln' 'Partille'  ...
    'Kviberg' 'Chalmers' 'Wavrinskys plats' 'Marklandsgatan' 'Frolunda' }';

type = [1 1 2 2 1 1 1 3 3 3 3 3 3 3 1 3 1 3 3 3 1]'; % Declare type of node
% 1 - work, 2 - entertainment, 3 - home, 0 - empty
s = {'Backaplan' 'Brunnsparken' 'Brunnsparken' 'Brunnsparken' 'Avenyn' ...
    'Avenyn' 'Jarntorget' 'Backa' 'Angered' 'Kviberg' ...
    'Lunden' 'Chalmers' 'Guldheden' 'Chalmers' 'Majorna' 'Brunnsparken'...
    'Svingeln' 'Svingeln' 'Chalmers' 'Guldheden' 'Wavrinskys plats'...
    'Marklandsgatan' 'Marklandsgatan' 'Kviberg' 'Bergsjon'}; % From
t = {'Brunnsparken' 'Gamlestadstorget' 'Avenyn' 'Jarntorget' 'Jarntorget' ...
    'Korsvagen' 'Andra langgatan' 'Backaplan' 'Gamlestadstorget' ...
    'Gamlestadstorget' 'Korsvagen' 'Korsvagen' 'Chalmers' 'Jarntorget' ...
    'Jarntorget' 'Stampen' 'Stampen' 'Gamlestadstorget' ...
    'Wavrinskys plats' 'Wavrinskys plats' 'Marklandsgatan' 'Frolunda' 'Majorna' 'Bergsjon' 'Partille'}; % To
times = [9 14 5 10 7 3 1 10 10 6 7 2 5 5 9 5 4 7 2 2 10 10 11 8 9]'; % Weights/Times
x = [722 707 701 699 700 729 697 750 798 756 707 682 695 709 712 736 733 690 689 674 649];
y = [953 969 978 947 952 1000 986 981 1050 1073 1001 974 926 985 991 1120 1028 973 968 934 928];
capacity = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]'; % Not implemented
currentLoad = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]'; % Not implemented
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
NodeProps = table({'Redbergsplatsen' 'Biskopsgarden' 'Linneplatsen' 'Molndal' 'Tuve' 'Eklanda' 'Kalltorp'}',...
    [1 3 1 3 3 3 3]', 'VariableNames', {'Name' 'Type'});
newGraph = addnode(newGraph,NodeProps);

%Adding new edges 
startDest = {'Redbergsplatsen' 'Redbergsplatsen' 'Biskopsgarden' 'Molndal' ...
    'Molndal' 'Jarntorget' 'Linneplatsen' 'Backa' 'Backaplan' 'Backa' 'Biskopsgarden' 'Eklanda' ...
    'Eklanda' 'Lunden' 'Kalltorp' 'Majorna' 'Angered' 'Partille' 'Wavrinskys plats' 'Marklandsgatan'...
    'Majorna' 'Partille' 'Kalltorp' 'Kalltorp' 'Lunden'};
endDest = {'Svingeln' 'Gamlestadstorget' 'Backaplan' 'Korsvagen' 'Guldheden' ...
    'Linneplatsen' 'Avenyn' 'Angered' 'Tuve' 'Tuve' 'Tuve' 'Frolunda' 'Molndal' 'Molndal' ...
    'Lunden' 'Biskopsgarden' 'Bergsjon' 'Kalltorp' 'Linneplatsen' 'Linneplatsen' 'Linneplatsen'...
    'Kviberg' 'Redbergsplatsen' 'Kviberg' 'Redbergsplatsen'};
travelTimes = [4 8 7 11 8 4 8 13 11 10 14 8 7 11 8 11 12 14 7 8 8 11 7 8 4];
x2 = [716 724 691 655 755 650 716];
y2 = [1004 890 952 1012 934 965 1033];

X=[x, x2];
Y=[y, y2];

newGraph = addedge(newGraph,startDest,endDest,travelTimes);
plot(newGraph, 'XData',X,'YData',Y)
end
