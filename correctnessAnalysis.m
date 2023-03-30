json_str = fileread('data/unitTests/testResults.json');
data = jsondecode(json_str);

bfs_chatgpt = data.ChatGPT.BreadthFirstSearch;
binarysearch_chatgpt = data.ChatGPT.BinarySearch;
bin2dec_chatgpt = data.ChatGPT.BinaryToDecimal;
knapsack_chatgpt = data.ChatGPT.Knapsack;
mergesort_chatgpt = data.ChatGPT.MergeSort;
quicksort_chatgpt = data.ChatGPT.QuickSort;

bfs_copilot = data.Copilot.BreadthFirstSearch;
binarysearch_copilot = data.Copilot.BinarySearch;
bin2dec_copilot = data.Copilot.BinaryToDecimal;
knapsack_copilot = data.Copilot.Knapsack;
mergesort_copilot = data.Copilot.MergeSort;
quicksort_copilot = data.Copilot.QuickSort;

% DESCRIPTIVE STATISTICS FOR CHATGPT

% Concatenate the arrays into a single array
% chatgpt_data = horzcat(bfs_chatgpt, binarysearch_chatgpt, bin2dec_chatgpt, ...
%     knapsack_chatgpt, mergesort_chatgpt, quicksort_chatgpt);
chatgpt_data = [bfs_chatgpt; binarysearch_chatgpt; bin2dec_chatgpt; 
    knapsack_chatgpt; mergesort_chatgpt; quicksort_chatgpt];

% Calculate the mean, median, variance, and standard deviation for ChatGPT
chatgpt_mean = mean(chatgpt_data);
chatgpt_median = median(chatgpt_data);
chatgpt_var = var(chatgpt_data);
chatgpt_std = std(chatgpt_data);

% DESCRIPTIVE STATISTICS FOR COPILOT
% Concatenate the arrays into a single array
% copilot_data = horzcat(bfs_copilot, binarysearch_copilot, bin2dec_copilot, ...
%     knapsack_copilot, mergesort_copilot, quicksort_copilot);

copilot_data = [bfs_copilot; binarysearch_copilot; bin2dec_copilot; 
    knapsack_copilot; mergesort_copilot; quicksort_copilot];

[p, h, stats] = ranksum(chatgpt_data, copilot_data);
if h == 1
    disp('The two groups have significantly different distributions.');
end

% Calculate the mean, median, variance, and standard deviation for Copilot
copilot_mean = mean(copilot_data);
copilot_median = median(copilot_data);
copilot_var = var(copilot_data);
copilot_std = std(copilot_data);

% DISPLAY MEANS
% Create a bar graph
figure;
means = [chatgpt_mean, copilot_mean];
bar(means);

% Add labels to the graph
xticklabels({'ChatGPT', 'Copilot'});
ylabel('Mean value');

% Optionally, customize the appearance of the graph
title('Means of errors');
set(gca, 'FontSize', 12);

% DISPLAY MEDIANS
% Create a bar graph
figure;
medians = [chatgpt_median, copilot_median];
bar(medians);

% Add labels to the graph
xticklabels({'ChatGPT', 'Copilot'});
ylabel('Median value');

% Optionally, customize the appearance of the graph
title('Medians of errors');
set(gca, 'FontSize', 12);

%DISPLAY STDS
% Create a bar graph
figure;
stds = [chatgpt_std, copilot_std];
bar(stds);

% Add labels to the graph
xticklabels({'ChatGPT', 'Copilot'});
ylabel('Standard deviation value');

% Optionally, customize the appearance of the graph
title('Standard deviations of errors');
set(gca, 'FontSize', 12);

%DISPLAY VARIANCES
% Create a bar graph
figure;
vars = [chatgpt_var, copilot_var];
bar(vars);

% Add labels to the graph
xticklabels({'ChatGPT', 'Copilot'});
ylabel('Variances value');

% Optionally, customize the appearance of the graph
title('Variances of errors');
set(gca, 'FontSize', 12);







% LEAVE FOR NOW!!
% % Create the bar chart for means
% figure;
% bar([chatgpt_mean', copilot_mean']);
% title('Means of ChatGPT and Copilot');
% ylabel('Mean');
% xticklabels({'ChatGPT', 'Copilot'});

% 
% %%DESCRIPTIVE STATS FOR EACH ALGORITHM
% 
% % CALCULATE AND DISPLAY MEANS
% bfs_chatgpt_mean = mean(bfs_chatgpt);
% bfs_copilot_mean = mean(bfs_copilot);
% 
% binarysearch_chatgpt_mean = mean(binarysearch_chatgpt);
% binarysearch_copilot_mean = mean(binarysearch_copilot);
% 
% bin2dec_chatgpt_mean = mean(bin2dec_chatgpt);
% bin2dec_copilot_mean = mean(bin2dec_copilot);
% 
% knapsack_chatgpt_mean = mean(knapsack_chatgpt);
% knapsack_copilot_mean = mean(knapsack_copilot);
% 
% mergesort_chatgpt_mean = mean(mergesort_chatgpt);
% mergesort_copilot_mean = mean(mergesort_copilot);
% 
% quicksort_chatgpt_mean = mean(quicksort_chatgpt);
% quicksort_copilot_mean = mean(quicksort_copilot);
% 
% % Display means
% % Data
% algorithms = {'BFS', 'Binary Search', 'Binary to Decimal', 'Knapsack', 'Merge Sort', 'Quick Sort'};
% chatgpt_means = [bfs_chatgpt_mean, binarysearch_chatgpt_mean, bin2dec_chatgpt_mean, knapsack_chatgpt_mean, mergesort_chatgpt_mean, quicksort_chatgpt_mean];
% copilot_means = [bfs_copilot_mean, binarysearch_copilot_mean, bin2dec_copilot_mean, knapsack_copilot_mean, mergesort_copilot_mean, quicksort_copilot_mean];
% 
% % Set the bar width
% bar_width = 0.35;
% 
% % Set the x positions of the bars
% r1 = 1:length(chatgpt_means);
% r2 = r1 + bar_width;
% 
% % Create the bar chart
% figure;
% bar(r1, chatgpt_means, bar_width, 'FaceColor', 'b');
% hold on;
% bar(r2, copilot_means, bar_width, 'FaceColor', 'r');
% 
% % Add labels and title
% xlabel('Algorithm');
% ylabel('Mean');
% xticks(r1 + bar_width/2);
% xticklabels(algorithms);
% title('Means of ChatGPT and Copilot');
% 
% % Add legend
% legend('ChatGPT', 'Copilot');
% 
% % Show the plot
% hold off;
% 
% 
% % CALCULATE AND DISPLAY STANDARD DEVIATIONS
% bfs_chatgpt_std = std(bfs_chatgpt);
% bfs_copilot_std = std(bfs_copilot);
% 
% binarysearch_chatgpt_std = std(binarysearch_chatgpt);
% binarysearch_copilot_std = std(binarysearch_copilot);
% 
% bin2dec_chatgpt_std = std(bin2dec_chatgpt);
% bin2dec_copilot_std = std(bin2dec_copilot);
% 
% knapsack_chatgpt_std = std(knapsack_chatgpt);
% knapsack_copilot_std = std(knapsack_copilot);
% 
% mergesort_chatgpt_std = std(mergesort_chatgpt);
% mergesort_copilot_std = std(mergesort_copilot);
% 
% quicksort_chatgpt_std = std(quicksort_chatgpt);
% quicksort_copilot_std = std(quicksort_copilot);
% 
% % Display standard deviations
% % Data
% algorithms = {'BFS', 'Binary Search', 'Binary to Decimal', 'Knapsack', 'Merge Sort', 'Quick Sort'};
% chatgpt_stds = [bfs_chatgpt_std, binarysearch_chatgpt_std, bin2dec_chatgpt_std, knapsack_chatgpt_std, mergesort_chatgpt_std, quicksort_chatgpt_std];
% copilot_stds = [bfs_copilot_std, binarysearch_copilot_std, bin2dec_copilot_std, knapsack_copilot_std, mergesort_copilot_std, quicksort_copilot_std];
% 
% % Set the bar width
% bar_width = 0.35;
% 
% % Set the x positions of the bars
% r1 = 1:length(chatgpt_stds);
% r2 = r1 + bar_width;
% 
% % Create the bar chart
% figure;
% bar(r1, chatgpt_stds, bar_width, 'FaceColor', 'b');
% hold on;
% bar(r2, copilot_stds, bar_width, 'FaceColor', 'r');
% 
% % Add labels and title
% xlabel('Algorithm');
% ylabel('Standard Deviation');
% xticks(r1 + bar_width/2);
% xticklabels(algorithms);
% title('Standard Deviations of ChatGPT and Copilot');
% 
% % Add legend
% legend('ChatGPT', 'Copilot');
% 
% % Show the plot
% hold off;
% 
% % CALCULATE AND DISPLAY MEDIANS
% bfs_chatgpt_median = median(bfs_chatgpt);
% bfs_copilot_median = median(bfs_copilot);
% 
% binarysearch_chatgpt_median = median(binarysearch_chatgpt);
% binarysearch_copilot_median = median(binarysearch_copilot);
% 
% bin2dec_chatgpt_median = median(bin2dec_chatgpt);
% bin2dec_copilot_median = median(bin2dec_copilot);
% 
% knapsack_chatgpt_median = median(knapsack_chatgpt);
% knapsack_copilot_median = median(knapsack_copilot);
% 
% mergesort_chatgpt_median = median(mergesort_chatgpt);
% mergesort_copilot_median = median(mergesort_copilot);
% 
% quicksort_chatgpt_median = median(quicksort_chatgpt);
% quicksort_copilot_median = median(quicksort_copilot);
% 
% % Display medians
% % Data
% algorithms = {'BFS', 'Binary Search', 'Binary to Decimal', 'Knapsack', 'Merge Sort', 'Quick Sort'};
% chatgpt_medians = [bfs_chatgpt_median, binarysearch_chatgpt_median, bin2dec_chatgpt_median, knapsack_chatgpt_median, mergesort_chatgpt_median, quicksort_chatgpt_median];
% copilot_medians = [bfs_copilot_median, binarysearch_copilot_median, bin2dec_copilot_median, knapsack_copilot_median, mergesort_copilot_median, quicksort_copilot_median];
% 
% % Set the bar width
% bar_width = 0.35;
% 
% % Set the x positions of the bars
% r1 = 1:length(chatgpt_medians);
% r2 = r1 + bar_width;
% 
% % Create the bar chart
% figure;
% bar(r1, chatgpt_medians, bar_width, 'FaceColor', 'b');
% hold on;
% bar(r2, copilot_medians, bar_width, 'FaceColor', 'r');
% 
% % Add labels and title
% xlabel('Algorithm');
% ylabel('Median');
% xticks(r1 + bar_width/2);
% xticklabels(algorithms);
% title('Medians of ChatGPT and Copilot');
% 
% % Add legend
% legend('ChatGPT', 'Copilot');
% 
% % Show the plot
% hold off;
% 
% 
% % Calculate variances
% bfs_chatgpt_var = var(bfs_chatgpt);
% bfs_copilot_var = var(bfs_copilot);
% 
% binarysearch_chatgpt_var = var(binarysearch_chatgpt);
% binarysearch_copilot_var = var(binarysearch_copilot);
% 
% bin2dec_chatgpt_var = var(bin2dec_chatgpt);
% bin2dec_copilot_var = var(bin2dec_copilot);
% 
% knapsack_chatgpt_var = var(knapsack_chatgpt);
% knapsack_copilot_var = var(knapsack_copilot);
% 
% mergesort_chatgpt_var = var(mergesort_chatgpt);
% mergesort_copilot_var = var(mergesort_copilot);
% 
% quicksort_chatgpt_var = var(quicksort_chatgpt);
% quicksort_copilot_var = var(quicksort_copilot);
% 
% % Display variances
% % Data
% algorithms = {'BFS', 'Binary Search', 'Binary to Decimal', 'Knapsack', 'Merge Sort', 'Quick Sort'};
% chatgpt_vars = [bfs_chatgpt_var, binarysearch_chatgpt_var, bin2dec_chatgpt_var, knapsack_chatgpt_var, mergesort_chatgpt_var, quicksort_chatgpt_var];
% copilot_vars = [bfs_copilot_var, binarysearch_copilot_var, bin2dec_copilot_var, knapsack_copilot_var, mergesort_copilot_var, quicksort_copilot_var];
% 
% % Set the bar width
% bar_width = 0.35;
% 
% % Set the x positions of the bars
% r1 = 1:length(chatgpt_vars);
% r2 = r1 + bar_width;
% 
% % Create the bar chart
% figure;
% bar(r1, chatgpt_vars, bar_width, 'FaceColor', 'b');
% hold on;
% bar(r2, copilot_vars, bar_width, 'FaceColor', 'r');
% 
% % Add labels and title
% xlabel('Algorithm');
% ylabel('Variance');
% xticks(r1 + bar_width/2);
% xticklabels(algorithms);
% title('Variances of ChatGPT and Copilot');
% 
% % Add legend
% legend('ChatGPT', 'Copilot');
% 
% % Show the plot
% hold off;