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
function [graphScore_dist, graphScore_corr, graphScore_sgm, nse8_dist, nse8_corr, nse8_sgm, nse_test_dist, nse_test_corr, nse_test_sgm, best_rem_dist, best_rem_corr, best_rem_sgm] = calcGraphScores(Gdist, Gcorr, Gsgm, donors, nseThreshold, Xtrain, Xval, Xtest, blacklist, donorGroup, targetGroup, mydir, num)
   [best_rem_dist, nse_test_dist] = PAPER_ALGORITHMS.CALC.calcFigure6( Gdist, Xtrain, Xval, Xtest, blacklist, donorGroup, targetGroup );
   [ ~,~, nse8_dist] = PAPER_ALGORITHMS.FIGS.genTable2( best_rem_dist, nse_test_dist, mydir, ['Dist' num2str(donors)], num );

   [best_rem_corr, nse_test_corr] = PAPER_ALGORITHMS.CALC.calcFigure6( Gcorr, Xtrain, Xval, Xtest, blacklist, donorGroup, targetGroup );
   [ ~, ~, nse8_corr] = PAPER_ALGORITHMS.FIGS.genTable2( best_rem_corr, nse_test_corr, mydir, ['Corr' num2str(donors)], num );
   
   [best_rem_sgm, nse_test_sgm] = PAPER_ALGORITHMS.CALC.calcFigure6( Gsgm, Xtrain, Xval, Xtest, blacklist, donorGroup, targetGroup );
   [ ~, ~, nse8_sgm] = PAPER_ALGORITHMS.FIGS.genTable2( best_rem_sgm, nse_test_sgm, mydir, ['SGM' num2str(donors)], num );
   
   m_RemDist = PAPER_ALGORITHMS.CALC.calcNumberOfRemovals(best_rem_dist, nse_test_dist, nseThreshold);
   m_RemCorr = PAPER_ALGORITHMS.CALC.calcNumberOfRemovals(best_rem_corr, nse_test_corr, nseThreshold);
   m_RemSgm = PAPER_ALGORITHMS.CALC.calcNumberOfRemovals(best_rem_sgm, nse_test_sgm, nseThreshold);
   
   m_rem = max([m_RemDist, m_RemCorr, m_RemSgm]);
   graphScore_dist = PAPER_ALGORITHMS.CALC.calcGraphScore( best_rem_dist, nse_test_dist, m_rem, nseThreshold );
   graphScore_corr = PAPER_ALGORITHMS.CALC.calcGraphScore( best_rem_corr, nse_test_corr, m_rem, nseThreshold );
   graphScore_sgm  = PAPER_ALGORITHMS.CALC.calcGraphScore( best_rem_sgm,  nse_test_sgm,  m_rem, nseThreshold );
end

