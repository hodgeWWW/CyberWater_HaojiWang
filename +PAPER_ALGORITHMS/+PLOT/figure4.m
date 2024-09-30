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
function [graphScores, nse8s] = figure4( G9, Xtrain, Xval, Xtest, blacklist, donorGroup, targetGroup, mydir, nseThreshold, plotFigure, num )
   [Gdist1, Gcorr1, Gk1, Gdist2, Gcorr2, Gk2, Gdist3, Gcorr3, Gk3] = PAPER_ALGORITHMS.UTIL.getGraphs(G9);
   
   maxDonors = 3; 
   maxSize = 3 * maxDonors;
   graphScores = zeros(maxSize,1);
   nse8s     = zeros(maxSize,1);
   
   %% Single Donor Results:
   donors = 1;
   [graphScore_dist1, graphScore_corr1, graphScore_sgm1, nse8_dist1, nse8_corr1, nse8_sgm1, nse_test_dist1, nse_test_corr1, nse_test_sgm1,  best_rem_dist1, best_rem_corr1, best_rem_sgm1] = PAPER_ALGORITHMS.CALC.calcGraphScores(Gdist1, Gcorr1, Gk1, donors, nseThreshold, Xtrain, Xval, Xtest, blacklist, donorGroup, targetGroup, mydir, num);

   %% Two Donors Results:
   donors = 2;
   [graphScore_dist2, graphScore_corr2, graphScore_sgm2, nse8_dist2, nse8_corr2, nse8_sgm2, nse_test_dist2, nse_test_corr2, nse_test_sgm2,  best_rem_dist2, best_rem_corr2, best_rem_sgm2] = PAPER_ALGORITHMS.CALC.calcGraphScores(Gdist2, Gcorr2, Gk2, donors, nseThreshold, Xtrain, Xval, Xtest, blacklist, donorGroup, targetGroup, mydir, num);
   
   %% Three Donors Results:
   donors = 3;
   [graphScore_dist3, graphScore_corr3, graphScore_sgm3, nse8_dist3, nse8_corr3, nse8_sgm3, nse_test_dist3, nse_test_corr3, nse_test_sgm3,  best_rem_dist3, best_rem_corr3, best_rem_sgm3] = PAPER_ALGORITHMS.CALC.calcGraphScores(Gdist3, Gcorr3, Gk3, donors, nseThreshold, Xtrain, Xval, Xtest, blacklist, donorGroup, targetGroup, mydir, num);
    
   graphScores(1) = graphScore_dist1;
   graphScores(2) = graphScore_corr1;
   graphScores(3) = graphScore_sgm1;
   graphScores(4) = graphScore_dist2;
   graphScores(5) = graphScore_corr2;
   graphScores(6) = graphScore_sgm2;
   graphScores(7) = graphScore_dist3;
   graphScores(8) = graphScore_corr3;
   graphScores(9) = graphScore_sgm3;
 
   nse8s(1) = nse8_dist1;
   nse8s(2) = nse8_corr1; 
   nse8s(3) = nse8_sgm1;
   nse8s(4) = nse8_dist2;
   nse8s(5) = nse8_corr2; 
   nse8s(6) = nse8_sgm2;
   nse8s(7) = nse8_dist3;
   nse8s(8) = nse8_corr3; 
   nse8s(9) = nse8_sgm3;
   
   if plotFigure
       figure;
       maxDonors = 3;
       [ colorDist, colorCorr, colorGlasso ] = PAPER_ALGORITHMS.ALTERNATIVE.PLOT.getComparisonColors();
       subplot(maxDonors,3,1);
       PAPER_ALGORITHMS.PLOT.figure6( best_rem_dist1, colorDist, Gdist1, nse_test_dist1, 'Dist', graphScore_dist1 );
       subplot(maxDonors,3,2);
       PAPER_ALGORITHMS.PLOT.figure6( best_rem_corr1, colorCorr, Gcorr1, nse_test_corr1, 'Corr', graphScore_corr1 );
       subplot(maxDonors,3,3);
       PAPER_ALGORITHMS.PLOT.figure6( best_rem_sgm1, colorGlasso, Gk1, nse_test_sgm1, 'SGM', graphScore_sgm1 );

       subplot(maxDonors,3,4);
       PAPER_ALGORITHMS.PLOT.figure6( best_rem_dist2, colorDist, Gdist2, nse_test_dist2, 'Dist', graphScore_dist2 );
       subplot(maxDonors,3,5);
       PAPER_ALGORITHMS.PLOT.figure6( best_rem_corr2, colorCorr, Gcorr2, nse_test_corr2, 'Corr', graphScore_corr2 );
       subplot(maxDonors,3,6);
       PAPER_ALGORITHMS.PLOT.figure6( best_rem_sgm2, colorGlasso, Gk2, nse_test_sgm2, 'SGM', graphScore_sgm2 );

       subplot(maxDonors,3,7);
       PAPER_ALGORITHMS.PLOT.figure6( best_rem_dist3, colorDist, Gdist3, nse_test_dist3, 'Dist', graphScore_dist3 );
       subplot(maxDonors,3,8);
       PAPER_ALGORITHMS.PLOT.figure6( best_rem_corr3, colorCorr, Gcorr3, nse_test_corr3, 'Corr', graphScore_corr3 );
       subplot(maxDonors,3,9);
       PAPER_ALGORITHMS.PLOT.figure6( best_rem_sgm3, colorGlasso, Gk3, nse_test_sgm3, 'SGM', graphScore_sgm3 );

       EXTERNAL.tightfig.tightfig;
   end
end

