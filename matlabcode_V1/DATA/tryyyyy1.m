% 读取 txt 文件
filename = '01_DATA_30_YEARS_DAILY.txt';
data = readtable(filename, 'Delimiter', ',');

% 将表格转换为矩阵
data_matrix = table2array(data);

% 将负数替换为 0
data_matrix(data_matrix < 0) = 0;

% 将矩阵转换回表格
data = array2table(data_matrix, 'VariableNames', data.Properties.VariableNames);

% 保存修改后的数据到新文件
new_filename = '01_DATA_30_YEARS_DAILY_modified.txt';
writetable(data, new_filename, 'Delimiter', ',', 'WriteVariableNames', false);

disp(['Modified data saved to ', new_filename]);
