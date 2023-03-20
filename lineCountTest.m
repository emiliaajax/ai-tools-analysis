% Specify the file path
file_path = 'AlgorithmsLineCount.json';

% Read the file
file_contents = fileread(file_path);

% Parse the JSON data
json_data = jsondecode(file_contents);

fields = fieldnames(json_data);

for i = 1:numel(fields)
    disp(fields{i}); % chatGPT/copilot
    subkeys = fieldnames(json_data.(fields{i}));
    for j = 1:numel(subkeys)
        disp("  " + subkeys{j}); % Algorithm name
        data = json_data.(fields{i}).(subkeys{j});

        % disp(data);
        
        % Iterate all indexes and match with Tx
        for c = 1:numel(data)
            name = "T" + c;
            value = data(c);
            disp(name + ": " + value);
        end

    end
end