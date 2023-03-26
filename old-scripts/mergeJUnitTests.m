folder_path = 'path/to/xml/files';
output_file = 'combined-test-results.xml';
combine_junit_xml_files(folder_path, output_file);

function combine_junit_xml_files(folder_path, output_file)
% Combines all JUnit XML files in a folder into a single file
% folder_path: the path to the folder containing JUnit XML files
% output_file: the path to the output file to write the combined results to

% Find all JUnit XML files in the specified folder
xml_files = dir(fullfile(folder_path, '*.xml'));
xml_files = {xml_files.name};

% Create a new Document object for the output file
doc = com.mathworks.xml.XMLUtils.createDocument('testsuites');
root = doc.getDocumentElement();

% Iterate over the input XML files and append their test suites to the output file
for i = 1:length(xml_files)
    % Load the input file as a Document object
    input_doc = xmlread(fullfile(folder_path, xml_files{i}));

    % Iterate over the test suite elements and append them to the output file
    testsuites = input_doc.getElementsByTagName('testsuite');
    for j = 0:testsuites.getLength()-1
        testsuite = testsuites.item(j);
        imported_node = doc.importNode(testsuite, true);
        root.appendChild(imported_node);
    end
end

% Write the combined results to the output file
xmlwrite(output_file, doc);
end
