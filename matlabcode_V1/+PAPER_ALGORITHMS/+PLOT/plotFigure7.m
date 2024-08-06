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
function [  ] = plotFigure7(Gk,k, data_folder)

% figure;

XY = PREPAREDATA.getXYcoordinates();
folder = './IMG/GIS/';
powerNorm = 2;
features = PREPAREDATA.getFeaturesExt(data_folder);
Q = 1;

% Map of Categories
blue   = [0 0 1];
green  = [0 1 0];
yellow = [1 1 0];
red    = [1 0 0];
cyan   = [0 1 1];

subplot(2,2,1);
%% Elevation:
elevation = features(:,5);
Ke = 4;
[ ~, groups, Jmine ] = Kmean.calcKmeansBest( elevation, Ke, 1000, 1e-6, Q );
fname = 'OH_dem.png';
filename = [folder fname];
map  = [cyan; green; yellow; red]; %change!!!
GLASSO_REFACTORED.MAP.plotClusterMap(XY, groups, ['Elevation: SGM(' num2str(k) ')'],filename, map, Gk, powerNorm );

subplot(2,2,2);
%% Slope:
slope = features(:,6);
Ks = 4;
[ ~, groups, Jmins ] = Kmean.calcKmeansBest( slope, Ks, 1000, 1e-6, Q );
fname = 'OH_Slope.png';
filename = [folder fname];
map  = [blue; green; yellow; red]; %change!!!
GLASSO_REFACTORED.MAP.plotClusterMap(XY, groups, ['Slope: SGM(' num2str(k) ')'],filename, map, Gk, powerNorm );


subplot(2,2,3);
%% Soil Type:
[ soiltype, classes ] = PREPAREDATA.getSoilType(data_folder);
[ ~, groups] = ANALYSIS.HISTOGRAM.getMajorityClass( soiltype, classes );
map  = ANALYSIS.HISTOGRAM.getSoiltypeColorMap();
fname = 'OH_soiltytpe.png';
filename = [folder fname];
GLASSO_REFACTORED.MAP.plotClusterMap(XY, groups, ['Soil Type: SGM(' num2str(k) ')'],filename, map, Gk, powerNorm );


subplot(2,2,4);
%% Land Cover:
[ land_cover, classes ] = PREPAREDATA.getLandCover(data_folder);
[ ~, groups] = ANALYSIS.HISTOGRAM.getMajorityClass( land_cover, classes );
map  = ANALYSIS.HISTOGRAM.getLandCoverColorMap();
fname = 'OH_landCover.png';
filename = [folder fname];
GLASSO_REFACTORED.MAP.plotClusterMap(XY, groups, ['Land Cover: SGM(' num2str(k) ')'],filename, map, Gk, powerNorm );


%改：以下两行为修改的 
adjacency=Gk; % I made acopy instead of original name
save('connect.mat','adjacency');
end

