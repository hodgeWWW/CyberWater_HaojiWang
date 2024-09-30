function Get_precision_matrix_distribution = computeThetaDistribution(S,t,lambda)
    % 输入:
    % S: 精度矩阵（对称矩阵）
    
    % 获取矩阵大小
    p = size(S, 1);
    
    % 初始化空数组用于存储非对角线元素
    thetaValues = [];
    
    % 遍历矩阵的上三角部分，跳过对角线
    for i = 1:p
        for j = i+1:p
            % 提取上三角部分的非对角线元素
            thetaValues = [thetaValues; S(i,j)];
        end
    end
    
    

    %Calculate the number of none-zero theta
    nonZeroThetaSum = sum(thetaValues ~= 0);
    % 输出分布信息，比如直方图数据
    figure;
    histogram(thetaValues, 30); % 30个bins的直方图
   title(['sum of ' num2str(t) ' days data, lambda = ' num2str(lambda)]);
    xlabel('Theta values');
    ylabel('Number of Edges');
    % 添加非零 thetaValues 总和的文本标注
    textString = ['# of non-zero Theta = ' num2str(nonZeroThetaSum)];
    % 在图形的左上角添加注释，坐标可以根据图表调整
    text(min(thetaValues), max(get(gca, 'YLim')), textString, 'FontSize', 10, 'Color', 'red', 'VerticalAlignment', 'top');
    
    % 返回分布值，或任何其他需要的统计信息
    distribution = thetaValues;
end
