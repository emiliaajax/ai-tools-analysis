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
bar(r1, chatGptErrorSum, bar_width, 'FaceColor', 'r');
hold on;
bar(r2, chatGptCorrectSum, bar_width, 'FaceColor', 'g');
hold on;
bar(r3 + bar_width, copilotErrorSum, bar_width, 'FaceColor', 'r');
hold on;
bar(r4 + bar_width, copilotCorrectSum, bar_width, 'FaceColor', 'g');
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
hold off;

% Create the bar chart for percentages
figure;
y1 = chatGptErrorSum / chatGptTotalLines * 100;
y2 = chatGptCorrectSum / chatGptTotalLines * 100;
y3 = copilotErrorSum / copilotTotalLines * 100;
y4 = copilotCorrectSum / copilotTotalLines * 100;
bar(r1, y1, bar_width, 'FaceColor', 'r');
hold on;
bar(r2, y2, bar_width, 'FaceColor', 'g');
hold on;
bar(r3 + bar_width, y3, bar_width, 'FaceColor', 'r');
hold on;
bar(r4 + bar_width, y4, bar_width, 'FaceColor', 'g');
hold on;
legendsPercentages = legend('Incorrect generations', 'Correct generations', 'Location', 'northwest');
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
hold off;

% Display how many occurrences of each count of error
copilot_unique_values = unique(copilot_data);

copilot_counts = histcounts(copilot_data, [
    copilot_unique_values', max(copilot_unique_values)+1]);

chatgpt_unique_values = unique(chatgpt_data);

chatgpt_counts = histcounts(chatgpt_data, [
    chatgpt_unique_values', max(chatgpt_unique_values)+1]);

figure;
bar(copilot_unique_values, copilot_counts);
xlabel('Number of quality errors');
ylabel('Count');
title('Copilot Quality Errors');

figure;
bar(chatgpt_unique_values, chatgpt_counts);
xlabel('Number of quality errors');
ylabel('Count');
title('ChatGPT Quality Errors');

% Check if data is normally distributed
% Calculate the AUC of the graph using the trapz function
copilot_auc = trapz(copilot_unique_values, copilot_counts);
chatgpt_auc = trapz(chatgpt_unique_values, chatgpt_counts);

% Check if the data is normalized
if abs(copilot_auc-1) < eps
    disp('Copilot data is normalized');
else
    disp('Copilot data is not normalized');
end

if abs(chatgpt_auc-1) < eps
    disp('ChatGPT data is normalized');
else
    disp('ChatGPT data is not normalized');
end