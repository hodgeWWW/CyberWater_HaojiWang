function Gtau = computeGtau(S, tau)
    % 输入:
    % S: 精度矩阵（对称矩阵）
    % tau: 阈值，用于判断是否在图中存在边
    
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
    
    % 对角线元素不需要变化，默认为 0（表示没有自循环边）
end
