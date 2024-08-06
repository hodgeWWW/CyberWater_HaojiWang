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

clc; clear; close all; 
%% Run Algorithm: **(set to "full" for similar results as Figure 2B in the paper.)
mode = "fast"; % {"fast", "semi-fast", "full"}   %原来是fast

[ Kmin, Kmax, Kvec, k_sel ] = PAPER_ALGORITHMS.CONF.getKsettings(mode);

%% Get Data:
[ ZtrainSs, ZvalSs, ZtestSs, XtrainSs, XvalSs, XtestSs, YtrainSs, YvalSs, YtestSs ] = PREPAREDATA.getDataSetsRandomJoinTrainVal();

%% Random Sampling
useBootstrapping = false; % Random resampling with replacement (true/false) ? false: for main paper 
numSamples = 1;  

%% Plot Settings
plotFigures = true;

%% Other settings:
loadIfexists = false;                                                                                                                                                                                                                                                                                                                                           ; %false; 


nseThreshold = 0.7; %改，本来是0.7
num = 8;

mean_r2_summary = zeros(numSamples, 3 * 3);
f5_nseScoresMat = zeros(numSamples, 3 * 3);
f5_nse8sMat = zeros(numSamples, 3 * 3);
tic
data_folder = PREPAREDATA.getDataFolder();
[ gauge_id, Elevation, Latitude, Longitude, Area ] = PREPAREDATA.getFeatures2(data_folder);

nseScoresMat = zeros(3,3);
nse8sMat = zeros(3,3);

tStart = tic;
for index = 1:numSamples
    [ Ztrain_i, Zval_i, Ztest_i, Xtrain_i, Xval_i, Xtest_i, Ytrain_i, Yval_i, Ytest_i ] = PREPAREDATA.getDataSubSetByIndex( ZtrainSs, ZvalSs, ZtestSs, XtrainSs, XvalSs, XtestSs, YtrainSs, YvalSs, YtestSs, index );
    [ mean_r2_summary_i, Gk1, nseScoresMat_i, nse8sMat_i ] = PAPER_ALGORITHMS.HELPER.runPaperAlgorithmForDataSets(Ztrain_i, Zval_i, Ztest_i, Xtrain_i, Xval_i, Xtest_i, Ytrain_i, Yval_i, Ytest_i, Kvec, k_sel, loadIfexists, plotFigures, nseThreshold, num);
     tmp = reshape(mean_r2_summary_i, 1, 3 * 3);
     mean_r2_summary(index, :) = tmp;
     
     tmp = reshape(nseScoresMat_i, 1, 3 * 3);
     f5_nseScoresMat(index, :) = tmp;
     
     tmp = reshape(nse8sMat_i, 1, 3 * 3);
     f5_nse8sMat(index, :) = tmp;
     
     nseScoresMat = nseScoresMat + nseScoresMat_i;
     nse8sMat = nse8sMat + nse8sMat_i;
     
     display([num2str(index) ' out of ' num2str(numSamples) ]);
end
tEnd = toc(tStart);
display(tEnd);

nseScoresMat = nseScoresMat / numSamples;
nse8sMat = nse8sMat / numSamples;

meanNseScore = mean(nseScoresMat);
meanNse8 = mean(nse8sMat);

