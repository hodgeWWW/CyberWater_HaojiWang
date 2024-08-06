% 完整脚本: process_data.m

% 读取 txt 文件
filename = '01_DATA_30_YEARS_DAILY.txt';
data = readtable(filename, 'Delimiter', '\t', 'ReadVariableNames', false);

% 转换表格为矩阵
data_matrix = table2array(data);

% 删除包含 NaN 的行
data_matrix = data_matrix(~any(isnan(data_matrix), 2), :);

% 将日期列和数据列分开
date_columns = data_matrix(:, 1:3);
data_columns = data_matrix(:, 4:end);

% 数据列乘以 86400
data_columns = data_columns * 86400;

% 将小于 0.001 的值（包括负数）替换为 0
data_columns(data_columns < 0.001) = 0;

% 组合日期列和处理后的数据列
processed_data = [date_columns, data_columns];

% 转换矩阵为表格
processed_table = array2table(processed_data);

% 保存修改后的数据到新文件
new_filename = '01_DATA_30_YEARS_DAILY_modified.txt';
writetable(processed_table, new_filename, 'Delimiter', '\t', 'WriteVariableNames', false);

disp(['Modified data saved to ', new_filename]);
