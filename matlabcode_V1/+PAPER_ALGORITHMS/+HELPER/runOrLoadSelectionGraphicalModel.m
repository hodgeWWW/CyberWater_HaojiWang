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
function [ multi_objective_points, nonDomSolutions, localMinSolutions ] = runOrLoadSelectionGraphicalModel( Xtrain, Xval, lambda_min, lambda_max, Kvec, res, seq, lambda2, list, Xspace, donorGroup, targetGroup, fnameAll, fnameopt, fnameLocal, loadIfexists )
    tic
    if (exist(fnameAll, 'file') == 2 && loadIfexists)
       display('exists: Loading from file system...');

       %% Load Simulation Results and  Optimum Results:
       multi_objective_points = dlmread(fnameAll);
       nonDomSolutions = dlmread(fnameopt);
       localMinSolutions = dlmread(fnameLocal);
    else
       display('does not exist: Running Simulation...'); 

       %% Run the Selection of Graph Model (SGM) algorithm and Save results:
       [ multi_objective_points,  nonDomSolutions, ~, localMinSolutions] = PAPER_ALGORITHMS.MAIN.SelectionGraphicalModel( Xtrain, Xval, lambda_min, lambda_max, Kvec, res, seq, lambda2, list, Xspace, donorGroup, targetGroup);
     
       %% 
       dlmwrite(fnameAll,multi_objective_points);
       dlmwrite(fnameopt,nonDomSolutions);
       dlmwrite(fnameLocal,localMinSolutions);
    end    
    toc

end

