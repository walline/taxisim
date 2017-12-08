function h = InitializePlot(graph, X, Y)

empty = [];

hiddenNames = graph.Nodes.Name;
nNodes = size(hiddenNames, 1);
for i = 1:nNodes
    if(graph.Nodes.Type(i) == 0)
        hiddenNames{i} = '';
        empty = [empty; i];
    end
end
 
h = plot(graph, 'NodeLabel', hiddenNames, 'XData',X,'YData',Y);
highlight(h, empty, 'MarkerSize', 1, 'Marker', 'none'); %hide dividing nodes

end