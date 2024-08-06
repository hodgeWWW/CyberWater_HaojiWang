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
function [ G9, mean_error_summary1, mean_error_summary2, mean_error_summary3, nums_vec1, nums_vec2, nums_vec3 ] = calcMultipleComparison(Ztrain, Xtrain, Xval, Xtest, count, Ks, nonDomSolutions )
    subplotInitIndex = 1;
    
    K1 = Ks(1);
    K2 = Ks(2);
    K3 = Ks(3);
    
    %%
    num_neigbors = 1;
    [Gdist1, Gcorr1, Gk1, nums_vec1, kg, subplotInitIndex, mean_error_summary1] = PAPER_ALGORITHMS.ALTERNATIVE.genComparison(num_neigbors, K1, Ztrain, Xtrain, Xval, Xtest, subplotInitIndex, count, nonDomSolutions);
     
    %%
    num_neigbors = 2;
    [Gdist2, Gcorr2, Gk2, nums_vec2, kg, subplotInitIndex, mean_error_summary2] = PAPER_ALGORITHMS.ALTERNATIVE.genComparison(num_neigbors, K2, Ztrain, Xtrain, Xval, Xtest, subplotInitIndex, count, nonDomSolutions);

    %%
    num_neigbors = 3;
    [Gdist3, Gcorr3, Gk3, nums_vec3, kg, subplotInitIndex, mean_error_summary3] = PAPER_ALGORITHMS.ALTERNATIVE.genComparison(num_neigbors, K3, Ztrain, Xtrain, Xval, Xtest, subplotInitIndex, count, nonDomSolutions);

    %%
    p = size(Ztrain,2);
    G9 = zeros(p,p,12);

    G9(:,:,1) = Gdist1;
    G9(:,:,2) = Gcorr1;
    G9(:,:,3) = Gk1;

    G9(:,:,4) = Gdist2;
    G9(:,:,5) = Gcorr2;
    G9(:,:,6) = Gk2;

    G9(:,:,7) = Gdist3;
    G9(:,:,8) = Gcorr3;
    G9(:,:,9) = Gk3;
end

