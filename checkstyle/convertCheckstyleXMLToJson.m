% Parse the XML string
checkstyleData = xmlread('./data/checkstyle/CheckstyleReport.xml');

% Get all the "file" elements
fileNodes = checkstyleData.getElementsByTagName('file');

% Create a map to keep track of error counts
errorCounts = containers.Map();

% Loop through each file node
for i = 0:fileNodes.getLength()-1
    % Get the current file node
    fileNode = fileNodes.item(i);

    % Get value of the "name" attribute
    nameAttr = fileNode.getAttribute('name');

    % Convert nameAttr to a string and split at the "\" character
    nameParts = split(string(char(nameAttr)), "\");
    AIModel = nameParts(end-3);
    algorithm = extractBefore(nameParts(end), ".");
    
    % Name of generated code T1, T2, etc
    tNum = nameParts(end-1);
    % disp(tNum);

    % Get all the "error" elements for this file node
    errorNodes = fileNode.getElementsByTagName('error');

    % Check if folderName is either "Copilot" or "ChatGPT"
    if ismember(AIModel, ["Copilot", "ChatGPT"])
        % Create algorithms map for AI model if needed
        if isKey(errorCounts, AIModel)
            algorithms = errorCounts(AIModel);
        else
            algorithms = containers.Map();
        end

        % Check if algorithm exist in algorithms
        if isKey(algorithms, algorithm)
            currentAlgorithm = algorithms(algorithm);
        else % If algorithm doesn't exist, create an empty array
            currentAlgorithm = [];
        end
        
        % Add new Tx
        errorCount = errorNodes.getLength();
        
        % Save map objects
        currentAlgorithm(end+1) = errorCount;
        % disp(currentAlgorithm);
        algorithms(algorithm) = currentAlgorithm;
        errorCounts(AIModel) = algorithms;
    end
end

% Display the error counts for each AIModel and algorithm
%fprintf('Error Counts:\n');
%for AIModelKey = errorCounts.keys
%    AIModel = AIModelKey{1};
%    algorithms = errorCounts(AIModel);
%    fprintf('%s:\n', AIModel);

    
%    for algorithmKey = algorithms.keys
%        disp(algorithmKey{1});
        
%        algorithm = algorithms(algorithmKey{1});
        
%         for t = 1:length(algorithm)
            
             % Retrieve the array for the current algorithm and Tx
 %            currentAlgorithm = algorithm(t);
             % Display the error count for this Tx
 %            disp(currentAlgorithm);
 %        end
 %   end
%end

% Convert Map to json
jsonStr = jsonencode(errorCounts, 'PrettyPrint', true);

% Display JSON string
% disp(jsonStr);

% Open file for writing
fid = fopen('./data/checkstyle/CheckstyleReport.json', 'w');

% Write JSON string to file
fprintf(fid, '%s', jsonStr);

% Close file
fclose(fid);
