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
function [ Kmin, Kmax, Kvec, k_sel ] = getKsettings(mode)
    % (Default)k_sel = [25 45 67]; 
    k_sel = [25 47 67];
    
    if (mode == "fast")  
        Kmin = k_sel(1); 
        Kmax = k_sel(3);
        Kvec = k_sel;  % (Fast)
    elseif(mode == "semi-fast") 
        Kmin = 20; 
        Kmax = 70; 
        Kvec = Kmin:Kmax; % (Semi-Fast)
    else
        %% Full
        Kmin = 10;
        Kmax = 528;
        Kvec = Kmin:Kmax;
    end
end
%{
function [ Kmin, Kmax, Kvec, k_sel ] = getKsettings(mode)
    % (Default)k_sel = [25 45 67]; 
    k_sel = [25 47 65];
    
    if (mode == "fast")  
        Kmin = k_sel(1); 
        Kmax = k_sel(3);
        Kvec = k_sel;  % (Fast)
    elseif(mode == "semi-fast") 
        Kmin = 20; 
        Kmax = 70; 
        Kvec = Kmin:Kmax; % (Semi-Fast)
    else
        %% Full
        Kmin = 10;
        Kmax = 561;
        Kvec = Kmin:Kmax;
    end
end

%}
