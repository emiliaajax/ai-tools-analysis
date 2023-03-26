% Specify the file path
file_path = 'AlgorithmsLineCount.json';

% Read the file
file_contents = fileread(file_path);

% Parse the JSON data
json_data = jsondecode(file_contents);

% Print all the data to console
fields = fieldnames(json_data);

for i = 1:numel(fields)
    disp(fields{i});
    subkeys = fieldnames(json_data.(fields{i}));
    for j = 1:numel(subkeys)
        disp(subkeys{j});
        disp(json_data.(fields{i}).(subkeys{j}));
    end
end
