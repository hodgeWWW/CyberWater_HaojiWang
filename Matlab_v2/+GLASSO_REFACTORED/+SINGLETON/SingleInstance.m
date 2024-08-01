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
classdef (Sealed) SingleInstance < handle
    properties
        mm_day;         % Discharge units (true:mm/day; false:cfs)
        X;              % (daily) Discharge for the p Gauges 
        gauge_ids;      % index from 1 to p
        elevations;     % Elevation of the outlet in feet
        latitudes;      % Latitude of the outlet
        longitudes;     % Longitude of the outlet
        areas_sq_mile;  % Area of the catchment in square miles
        
        t_sec = 60*60*24; %One day in seconds
        minDegree = 0; % parameter used to choose the sparse graph
        minEdges = 25; % parameter used to choose the sparse graph
        numSeeds = 5;

        prec2graphOpt = 4; % parameter used by the function prec2graph
        desc = '';
        blackList = [];
        
        setIndex = 1; %1-->Val, @-->Test
        isPlot = true;
        
        epsilon = 1;
        
        %% Sampling Settings
        n_train = 5*365;
        
        %% General Settings
        strategy_id = 7; %(HardCoded)
        inference_strategy = 6; %(HardCoded)
        
        model_id    = 4; % {4:Glasso.prec(default), 5: FastGlasso.prec} 
        xyz_idx     = 0; %0-->"X" (default)
  
        %{
        1: Mean RMSE (old default)
        2: Mean 1-NSE(new: norm 2)
        4: Mean 1-NSE1(new: norm 1)
        5: Mean 1-abs(corr)
        6: Mean 1-R^2 (new default)
        %}
        optFunIdx = 6;  
        
        %% Subset settings for the Objective Function
        use_subset = true;
        subset_r = 0.8;
        
        
        %% Sampling vectors
    	lambda_vec = 0;
    	tau_vec    = 0;
        
        print = true;
        
    end
    methods (Access = private)
        function obj = SingleInstance
            obj.setData(0);
        end
    end
    methods (Access = public)
        function p = getP(obj)
            p = size(obj.X,2);
        end
        function unitDesc = getUnits(obj)
            if obj.mm_day
                unitDesc = 'mm/day';     
            else    
                unitDesc = 'CFS';
            end
        end
        function [] = setData(sobj, streamflow_units_mm_day)
            [ gauge_id, Elevation, Latitude, Longitude, Area_sq_mile ] = PREPAREDATA.getFeatures2('./DATA/');
            
            sobj.mm_day = streamflow_units_mm_day;
            sobj.gauge_ids = gauge_id;
            sobj.elevations = Elevation;
            sobj.latitudes = Latitude;
            sobj.longitudes = Longitude;
            sobj.areas_sq_mile = Area_sq_mile;  
            
            if streamflow_units_mm_day
                sobj.X = UNITS.normalizeByAreaTime( sobj.X, Area_sq_mile, sobj.t_sec );
            end    
        end
    end    
    methods (Static)
      function singleObj = getInstance
         persistent localObj
         if isempty(localObj) || ~isvalid(localObj)
            localObj = GLASSO_REFACTORED.SINGLETON.SingleInstance;
         end
         singleObj = localObj;
      end
   end
end


