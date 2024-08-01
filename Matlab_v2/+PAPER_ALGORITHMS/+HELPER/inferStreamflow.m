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
function [ Xtrain_pred, Xval_pred, Xtest_pred ] = inferStreamflow( Xtrain, Xval, Xtest, G )
  % 3:'Glasso' and 2:'RegressionZYX' should be equivalent
  
  inferenceAlgorithm = PAPER_ALGORITHMS.CONF.getStreamflowInferenceAlg();
  
  if inferenceAlgorithm == 1
    [ Xtrain_pred, Xval_pred, Xtest_pred ] = BENCHMARK.Inference.getXbyRegressionY( Xtrain, Xval, Xtest, G ); % 1
  elseif inferenceAlgorithm == 2
    [ Xtrain_pred, Xval_pred, Xtest_pred ] = BENCHMARK.Inference.getXbyRegressionZ( Xtrain, Xval, Xtest, G ); % 2
  elseif inferenceAlgorithm == 3
     [ Xtrain_pred, Xval_pred, Xtest_pred ] = PAPER_ALGORITHMS.ALG.getXbyGlasso( Xtrain, Xval, Xtest, G ); % 3
  else
    [ Xtrain_pred, Xval_pred, Xtest_pred ] = BENCHMARK.Inference.getXbyRegressionX( Xtrain, Xval, Xtest, G ); % 0
  end  
 
end

