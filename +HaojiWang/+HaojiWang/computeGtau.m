function Gtau = computeGtau(S, tau)
    % input:
    % S: Precision Matrix
    % tau: threshold value
    
    % 获取矩阵的大小
    p = size(S, 1);
    
    % 初始化图矩阵 Gtau
    Gtau = zeros(p);
    
    % 遍历精度矩阵，构造 Gtau
    for i = 1:p
        for j = i+1:p
            if abs(S(i,j)) > tau
                Gtau(i,j) = 1;
                Gtau(j,i) = 1; % 保证对称性
            end
        end
    end
    
    %
end
