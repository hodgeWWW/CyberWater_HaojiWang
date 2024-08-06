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
function [  ] = plotGraphMap( G, color, LineWidth, MarkerSize, filename)

    if nargin == 2
        LineWidth = 1;
        MarkerSize = 5;
        folder = './IMG/GIS/';
        fname = 'Ohio_GIS.png';
        filename = [folder fname];
    elseif nargin == 4
        folder = './IMG/GIS/';
        fname = 'Ohio_GIS.png';
        filename = [folder fname];
    end
   
    img = imread(filename);
    
    image([-89 -79],[-43 -36],img);   %原来是image([-89 -77],[-43 -35],img); 
       
    hold on;
    GLASSO_REFACTORED.PLOT.plotGraphYinv(G, 0, color, LineWidth, MarkerSize);

end

