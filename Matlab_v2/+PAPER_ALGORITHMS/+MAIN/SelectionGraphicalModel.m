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
function [ multi_objective_points, nonDomSolutions, lambda_vec, localMinSolutions ] = SelectionGraphicalModel( Xtrain, Xval, lambda_min, lambda_max, Kvec, res, seq, lambda2, list, Xspace, donorGroup, targetGroup)

    p = size(Xtrain,2);
    
    %Glasso Settings
    Gfull = PAPER_ALGORITHMS.UTIL.getFullGraph(p,list, donorGroup, targetGroup);

    tol = 1e-10;   % 改： tol = 1e-6; 
    maxIter = 1000;
    
    %Estimation
    sims = res * (size(Kvec,2));
    iter = 0;
    error_val = inf;
    min_error_val = error_val;
    
    %Result:
    multi_objective_points = zeros(sims,3+p);

    %% Step 1:  
     lambda_vec = ANALYSIS.genSequence(lambda_min, lambda_max, res, seq);

    tic
    
    [Ztrain, muy_train, sigmay_train] = PREPAREDATA.getDataZ(Xtrain);
    [Zval,  ~,  ~]   = PREPAREDATA.getDataZ(Xval);
    % Do not include the door gauges in the calculation of the error
    list = UTIL.removeFromList( list, donorGroup );
    
    for i=1:res
        lambda = lambda_vec(i);
        
        % Equation (20), replacing S by Strain:
        Theta_train1 = GLASSO_REFACTORED.GLASSO.GlassoFortran2( lambda, Ztrain, 0, 0, maxIter, tol, Gfull );          
      
        for k=Kvec
            %% Convert Precision matrix to Graph ( Equation (22) ):
            Gk = GLASSO_REFACTORED.NON_ZEROS.prec2graph(Theta_train1, k);                                        
            if (lambda2 < 0)
                % Equation (23):
                Theta_train2 = GLASSO_REFACTORED.GLASSO.GlassoFortran2( lambda, Ztrain, 0, 0, maxIter, tol, Gk );     
            else
                % Equation (23):
                Theta_train2 = GLASSO_REFACTORED.GLASSO.GlassoFortran2( lambda2, Ztrain, 0, 0, maxIter, tol, Gk );     
            end
            
             % Equation (21) for each i in 1 <= i <= p:
            Alpha_train = GLASSO_REFACTORED.LIN_REG.computeRegressionMatrixByPrec( Theta_train2 );                

            % Equation 24:
            Zval_pred = Zval * Alpha_train; 
            
            count = PAPER_ALGORITHMS.CONF.getTopCount( p );
            
            if count > size(list,2)
                count = size(list,2);
            end
            
            discardFrac = 1 - count / p;
            
            if Xspace
                % Equation 25:
                Yval_pred  = GLASSO_REFACTORED.TRANS.getYfromZ( Zval_pred,  muy_train, sigmay_train );
                
                % Equation 26:
                Xval_pred   = GLASSO_REFACTORED.TRANS.getXfromY( Yval_pred );
                
                [ error_val, ind_error, count_R2val ] = PAPER_ALGORITHMS.HELPER.calcError( Xval_pred, Xval, list, discardFrac );
            else
                [ error_val, ind_error, count_R2val ] = PAPER_ALGORITHMS.HELPER.calcError( Zval_pred, Zval, list, discardFrac );
            end
            
            if error_val < min_error_val
                min_error_val = error_val;
            end
            
            iter = PAPER_ALGORITHMS.UTIL.printStatus(iter, sims, error_val, min_error_val); 
            multi_objective_points(iter,:) = [k, lambda, error_val ind_error];
        end
    end  
    
    %% Get Set of Non-Dominated Solutions
    num_edges_vec = multi_objective_points(:,1);
    error_vec  = multi_objective_points(:,3);
    [nonDomSolsIdx, localMinSolsIdx]  = GLASSO_REFACTORED.MULTI_OPT.selectNonDominatedSolutions( num_edges_vec, error_vec );

    nonDomSolutions = multi_objective_points(nonDomSolsIdx,:);
    localMinSolutions = multi_objective_points(localMinSolsIdx,:);

end

