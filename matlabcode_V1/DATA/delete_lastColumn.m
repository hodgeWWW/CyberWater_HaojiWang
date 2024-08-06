% 读取文件内容
data = readtable('01_DATA_30_YEARS_DAILY.txt', 'Delimiter', '\t'); % 假设文件以tab分隔，如果是其他分隔符请更改'Delimiter'

% 去除最后一列
data(:, end) = [];

% 保存修改后的数据到新文件
writetable(data, '01_DATA_30_YEARS_DAILY_modified.txt', 'Delimiter', '\t'); % 以tab分隔保存数据
