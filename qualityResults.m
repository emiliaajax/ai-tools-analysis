% Count total lines
lines_str = fileread('data/lineCount/AlgorithmsLineCount.json');
lines = jsondecode(lines_str);

chatgpt_lines = [lines.chatGPT.BreadthFirstSearch;
    lines.chatGPT.BinarySearch;
    lines.chatGPT.BinaryToDecimal;
    lines.chatGPT.Knapsack;
    lines.chatGPT.MergeSort;
    lines.chatGPT.QuickSort];

copilot_lines = [lines.copilot.BreadthFirstSearch;
    lines.copilot.BinarySearch;
    lines.copilot.BinaryToDecimal;
    lines.copilot.Knapsack;
    lines.copilot.MergeSort;
    lines.copilot.QuickSort];

chatGptTotalLines = sum(chatgpt_lines);
copilotTotalLines = sum(copilot_lines);

% Count number of errors
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

% Concatenate the arrays into a single array
chatgpt_data = [bfs_chatgpt; binarysearch_chatgpt; bin2dec_chatgpt; 
    knapsack_chatgpt; mergesort_chatgpt; quicksort_chatgpt];

copilot_data = [bfs_copilot; binarysearch_copilot; bin2dec_copilot; 
    knapsack_copilot; mergesort_copilot; quicksort_copilot];

disp(chatgpt_data)

chatGptErrorSum = sum(chatgpt_data);
copilotErrorSum = sum(copilot_data);

chatGptCorrectSum = chatGptTotalLines - chatGptErrorSum;
copilotCorrectSum = copilotTotalLines - copilotErrorSum;

% Display the sum of lines with and without errors
disp('ChatGPT')
disp(chatGptCorrectSum);
disp(chatGptErrorSum);

disp('Copilot')
disp(copilotCorrectSum);
disp(copilotErrorSum);

bar_width = 1;

%Set the x positions of the bars
r1 = 1;
r2 = 2;
r3 = 3;
r4 = 4;

% Create the bar chart
figure;
bar(r1, chatGptErrorSum, bar_width, 'FaceColor', '#f2614b', 'EdgeColor', '#f2614b');
hold on;
bar(r2, chatGptCorrectSum, bar_width, 'FaceColor', '#90ee90', 'EdgeColor', '#90ee90');
hold on;
bar(r3 + bar_width, copilotErrorSum, bar_width, 'FaceColor', '#f2614b', 'EdgeColor', '#f2614b');
hold on;
bar(r4 + bar_width, copilotCorrectSum, bar_width, 'FaceColor', '#90ee90', 'EdgeColor', '#90ee90');
hold on;
text(r1, chatGptErrorSum, num2str(chatGptErrorSum), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r2, chatGptCorrectSum, num2str(chatGptCorrectSum), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r3 + bar_width, copilotErrorSum, num2str(copilotErrorSum), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r4 + bar_width, copilotCorrectSum, num2str(copilotCorrectSum), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
legends = legend('Incorrect generations', 'Correct generations', 'Location', 'northwest');
set(legends, 'FontSize', 8);
legend('Incorrect lines', 'Correct lines');
xticks([r3 / 2, r3 + 1.5]);
xticklabels({'ChatGPT', 'Copilot'});
ylabel('Line count');
title('Code Quality');
ylim([0 8200]);
box off;
hold off;

% Create the bar chart for percentages
figure;
y1 = chatGptErrorSum / chatGptTotalLines * 100;
y2 = chatGptCorrectSum / chatGptTotalLines * 100;
y3 = copilotErrorSum / copilotTotalLines * 100;
y4 = copilotCorrectSum / copilotTotalLines * 100;
bar(r1, y1, bar_width, 'FaceColor', '#f2614b', 'EdgeColor', '#f2614b');
hold on;
bar(r2, y2, bar_width, 'FaceColor', '#90ee90', 'EdgeColor', '#90ee90');
hold on;
bar(r3 + bar_width, y3, bar_width, 'FaceColor', '#f2614b', 'EdgeColor', '#f2614b');
hold on;
bar(r4 + bar_width, y4, bar_width, 'FaceColor', '#90ee90', 'EdgeColor', '#90ee90');
hold on;
legendsPercentages = legend('Incorrect', 'Correct', 'Location', 'northwest');
set(legendsPercentages, 'FontSize', 6);
text(r1, y1, num2str(y1, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r2, y2, num2str(y2, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r3 + bar_width, y3, num2str(y3, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r4 + bar_width, y4, num2str(y4, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
xticks([r3 / 2, r3 + 1.5]);
xticklabels({'ChatGPT', 'Copilot'});
ylabel('%');
title('Code Quality');
ylim([0 100]);
box off;
hold off;

% Create the bar chart for percentages
figure;
y1 = chatGptErrorSum / chatGptTotalLines * 100;
y2 = chatGptCorrectSum / chatGptTotalLines * 100;
bar(r1, y1, bar_width, 'FaceColor', '#f2614b', 'EdgeColor', '#f2614b');
hold on;
bar(r2, y2, bar_width, 'FaceColor', '#90ee90', 'EdgeColor', '#90ee90');
hold on;
legendsPercentages = legend('Incorrect', 'Correct', 'Location', 'northwest');
set(legendsPercentages, 'FontSize', 6);
text(r1, y1, num2str(y1, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r2, y2, num2str(y2, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
xticks([r3 / 2, r3 + 1.5]);
xticklabels({'ChatGPT', 'Copilot'});
ylabel('%');
title('Code Quality');
ylim([0 100]);
box off;
hold off;

% Create the bar chart for percentages
figure;
y3 = copilotErrorSum / copilotTotalLines * 100;
y4 = copilotCorrectSum / copilotTotalLines * 100;
bar(r3 + bar_width, y3, bar_width, 'FaceColor', '#f2614b', 'EdgeColor', '#f2614b');
hold on;
bar(r4 + bar_width, y4, bar_width, 'FaceColor', '#90ee90', 'EdgeColor', '#90ee90');
hold on;
legendsPercentages = legend('Incorrect', 'Correct', 'Location', 'northwest');
set(legendsPercentages, 'FontSize', 6);
text(r3 + bar_width, y3, num2str(y3, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r4 + bar_width, y4, num2str(y4, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
xticks([r3 / 2, r3 + 1.5]);
xticklabels({'ChatGPT', 'Copilot'});
ylabel('%');
title('Code Quality');
ylim([0 100]);
box off;
hold off;

% Display how many occurrences of each count of error
copilot_unique_values = unique(copilot_data);

copilot_counts = histcounts(copilot_data, [
    copilot_unique_values', max(copilot_unique_values)+1]);

chatgpt_unique_values = unique(chatgpt_data);

chatgpt_counts = histcounts(chatgpt_data, [
    chatgpt_unique_values', max(chatgpt_unique_values)+1]);

figure;
h_copilot_raw = bar(copilot_unique_values, copilot_counts, 'FaceColor', '#add8e6', 'EdgeColor', '#add8e6');
xlabel('Number of quality errors');
ylabel('Frequency');
title('Copilot Quality Errors');
y_values_copilot_raw = h_copilot_raw.YData;
x_values_copilot_raw = h_copilot_raw.XData;
for i = 1:numel(y_values_copilot_raw)
    text(x_values_copilot_raw(i), y_values_copilot_raw(i), num2str(y_values_copilot_raw(i)), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end
ylim([0 210])
box off;

figure;
grid on;
h_chatgpt_raw = bar(chatgpt_unique_values, chatgpt_counts, 'FaceColor', '#add8e6', 'EdgeColor', '#add8e6');
xlabel('Number of quality errors');
ylabel('Count');
title('ChatGPT Quality Errors');
y_values_chatgpt_raw = h_chatgpt_raw.YData;
x_values_chatgpt_raw = h_chatgpt_raw.XData;
for i = 1:numel(y_values_chatgpt_raw)
    text(x_values_chatgpt_raw(i), y_values_chatgpt_raw(i), num2str(y_values_chatgpt_raw(i)), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end
ylim([0 260])
box off;

figure;
h_copilot = bar(copilot_unique_values, copilot_counts / length(copilot_data) * 100, 'FaceColor', '#add8e6', 'EdgeColor', '#add8e6');
xlabel('Number of quality errors');
ylabel('%', 'Rotation', 0);
title('Copilot Quality Errors');
y_values_copilot = h_copilot.YData;
x_values_copilot = h_copilot.XData;
for i = 1:numel(y_values_copilot)
    text(x_values_copilot(i), y_values_copilot(i), num2str(y_values_copilot(i), '%.1f'), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end
box off;

figure;
h_chatgpt = bar(chatgpt_unique_values, chatgpt_counts / length(chatgpt_data) * 100, 'FaceColor', '#add8e6', 'EdgeColor', '#add8e6');
xlabel('Number of quality errors');
ylabel('%', 'Rotation', 0);
title('ChatGPT Quality Errors');
y_values = h_chatgpt.YData;
x_values = h_chatgpt.XData;
for i = 1:numel(y_values)
    text(x_values(i), y_values(i), num2str(y_values(i), '%.1f'), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end
box off;

% extract the first 5 x values from the datasets
num_points = 5;
copilot_indices = ismember(copilot_unique_values, chatgpt_unique_values(1:num_points));
x_values_copilot = copilot_unique_values(copilot_indices);
y_values_copilot = copilot_counts(copilot_indices) / length(copilot_data) * 100;
chatgpt_indices = ismember(chatgpt_unique_values, x_values(1:num_points));
x_values = chatgpt_unique_values(chatgpt_indices);
y_values = chatgpt_counts(chatgpt_indices) / length(chatgpt_data) * 100;

% plot the grouped bar chart with only the first 5 x values
figure;
bar_width = 0.35; % adjust this to change the width of each bar
h_copilot = bar(x_values_copilot - bar_width/2, y_values_copilot, bar_width, 'FaceColor', '#add8e6', 'EdgeColor', '#add8e6');
hold on;
h_chatgpt = bar(x_values + bar_width/2, y_values, bar_width, 'FaceColor', '#ff9999', 'EdgeColor', '#ff9999');
xlabel('Number of quality errors');
ylabel('%', 'Rotation', 0);
title('Quality Errors Comparison (First 5 X Values)');
legend('Copilot', 'ChatGPT');
box off;

% add text labels to the bars
for i = 1:numel(y_values_copilot)
    text(x_values_copilot(i), y_values_copilot(i), num2str(y_values_copilot(i), '%.1f'), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end
for i = 1:numel(y_values)
    text(x_values(i), y_values(i), num2str(y_values(i), '%.1f'), ...
         'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end

% set the x-axis limits to show only the first 5 x values
xlim([x_values_copilot(1)-bar_width/2, x_values_copilot(end)+bar_width/2]);

% set the x-axis ticks and labels to show only natural numbers
xticks(x_values_copilot);
xticklabels(0:length(x_values_copilot)-1);

