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
function [ G9, Gk_tensor, mean_error_summary1, mean_error_summary2, mean_error_summary3, nk, mylabels, nums_vec1, nums_vec2, nums_vec3 ] = calcFigure3alternative( k_sel, count, Ztrain, Xtrain, Xval, Xtest, list, donorGroup, targetGroup, nonDomSolutions )
    
    [G9, mean_error_summary1, mean_error_summary2, mean_error_summary3, nums_vec1, nums_vec2, nums_vec3] = PAPER_ALGORITHMS.ALTERNATIVE.calcMultipleComparison(Ztrain, Xtrain, Xval, Xtest, count, k_sel, nonDomSolutions);
    lambda_k = [0 528];   %改，原来是[0 561]
 
    nk = size(lambda_k, 1);
    p = size(Ztrain,2);
    Gk_tensor = zeros(p, p, nk + 9); % to store 9 more graphs
    for i = 1:nk
        lambda = lambda_k(i,1);
        k = lambda_k(i,2);
        Gki  = PAPER_ALGORITHMS.HELPER.calcGraph( Ztrain, k, lambda, list, donorGroup, targetGroup);
        Gk_tensor(:,:,i) = Gki;
        mylabels{i} = ['SGM(' num2str(k) ')'];
    end
    
    for i = 1:9
        Gki = G9(:,:,i);
        Gk_tensor(:,:,nk + i) = Gki;
        ki = GLASSO_REFACTORED.GRAPH.countEdges(Gki);
        if (mod(i,3) == 1)
            mylabels{nk + i} = ['Dist(' num2str(ki) ')'];
        elseif (mod(i,3) == 2)
            mylabels{nk + i} = ['Corr(' num2str(ki) ')'];
        else
            mylabels{nk + i} = ['SGM(' num2str(ki) ')'];
        end
    end

end

