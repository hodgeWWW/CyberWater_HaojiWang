clc; clear; close all; 

%记得设置getEpsilon(),目前为0.00001
% Theta_train1 是精度矩阵
% Gtau 是adjacency matrix
% X 是raw data
% k 用来限制Gk的边数


[X, ~] = PREPAREDATA.getRawData(); %获取rawdata X
% Set the time window to 10 days
t=30
% Ensure X has enough rows for complete 10-day periods
n_rows = floor(size(X,1) / t) * t;  % Find the largest number divisible by 10
X_reshaped = X(1:n_rows, :);  % Trim X to have a number of rows divisible by 10

% Reshape and sum for 10/20/30-day periods
X_summed = sum(reshape(X_reshaped, t, [], size(X,2)), 1);  % Sum days


% Transpose to ensure proper orientation (if needed)
X_summed = squeeze(X_summed)';
X_summed = X_summed';
[Z,~,~] = PREPAREDATA.getDataZ(X_summed); %log(x+c), then standardize it to Z


%Set tau and lambda
tol = 1e-6; % 这个tol是tolerence

  
lambda = 0.35;
tau= 0.06;




%Get Gfull 
p = size(X,2);
maxIter =1000;
donorGroup = 0;
targetGroup = 0;
list = 1:21; %这里是hard code
Gfull = PAPER_ALGORITHMS.UTIL.getFullGraph(p,list, donorGroup, targetGroup);
%实际上Gfull就是全为1的矩阵，paper同理全为1，因为没有特殊处理

% Equation (20), replacing S by Strain:
Theta_train1 = GLASSO_REFACTORED.GLASSO.GlassoFortran2( lambda, Z, 0, 0, maxIter, tol, Gfull ); 
% Theta_train1 是精度矩阵





k=10000  %k为想要的边数

%在得到一个稀疏矩阵后，再用一次，不过这次Gk 而非Gfull




%Equation (22):
% Gk = GLASSO_REFACTORED.NON_ZEROS.prec2graph(Theta_train1, k); %对经过截断处理后的稀疏矩阵，保留前k个最大权重的边
% 取消用K来算Gk,而是用：tau为最大precision matrix的1%

Gtau = HaojiWang.computeGtau(Theta_train1,tau)

%Equation (23):
% Theta_train2 = GLASSO_REFACTORED.GLASSO.GlassoFortran2( lambda, Z, 0, 0, maxIter, tol, Gk );   

%HaojiWang.figure_whj(Gk) % 原paper画图就是用GK来画

HaojiWang.figure_whj(Gtau,t,lambda,tau) % 原paper画图就是用GK来画


HaojiWang.computeThetaDistribution(Theta_train1,t,lambda)   % 显示precision matrix 中theta 的分布
