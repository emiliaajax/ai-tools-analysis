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

% Display the sum of lines with and without errors
disp('ChatGPT')
disp(chatGptTotalLines - chatGptErrorSum);
disp(chatGptErrorSum);

disp('Copilot')
disp(copilotTotalLines - copilotErrorSum);
disp(copilotErrorSum);

% Concatenate the arrays into a single array
chatgpt_data = [bfs_chatgpt; binarysearch_chatgpt; bin2dec_chatgpt; 
    knapsack_chatgpt; mergesort_chatgpt; quicksort_chatgpt];

copilot_data = [bfs_copilot; binarysearch_copilot; bin2dec_copilot; 
    knapsack_copilot; mergesort_copilot; quicksort_copilot];

chatGptErrorSum = sum(chatgpt_data);
copilotErrorSum = sum(copilot_data);

% Display how many occurrences of each count of error
copilot_unique_values = unique(copilot_data);
copilot_unique_values = copilot_unique_values;

copilot_counts = histcounts(copilot_data, [
    copilot_unique_values', max(copilot_unique_values)+1]);

chatgpt_unique_values = unique(chatgpt_data);
chatgpt_unique_values = chatgpt_unique_values;

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