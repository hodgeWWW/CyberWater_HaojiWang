% ----------------------------------------------------------------------------------------------
% 
% Copyright (c) 2021, German A. Villalba, Xu Liang, and Yao Liang
% All rights reserved.
% 
% This is our research open source codes for (1) selecting donor gauges and 
% (2) removing gauges with minimum loss of information based on Graphical Model 
% under the Open Source License GPL. 
%
% If you use our codes, please cite our work below. Thanks.
%  
% Villalba, G. A., Liang, X., & Liang, Y. (2021).
% Selection of multiple donor gauges via graphical lasso for estimation of daily streamflow time series. 
% Water Resources Research, 57, e2020WR028936. 
% https://doi.org/10.1029/2020WR028936
% 
% ----------------------------------------------------------------------------------------------
function [  ] = plotClusterMap( XY, groups, desc, filename, map, G, powerNorm)

    if nargin == 4
        folder = 'IMG\GIS\';
        fname = 'OH_overview.png';
        filename = [folder fname];
    end

    img = imread(filename);
    image([-89 -77],[-43 -35],img);      
    
    hold on;
    
    uniqueGroups = unique(groups)';
    for group = uniqueGroups
        indexes = ( groups == group);
        color = map(group,:);
        scatter(XY(indexes,1),-XY(indexes,2),200,'filled','MarkerEdgeColor',[0 0 0],'MarkerFaceColor',color);
    end
    
    GLASSO_REFACTORED.PLOT.plotGraphYinv(G, 0, [1 0 0], 2, 5);
    
    hold off;

    numEdges = GLASSO_REFACTORED.GRAPH.countEdges(G);
    
    title([desc]);% ' (numEdges=' num2str(numEdges) ')' ]);

    axis equal tight;

end

