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
function [ mean_test_error_summary, Gk1, nseScoresMat, nse8sMat ] = runPaperAlgorithmForDataSets( Ztrain, Zval, Ztest, Xtrain, Xval, Xtest, Ytrain, Yval, Ytest, Kvec, k_sel, loadIfexists, plotFigures, nseThreshold, num)
    %% Selection of Graph Model (SGM) Settings:
    p = size(Ztrain,2);
    count = PAPER_ALGORITHMS.CONF.getTopCount(p);
    [ lambda_min, lambda_max, lambda2 ] = PAPER_ALGORITHMS.CONF.getLambdas();

    %% Other settings:
    [ donorGroup, targetGroup, list, blacklist ] = PAPER_ALGORITHMS.CONF.getDefaultDonorTargetGroupsAndScreening(p);
    [ res, seq, Xspace ] = PAPER_ALGORITHMS.CONF.getSimSettings();
                               
    Kmin = Kvec(1);
    Kmax = Kvec(end);
    [ fnameAll, fnameopt, mydir, fname, fnameLocal ] = PAPER_ALGORITHMS.CONF.getFileSettings(Kmin, Kmax, lambda_min, lambda_max);

    %% Run or Load Simulation:
    [ multi_objective_points, nonDomSolutions, localMinSolutions ] = PAPER_ALGORITHMS.HELPER.runOrLoadSelectionGraphicalModel( Xtrain, Xval, lambda_min, lambda_max, Kvec, res, seq, lambda2, list, Xspace, donorGroup, targetGroup, fnameAll, fnameopt, fnameLocal, loadIfexists);

    %% Compute Data for Figures
    [ G9, Gk_tensor, mean_error_summary1, mean_error_summary2, mean_error_summary3, nk, mylabels, nums_vec1, nums_vec2, nums_vec3 ] = PAPER_ALGORITHMS.CALC.calcFigure4alternative( k_sel, count, Ztrain, Xtrain, Xval, Xtest, list, donorGroup, targetGroup, localMinSolutions );
    
    %% Get the Graph to use
    [Gdist1, Gcorr1, Gk1, Gdist2, Gcorr2, Gk2, Gdist3, Gcorr3, Gk3] = PAPER_ALGORITHMS.UTIL.getGraphs(G9);
    
    Gk = Gk2;
    k = GLASSO_REFACTORED.GRAPH.countEdges(Gk2);
    
    mean_test_error_summary  = PAPER_ALGORITHMS.ALTERNATIVE.getMeanErrorSummary( mean_error_summary1, mean_error_summary2, mean_error_summary3 );
    [best_rem, nse_test, bestK, NUM, numSubPlots, Xpred_test, G, powerNorm] = PAPER_ALGORITHMS.CALC.calcFigure6( Gk, Xtrain, Xval, Xtest, blacklist, donorGroup, targetGroup );
 
    [ colorDist, colorCorr, colorGlasso ] = PAPER_ALGORITHMS.ALTERNATIVE.PLOT.getComparisonColors();
    [Gdist1, Gcorr1, Gk1, Gdist2, Gcorr2, Gk2, Gdist3, Gcorr3, Gk3] = PAPER_ALGORITHMS.UTIL.getGraphs(G9);

    
    figuresDir = [mydir 'FIGURES/'];
    mkdir(figuresDir);
    if plotFigures
       
        %% Figure 1 (Place holder):
        figure;
    
        %% Figure 2 (Manuscript):    
        PAPER_ALGORITHMS.FIGS.plotAndPrintFigure2( Ztrain, multi_objective_points, nonDomSolutions, k_sel, k, list, donorGroup, targetGroup, mean_test_error_summary, figuresDir, fname, plotFigures );

        %% Figure 3 (Manuscript):
        figure;
        PAPER_ALGORITHMS.FIGS.plotMapGraphFigure3(Gcorr2, 'Corr', colorCorr, plotFigures, figuresDir);
    end
    
    %% Figure 4 (Manuscript):
    w2 = 16;
    h2 = 12;
    [nseScores, nse8s] = PAPER_ALGORITHMS.FIGS.plotAndPrintFigure4( G9, Xtrain, Xval, Xtest, blacklist, donorGroup, targetGroup, k_sel, figuresDir, fname, w2, h2, nseThreshold, plotFigures, num );

    nseScoresMat = reshape(nseScores, 3, 3)';
    nse8sMat = reshape(nse8s, 3, 3)';

    if plotFigures
        %% Figure 5 (Manuscript):
        meanNseScore = mean(nseScoresMat);
        meanNse8 = mean(nse8sMat);
        PAPER_ALGORITHMS.FIGS.plotNewFigure5(nseScoresMat,meanNseScore, nse8sMat, meanNse8, figuresDir, plotFigures);

        %% Figure 6 (Manuscript):
        w = 14;
        h = 14;
        PAPER_ALGORITHMS.FIGS.plotAndPrintFigure6( bestK, NUM, numSubPlots, Xtest, Xpred_test, Gk, powerNorm, plotFigures, figuresDir, fname, k_sel, w, h );

        %% Figure 7 (Manuscript):
        figure;
        w = 12;
        h = 9;
        k = GLASSO_REFACTORED.GRAPH.countEdges(Gk1);
        PAPER_ALGORITHMS.FIGS.plotAndPrintFigure7( Gk1, k, k_sel, w, h, figuresDir, fname, plotFigures );
    end   
end

