json_str = fileread('data/checkstyle/CheckstyleReport.json');
data = jsondecode(json_str);

bfs_chatgpt = data.ChatGPT.Graph;
binarysearch_chatgpt = data.ChatGPT.BinarySearch;
bin2dec_chatgpt = data.ChatGPT.BinaryToDecimal;
knapsack_chatgpt = data.ChatGPT.Knapsack;
mergesort_chatgpt = data.ChatGPT.MergeSort;
quicksort_chatgpt = data.ChatGPT.QuickSort;

bfs_copilot = data.Copilot.Graph;
binarysearch_copilot = data.Copilot.BinarySearch;
bin2dec_copilot = data.Copilot.BinaryToDecimal;
knapsack_copilot = data.Copilot.Knapsack;
mergesort_copilot = data.Copilot.MergeSort;
quicksort_copilot = data.Copilot.QuickSort;

% DESCRIPTIVE STATISTICS FOR CHATGPT

% Concatenate the arrays into a single array
chatgpt_data = [bfs_chatgpt; binarysearch_chatgpt; bin2dec_chatgpt; 
    knapsack_chatgpt; mergesort_chatgpt; quicksort_chatgpt];

figure;
plot(chatgpt_data);
ylabel('Number of errors');
title('Quality errors for ChatGPT');

% % Test for normality. Kolmogorov-Smirnov (KS) test.
% [h, p, k] = kstest(chatgpt_data); % perform KS test
% if h == 0
%     disp('ChatGPT data is normally distributed');
% else
%     disp('ChatGPT data is not normally distributed');
% end

% Calculate the mean, median, variance, and standard deviation for ChatGPT
chatgpt_mean = mean(chatgpt_data);
chatgpt_median = median(chatgpt_data);
chatgpt_var = var(chatgpt_data);
chatgpt_std = std(chatgpt_data);

% DESCRIPTIVE STATISTICS FOR COPILOT

% Concatenate the arrays into a single array
copilot_data = [bfs_copilot; binarysearch_copilot; bin2dec_copilot; 
    knapsack_copilot; mergesort_copilot; quicksort_copilot];

figure;
plot(copilot_data);
ylabel('Number of errors');
title('Quality errors for Copilot');

% Calculate the mean, median, variance, and standard deviation for Copilot
copilot_mean = mean(copilot_data);
copilot_median = median(copilot_data);
copilot_var = var(copilot_data);
copilot_std = std(copilot_data);

% % Test for normality. Kolmogorov-Smirnov (KS) test.
% [h, p, k] = kstest(copilot_data); % perform KS test
% if h == 0
%     disp('Copilot data is normally distributed');
% else
%     disp('Copilot data is not normally distributed');
% end

%If you want to test for differences between two groups of non-normally 
% distributed data without using medians, you can consider using the 
% Mann-Whitney U test, also known as the Wilcoxon rank-sum test.
% The Mann-Whitney U test is a non-parametric test that compares the 
% distribution of two independent groups of data. It tests the null 
% hypothesis that the two groups have the same distribution, and the 
% alternative hypothesis that one group has a higher (or lower) distribution
% than the other. 
% The ranksum function returns the p-value of the test, the test decision
% (h), and the test statistics (stats). Note that the Mann-Whitney U test 
% assumes that the two groups have the same shape of distribution but 
% different location. If the two groups have different shapes of 
% distribution, you may want to consider other non-parametric tests, 
% such as the Kolmogorov-Smirnov test or the Anderson-Darling test, 
% which test the hypothesis that the two groups come from the same 
% distribution regardless of shape or location
[p, h, stats] = ranksum(chatgpt_data, copilot_data);
if h == 1
    disp('The two groups have significantly different distributions.');
end

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
