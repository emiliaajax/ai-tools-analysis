% Specify the file path
file_path = 'AlgorithmsLineCount2.json';

% Read the file
file_contents = fileread(file_path);

% Parse the JSON data
json_data = jsondecode(file_contents);

% Create empty arrays to store the sum of each algorithm
gpt_binary_search_sum = 0;
gpt_bfs_sum = 0;
gpt_knapsack_sum = 0;
gpt_merge_sort_sum = 0;
gpt_quick_sort_sum = 0;

copilot_binary_search_sum = 0;
copilot_bfs_sum = 0;
copilot_knapsack_sum = 0;
copilot_merge_sort_sum = 0;
copilot_quick_sort_sum = 0;

% Calculate the sum of each algorithm for each AI model
fields = fieldnames(json_data);
for i = 1:numel(fields)
    subkeys = fieldnames(json_data.(fields{i}));
    for j = 1:numel(subkeys)
        data = json_data.(fields{i}).(subkeys{j});
        algorithm_sum = sum(data);
        
        if strcmp(fields{i}, 'chatGPT')
            switch subkeys{j}
                case 'BinarySearch'
                    gpt_binary_search_sum = algorithm_sum;
                case 'BreadthFirstSearch'
                    gpt_bfs_sum = algorithm_sum;
                case 'Knapsack'
                    gpt_knapsack_sum = algorithm_sum;
                case 'MergeSort'
                    gpt_merge_sort_sum = algorithm_sum;
                case 'QuickSort'
                    gpt_quick_sort_sum = algorithm_sum;
            end
        elseif strcmp(fields{i}, 'copilot')
            switch subkeys{j}
                case 'BinarySearch'
                    copilot_binary_search_sum = algorithm_sum;
                case 'BreadthFirstSearch'
                    copilot_bfs_sum = algorithm_sum;
                case 'Knapsack'
                    copilot_knapsack_sum = algorithm_sum;
                case 'MergeSort'
                    copilot_merge_sort_sum = algorithm_sum;
                case 'QuickSort'
                    copilot_quick_sort_sum = algorithm_sum;
            end
        end
    end
end

% Plot the data on a bar graph
xlabels = {'chatGPT', 'copilot'};
data = [gpt_binary_search_sum, gpt_bfs_sum, gpt_knapsack_sum, gpt_merge_sort_sum, gpt_quick_sort_sum;
        copilot_binary_search_sum, copilot_bfs_sum, copilot_knapsack_sum, copilot_merge_sort_sum, copilot_quick_sort_sum];

figure;
bar(data);
set(gca, 'XTickLabel', xlabels);
legend('BinarySearch', 'BreadthFirstSearch', 'Knapsack', 'MergeSort', 'QuickSort');
title('Algorithm Line Count by AI Model');
ylabel('Line Count');
