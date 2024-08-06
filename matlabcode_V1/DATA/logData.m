% 完整脚本: process_and_log_standardize_data.m 
%偏移值为0.0001以避免0值    

% 读取 txt 文件
filename = '01_DATA_30_YEARS_DAILY.txt';
data = readtable(filename, 'Delimiter', '\t', 'ReadVariableNames', false);

% 转换表格为矩阵
data_matrix = table2array(data);

% 将日期列和数据列分开
date_columns = data_matrix(:, 1:3);
data_columns = data_matrix(:, 4:end);



% 偏移数据以避免零值
data_columns_shifted = data_columns + 0.0001;

% 对数据取对数
data_columns_log = log(data_columns_shifted);

% 对数据进行标准化处理（均值为0，标准差为1）
data_columns_standardized = (data_columns_log - mean(data_columns_log(:))) / std(data_columns_log(:));

% 组合日期列和处理后的数据列
processed_data = [date_columns, data_columns_standardized];

% 转换矩阵为表格
processed_table = array2table(processed_data);

% 保存修改后的数据到新文件
new_filename = '01_DATA_30_YEARS_DAILY_log_standardized.txt';
writetable(processed_table, new_filename, 'Delimiter', '\t', 'WriteVariableNames', false);

disp(['Log-transformed and standardized data saved to ', new_filename]);
