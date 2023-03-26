% Load the Checkstyle XML report
report = xmlread('main.xml');

% Find all of the error messages in the report
messages = report.getElementsByTagName('error');

% Extract the line number for each error
lineNumbers = [];
for i = 0:(messages.getLength()-1)
    lineNumber = str2double(char(messages.item(i).getAttribute('line')));
    lineNumbers(end+1) = lineNumber;
end

% Create a histogram of the line numbers
figure;
histogram(lineNumbers);
xlabel('Line Number');
ylabel('Number of Errors');
title('Distribution of Errors by Line Number');
