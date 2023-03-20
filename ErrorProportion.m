% Parse the XML string
checkstyleData = xmlread('test-checkstyle.xml');

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
        else % Om algoritmen inte finns
            currentAlgorithm = containers.Map();
        end
        
        % Add new Tx
        errorCount = errorNodes.getLength();
        
        % Save map objects
        currentAlgorithm(tNum) = errorCount;
        algorithms(algorithm) = currentAlgorithm;
        errorCounts(AIModel) = algorithms;
    end
end

% Display the error counts for each AIModel and algorithm
%fprintf('Error Counts:\n');
%for AIModelKey = keys(errorCounts)
%    AIModel = AIModelKey{1};
%    algorithms = errorCounts(AIModel);
%    fprintf('%s:\n', AIModel);

    
%    for algorithmKey = keys(algorithms)
%        disp(algorithmKey{1});
        
%        algorithm = algorithms(algorithmKey{1});
        
%        for t = keys(algorithm)
%            tX = t{1};
            
%            currentAlgorithm = algorithm(tX);
%            disp(tX + ": " + currentAlgorithm);
%        end
%    end
% end

% Calculate Error percentage using number of lines

% Specify the file path
file_path = 'AlgorithmsLineCount.json';

% Read the file
file_contents = fileread(file_path);

% Parse the JSON data
json_data = jsondecode(file_contents);

fields = fieldnames(json_data);

fprintf('Error percentages:\n');
for i = 1:numel(fields)
    AIModel = fields{i}; % chatGPT/copilot

    % Change first char to upper case to match name in checkstyle
    AIModel = replace(AIModel,AIModel(1),upper(AIModel(1)));

    algorithms = errorCounts(AIModel);
    fprintf('   %s:\n', AIModel);

    subkeys = fieldnames(json_data.(fields{i}));
    for j = 1:numel(subkeys)
        disp("      " + subkeys{j}); % Algorithm name
        data = json_data.(fields{i}).(subkeys{j});

        % Checkstyle algorithm data
        algorithm = algorithms(subkeys{j}); % subkeys{j} = Algorithm name
        
        % Iterate all indexes and match with Tx
        for c = 1:numel(data)
            name = "T" + c;
            
            numOfAlgorithmLines = data(c);
            numOfCheckstyleErrors = algorithm(name);

            score = numOfCheckstyleErrors / numOfAlgorithmLines;

            disp("          " + name + ": " + score);
        end

    end
end



