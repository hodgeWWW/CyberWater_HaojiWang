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
function [ Ztrain, Zval, Ztest ] = getDataSetsByTestLength( Z, nc, randomStrategy, seed, test_len )
    num_used = 365;
    if nargin~=5
        assert(false);
    end
    
    % Reproducible random number generation:
    rng(seed);
   
    %% Total number of available observations
    n = size(Z,1);
        
    chunk_size = 2*nc + test_len; 
    rs = n - chunk_size; 
    rnd_start_idx = randi(rs);    
    
    set1_idx = rnd_start_idx : rnd_start_idx + nc - 1;
    set2_idx   = rnd_start_idx + nc : rnd_start_idx + 2*nc-1;
    test_idx  = rnd_start_idx + 2*nc : rnd_start_idx + chunk_size-1;

    set1_size = size(set1_idx,2);
    set2_size = size(set2_idx,2);      
    test_size = size(test_idx,2);

    assert(set1_size == nc);
    assert(set2_size == nc);
    assert(test_size == test_len);

    if randomStrategy == 0 %'Sequential Random Start(rand_Train_Val, Test)'
        set_3 = [set1_idx; set2_idx];
        indexes = randperm(2*nc);
        set_3_rand = set_3(indexes);
        train_idx = set_3_rand(1:nc);
        val_idx   = set_3_rand(nc+1:2*nc);
    elseif randomStrategy == 1 %'Sequential Random Start(Train, Val, Test)'
        train_idx = set1_idx;
        val_idx   = set2_idx;
    elseif randomStrategy == 2 %'Sequential Random Start(Val, Train, Test)';
        train_idx = set2_idx;
        val_idx   = set1_idx;
    elseif randomStrategy == 3 %'Sequential Random Start(BS_Train, BS_Val, Test)';
        [train_idx, val_idx] = BOOTSTRAP.bootstrap2( set2_idx );     
        %val_idx   = BOOTSTRAP.bootstrap2( set2_idx );
    elseif randomStrategy == 4 %'Sequential Random Start(Train, Val, Test)'
        ns1 = size(set1_idx,2);
        rindex = randperm(ns1);
        rindex = rindex(1:num_used);
        train_idx = set1_idx(rindex);
        val_idx   = set2_idx;%(rindex);
   elseif randomStrategy == 5 %'Sequential Random Start(Val, Train, Test)';
        ns1 = size(set1_idx,2);
        rindex = randperm(ns1);
        rindex = rindex(1:num_used);
        train_idx = set2_idx(rindex);
        val_idx   = set1_idx;%(rindex);  
    elseif randomStrategy == 6 %'Inference and test set(Inference, Test)';
        train_idx = 1:7305;
        val_idx   = 2:1;
        test_idx = 7306:10958;
    elseif randomStrategy == 7 %'Training and Validation set(Train,Val, Test)';
        train_idx = 1:3653;
        val_idx   = 3654:7305;
        test_idx = 7306:10958;
    else
        assert(false,'Random Strategy not defined!');
    end
     
    Ztrain = Z(train_idx,:);
    Zval   = Z(val_idx,:);
    Ztest  = Z(test_idx,:);
    
end

