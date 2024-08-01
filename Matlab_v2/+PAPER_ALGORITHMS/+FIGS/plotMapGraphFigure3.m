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
function [] = plotMapGraphFigure3(Gp, alg, color, printFig, mydir)
    LineWidth = 1.5;
    MarkerSize = 7;
    
    mapFilename = './IMG/GIS/Ohio_GIS.png';
    numEdges    = GLASSO_REFACTORED.GRAPH.countEdges( Gp );

    GLASSO_REFACTORED.MAP.plotGraphMap(Gp, color, LineWidth, MarkerSize, mapFilename);
    title(['Ohio River Basin: ' alg '(' num2str(numEdges) ')']);
    axis equal tight;

    w = 12;
    h = 9;
    if printFig
        PLOT.savePngFile([mydir '03_Figure3'],[w h]);
    end 
end

