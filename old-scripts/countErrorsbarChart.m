% Parse the XML string
% checkstyleData = xmlread('test-checkstyle.xml');
checkstyleData = xmlread('checkstyle-combined-fixed.xml');


% Get all the "file" elements
fileNodes = checkstyleData.getElementsByTagName('file');

% Create a map to keep track of error counts
errorCounts = containers.Map();

% Loop through each file node
for i = 0:fileNodes.getLength()-1
    % Get the current file node
    fileNode = fileNodes.item(i);

    % Get the value of the "name" attribute
    nameAttr = fileNode.getAttribute('name');

    % Convert nameAttr to a string and split it at the "\" character
    nameParts = split(string(char(nameAttr)), "\");
    AIModel = nameParts(end-3);
    algorithm = extractBefore(nameParts(end), ".");

    % Check if folderName is either "Copilot" or "ChatGPT"
    if ismember(AIModel, ["Copilot", "ChatGPT"])
        % Get all the "error" elements for this file node
        errorNodes = fileNode.getElementsByTagName('error');

        % Get the current error count for this AIModel and algorithm
        if isKey(errorCounts, AIModel)
            algorithmCounts = errorCounts(AIModel);
            if isKey(algorithmCounts, algorithm)
                errorCount = algorithmCounts(algorithm);
            else
                errorCount = 0;
            end
        else
            algorithmCounts = containers.Map();
            errorCount = 0;
        end

        % Add the number of error nodes to the current count
        errorCount = errorCount + errorNodes.getLength();

        % Update the error count for this AIModel and algorithm
        algorithmCounts(algorithm) = errorCount;
        errorCounts(AIModel) = algorithmCounts;
    end
end

% Display the error counts for each AIModel and algorithm
fprintf('Error Counts:\n');
for AIModelKey = keys(errorCounts)
    AIModel = AIModelKey{1};
    algorithmCounts = errorCounts(AIModel);
    fprintf('%s:\n', AIModel);
    for algorithmKey = keys(algorithmCounts)
        algorithm = algorithmKey{1};
        errorCount = algorithmCounts(algorithm);
        fprintf('  %s: %d\n', algorithm, errorCount);
    end
end

% Create a bar chart of the error counts
figure;
barData = [];
algorithmLabels = {};
for AIModelKey = keys(errorCounts)
    AIModel = AIModelKey{1};
    algorithmCounts = errorCounts(AIModel);
    for algorithmKey = keys(algorithmCounts)
        algorithm = algorithmKey{1};
        errorCount = algorithmCounts(algorithm);
        barData = [barData errorCount];
        algorithmLabel = sprintf('%s.%s', AIModel, algorithm);
        algorithmLabels = [algorithmLabels algorithmLabel];
    end
end
bar(barData);
xticks(1:length(barData));
xticklabels(algorithmLabels);
xtickangle(45);
ylabel('Error Count');
title('Error Counts by AI Model and Algorithm');
