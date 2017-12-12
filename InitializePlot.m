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

hold on
l = zeros(5,1);

% busy cars driving
l(1) = plot(NaN,NaN,'Color','r','LineWidth',5);
% idle cars driving
l(2) = plot(NaN,NaN,'Color','m','LineWidth',5);
% non paired trips
l(3) = plot(NaN,NaN,'Color',[1, 101/255, 0],'Marker','o','MarkerFaceColor',[1, 101/255, ...
                    0],'LineStyle','none');
% paired trips
l(4) = plot(NaN,NaN,'Color','y','Marker','o','MarkerFaceColor','y','LineStyle','none');
% idle cars still
l(5) = plot(NaN,NaN,'Color','m','Marker','o','MarkerFaceColor','m','LineStyle','none');

plot(linspace(1,3),linspace(1,3));
lgn = legend(l,'Busy car','Idle car','Non-paired trip','Paired trip','Idle car','Location','eastoutside');
lgn.FontSize = 14;

hold off



end