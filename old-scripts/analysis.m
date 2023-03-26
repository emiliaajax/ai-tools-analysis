% Define the data arrays
X = [1 50 103 245 10115];
Y = [2 4 1 5 700];

% Compute mean, median, mode
mean_X = mean(X);
median_X = median(X);
mode_X = mode(X);

mean_Y = mean(Y);
median_Y = median(Y);
mode_Y = mode(Y);

% Compute standard deviation, variance, range
std_X = std(X);
var_X = var(X);
range_X = range(X);

std_Y = std(Y);
var_Y = var(Y);
range_Y = range(Y);

% h: a logical value indicating whether the null hypothesis (that the 
% means are equal) is rejected at the specified significance level
% p: the p-value of the test
% ci: the confidence interval of the difference between the means
% stats: additional statistical information about the test, such as 
% the t-statistic and degrees of freedom
[h,p,ci,stats] = ttest2(X,Y,'Alpha',0.05);

means = [mean_X, mean_Y];
medians = [median_X, median_Y];
figure;
bar([1,2], [means; medians]);
set(gca, 'XTickLabel', {'X', 'Y'});
legend('Mean', 'Median');

means = [mean_X, mean_Y];
figure;
bar(means);
set(gca, 'XTickLabel', {'X', 'Y'});
title('Mean values');

medians = [median_X, median_Y];
figure;
bar(medians);
set(gca, 'XTickLabel', {'X', 'Y'});
title('Median values');

modes = [mode_X, mode_Y];
figure;
bar(modes);
set(gca, 'XTickLabel', {'X', 'Y'});
title('Mode values')

standardDeviations = [std_X, std_Y];
figure;
bar(standardDeviations);
set(gca, 'XTickLabel', {'X', 'Y'});
title('Standard deviation values')

variances = [var_X, var_Y];
figure;
bar(variances);
set(gca, 'XTickLabel', {'X', 'Y'});
title('Variance values');

ranges = [range_X, range_Y];
figure;
bar(ranges);
set(gca, 'XTickLabel', {'X', 'Y'});
title('Range values');
