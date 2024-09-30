function [] = figure_whj( G,t, lambda ,tau)
xy = PREPAREDATA.getXYcoordinates(); 
%Coordinates 由feture.txt决定
color = [1 0 0];
LineWidth = 1;
MarkerSize = 5;
x = xy(:,1);
y = xy(:,2);
y = y;
xy = [x y];
models=[ "US1,GFDL1-higher resol" ; "US2,GFDL1-lower resol";"Canada"; ...
  "US3,NCAR";"Korea";"German1,Alfred Wegener "; ...
  "Indian";"Italy";"French1,Carbon"; ...
  "Russian";"UK,HadGEM3";"Japan"; ...
  "German2,MacPlank";"Australian";"Taiwan"; ...
  "China1,CAMS";"French2,atm&ocean";"Norway"; ...
  "Sweden,Netherlands, Finnish, Spain etc";"UK2,MetOffice";"China2,CAS/IAP "]

    EXTERNAL.GPLOTD.gplotd(G,xy,'Color',color,'LineWidth',LineWidth,'MarkerSize',MarkerSize);
    numEdges = GLASSO_REFACTORED.GRAPH.countEdges(G);
    
    % 定义图标题
    desp = 'Graph';  
    title1 = [' (' num2str(numEdges) ' edges),  ' num2str(t) ' days data, lambda = ' num2str(lambda) ', tau = ' num2str(tau)];

    
    % 设置图形标题
    title(title1);
    % 为每个点添加注释（批注）
    for i = 1:11
        text(x(i), y(i), models(i), 'FontSize', 12, 'Color', 'blue','HorizontalAlignment', 'center');  % 标注点的编号或其他信息
    end
    for i = 12:21
    % 在点的左边显示文本，将 x 坐标稍微向左偏移，并设置水平对齐方式为 'right'
    text(x(i), y(i), models(i), 'FontSize',12, 'Color', 'blue', 'HorizontalAlignment', 'center');  
end
    
end