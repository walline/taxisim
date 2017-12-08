function [NewGraph, X, Y] = AddEmptyNodes(Graph, maxWeight, X, Y)

NewGraph = Graph;
nodesList = Graph.Nodes;
nNodes = size(nodesList,1);
nEdges = size(Graph.Edges, 1);

for i = 1:nEdges
    w = Graph.Edges{i,3};
    if(w>maxWeight)
        %remove connection
        source = findnode(NewGraph, Graph.Edges{i,1}{1});
        dest = findnode(NewGraph, Graph.Edges{i,1}{2});
        NewGraph = rmedge(NewGraph, source, dest);
        toAdd = fix(w/maxWeight);
        
        props = table({num2str(nNodes+1)}, 0, 'VariableNames',{'Name', 'Type'});
        NewGraph = addnode(NewGraph, props);
        NewGraph = addedge(NewGraph, source, nNodes+1, w/(toAdd+1));
        
        for j = nNodes+1:nNodes+toAdd-1
            props = table({num2str(j+1)}, 0, 'VariableNames',{'Name', 'Type'});
            NewGraph = addnode(NewGraph, props);
            NewGraph = addedge(NewGraph, j, j+1, w/(toAdd+1));
        end
        
        NewGraph = addedge(NewGraph, nNodes+toAdd, dest, w/(toAdd+1));
        
        X = [X, zeros(1, toAdd)];
        Y = [Y, zeros(1, toAdd)];
        
        xdif = X(dest) - X(source);
        ydif = Y(dest) - Y(source);
        
        for j = 1:toAdd
            c = nNodes + j;
            X(c) = X(source) + j/(toAdd+1) * xdif;
            Y(c) = Y(source) + j/(toAdd+1) * ydif;
        end
        
        nNodes = nNodes + toAdd;
        
    end
    
end

end