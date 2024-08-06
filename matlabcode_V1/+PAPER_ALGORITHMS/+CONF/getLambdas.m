
function [ lambda_min, lambda_max, lambda2 ] = getLambdas()
    lambda_min = 0.01;   %改：lambda_min = 0.01; 
    lambda_max = 0.10;   %改：lambda_max = 0.10;  大lambda会使模型更稀疏（实测
    lambda2 = 0;
end
