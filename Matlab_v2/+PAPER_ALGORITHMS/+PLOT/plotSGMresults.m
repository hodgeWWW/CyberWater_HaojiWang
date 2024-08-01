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
function [  ] = plotSGMresults( multi_objective_points,  nonDomSolutions, k_sel, colors )
%multi_objective_points: [k, lambda, error_val:(1-R2val_vec')]

hold on;
scatter(multi_objective_points(:,1), multi_objective_points(:,3), 5,'LineWidth',0.6,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0.0 0.0 0.0]);
scatter(nonDomSolutions(:,1),        nonDomSolutions(:,3),        30,'LineWidth',0.6,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0.0 1 0.0]);

nks = size(k_sel,2);
for j=1:nks
    k = k_sel(j);
    idx = (nonDomSolutions(:,1)==k);
    error = nonDomSolutions(idx,3);
    if size(error,1)>0
        scatter(k, error, 60,'LineWidth',0.6,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',colors(j,:));
    else
       idx = (multi_objective_points(:,1)==k); 
       error = min( multi_objective_points(idx,3) );
       scatter(k, error, 60,'LineWidth',0.6,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',colors(j,:));
    end
end
hold off;
   
xlabel('Number of edges');
%ylabel(['Mean ' '1-R^2']);
ylabel(['error_v_a_l']);

end

