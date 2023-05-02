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

% Concatenate the arrays into a single array
chatgpt_data = [bfs_chatgpt; binarysearch_chatgpt; bin2dec_chatgpt; 
    knapsack_chatgpt; mergesort_chatgpt; quicksort_chatgpt];

copilot_data = [bfs_copilot; binarysearch_copilot; bin2dec_copilot; 
    knapsack_copilot; mergesort_copilot; quicksort_copilot];

chatGptErrorSum = sum(chatgpt_data);
copilotErrorSum = sum(copilot_data);

chatGptCorrectSum = length(chatgpt_data) - chatGptErrorSum;
copilotCorrectSum = length(copilot_data) - copilotErrorSum;

disp(copilot_data);

disp('ChatGPT');
disp(chatGptCorrectSum);
disp(chatGptErrorSum);

disp('Copilot');
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
legends = legend('Incorrect', 'Correct', 'Location', 'northwest');
set(legends, 'FontSize', 8);
xticks([r3 / 2, r3 + 1.5]);
xticklabels({'ChatGPT', 'Copilot'});
ylabel('Generation count');
title('Code Correctness');
ylim([0 length(chatgpt_data)]);
box off;
hold off;

figure;
bar(r1, chatGptErrorSum, bar_width, 'FaceColor', '#f2614b', 'EdgeColor', '#f2614b');
hold on;
bar(r2, chatGptCorrectSum, bar_width, 'FaceColor', '#90ee90', 'EdgeColor', '#90ee90');
hold on;
text(r1, chatGptErrorSum, num2str(chatGptErrorSum), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r2, chatGptCorrectSum, num2str(chatGptCorrectSum), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
legends = legend('Incorrect', 'Correct', 'Location', 'northwest');
set(legends, 'FontSize', 8);
xticks([r3 / 2, r3 + 1.5]);
xticklabels({'ChatGPT', 'Copilot'});
ylabel('Generation count');
title('Code Correctness');
ylim([0 length(chatgpt_data)]);
box off;
hold off;

% Create bar chart for percentages
y1 = chatGptErrorSum / length(chatgpt_data) * 100;
y2 = chatGptCorrectSum / length(chatgpt_data) * 100;
y3 = copilotErrorSum / length(copilot_data) * 100;
y4 = copilotCorrectSum / length(copilot_data) * 100;

figure;
bar(r1, y1, bar_width, 'FaceColor', '#f2614b', 'EdgeColor', '#f2614b');
hold on;
bar(r2, y2, bar_width, 'FaceColor', '#90ee90', 'EdgeColor', '#90ee90');
hold on;
bar(r3 + bar_width, y3, bar_width, 'FaceColor', '#f2614b', 'EdgeColor', '#f2614b');
hold on;
bar(r4 + bar_width, y4, bar_width, 'FaceColor', '#90ee90', 'EdgeColor', '#90ee90');
hold on;
legendsPercentages = legend('Incorrect generations', 'Correct generations', 'Location', 'northwest');
set(legendsPercentages, 'FontSize', 8);
text(r1, y1, num2str(y1, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r2, y2, num2str(y2, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r3 + bar_width, y3, num2str(y3, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r4 + bar_width, y4, num2str(y4, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
xticks([r3 / 2, r3 + 1.5]);
xticklabels({'ChatGPT', 'Copilot'});
ylabel('%', 'Rotation', 0);
title('Code Correctness');
ylim([0 100]);
box off;
hold off;

figure;
bar(r1, y1, bar_width, 'FaceColor', '#f2614b', 'EdgeColor', '#f2614b');
hold on;
bar(r2, y2, bar_width, 'FaceColor', '#90ee90', 'EdgeColor', '#90ee90');
hold on;
legendsPercentages = legend('Incorrect generations', 'Correct generations', 'Location', 'northwest');
set(legendsPercentages, 'FontSize', 8);
text(r1, y1, num2str(y1, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r2, y2, num2str(y2, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
xticks([r3 / 2, r3 + 1.5]);
xticklabels({'ChatGPT', 'Copilot'});
ylabel('%', 'Rotation', 0);
title('Code Correctness');
ylim([0 100]);
box off;
hold off;

figure;
bar(r3 + bar_width, y3, bar_width, 'FaceColor', '#f2614b', 'EdgeColor', '#f2614b');
hold on;
bar(r4 + bar_width, y4, bar_width, 'FaceColor', '#90ee90', 'EdgeColor', '#90ee90');
hold on;
legendsPercentages = legend('Incorrect generations', 'Correct generations', 'Location', 'northwest');
set(legendsPercentages, 'FontSize', 8);
text(r3 + bar_width, y3, num2str(y3, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
text(r4 + bar_width, y4, num2str(y4, '%.2f%%'), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
xticks([r3 / 2, r3 + 1.5]);
xticklabels({'ChatGPT', 'Copilot'});
ylabel('%', 'Rotation', 0);
title('Code Correctness');
ylim([0 100]);
box off;
hold off;