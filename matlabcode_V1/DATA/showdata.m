% 完整脚本: plot_data.m
clc; clear; close all; 

% 读取 txt 文件
filename = '01_DATA_30_YEARS_DAILY_beforLogged.txt';
data = readtable(filename, 'Delimiter', '\t', 'ReadVariableNames', false);

% 转换表格为矩阵
data_matrix = table2array(data);

% 将日期列和数据列分开
date_columns = data_matrix(:, 1:3);
data_columns = data_matrix(:, 4:end);

% 绘制成对散点图，只生成一次每对数据集的图
num_datasets = size(data_columns, 2);
plots_per_page = 36; % 每页最多显示36个子图（6x6）
plot_count = 1;
figure;

for i = 1:num_datasets-1
    for j = i+1:num_datasets
        if mod(plot_count-1, plots_per_page) == 0 && plot_count > 1
            set(gcf, 'Position', get(0, 'Screensize'));
            saveas(gcf, ['pairwise_scatter_plots_page_', num2str(floor((plot_count-1)/plots_per_page)), '.png']);
            figure;
        end
        subplot(6, 6, mod(plot_count-1, plots_per_page) + 1);
        scatter(data_columns(:, i), data_columns(:, j), '.');
        xlabel(['Dataset ', num2str(i)]);
        ylabel(['Dataset ', num2str(j)]);
        title(['Scatter Plot: Dataset ', num2str(i), ' vs Dataset ', num2str(j)]);
        plot_count = plot_count + 1;
    end
end
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf, ['pairwise_scatter_plots_page_', num2str(floor((plot_count-1)/plots_per_page)), '.png']);


% 绘制每个数据集前3年的时间序列图
num_years = 3;
days_per_year = 365;
num_days = num_years * days_per_year;
num_plots_per_page = 6;
num_pages = ceil(num_datasets / num_plots_per_page);
for page = 1:num_pages
    figure;
    for i = 1:num_plots_per_page
        dataset_idx = (page-1)*num_plots_per_page + i;
        if dataset_idx > num_datasets
            break;
        end
        subplot(3, 2, i);
        plot(1:num_days, data_columns(1:num_days, dataset_idx));
        xlabel('Days');
        ylabel(['Dataset ', num2str(dataset_idx)]);
        title(['Time Series: Dataset ', num2str(dataset_idx)]);
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf, ['time_series_plots_page_', num2str(page), '.png']);
end

disp('Plots saved as pairwise_scatter_plots_page_*.png and time_series_plots_page_*.png');
