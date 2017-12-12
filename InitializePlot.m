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

%remove names that cover each other
hiddenNames{5} = '';
hiddenNames{19} = '';
 
h = plot(graph, 'NodeLabel', hiddenNames, 'XData',X,'YData',Y);
%h = plot(graph, 'XData',X,'YData',Y);
axis equal
%set(gcf, 'Position', [0, 0, 1100, 850])
highlight(h, empty, 'MarkerSize', 1, 'Marker', 'none'); %hide dividing nodes

xlim([870 1150])
ylim([630 810])

hold on
l = zeros(5,1);

% busy cars driving
l(1) = plot(NaN,NaN,'Color','b','LineWidth',5);
% idle cars driving
l(2) = plot(NaN,NaN,'Color',[0 200/255 1],'LineWidth',5);
% non paired trips
l(3) = plot(NaN,NaN,'Color',[1, 101/255, 0],'Marker','o','MarkerFaceColor',[1, 101/255, ...
                    0],'LineStyle','none');
% paired trips
l(4) = plot(NaN,NaN,'Color',[1, 200/255, 0],'Marker','o','MarkerFaceColor',[1, 200/255, 0],'LineStyle','none');
% idle cars still
l(5) = plot(NaN,NaN,'Color',[0 200/255 1],'Marker','o','MarkerFaceColor',[0 200/255 1],'LineStyle','none');

plot(linspace(1,3),linspace(1,3));
lgn = legend(l,'Busy car moving','Idle car moving','Non-paired trip','Paired trip','Idle car','Location','SE');
lgn.FontSize = 14;

hold off

end