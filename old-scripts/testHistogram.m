% Load the Checkstyle XML report
report = xmlread('main.xml');

% Find all of the error messages in the report
messages = report.getElementsByTagName('error');

% Extract the severity and line number for each error
severities = {};
lineNumbers = [];
for i = 0:(messages.getLength()-1)
    severity = char(messages.item(i).getAttribute('severity'));
    lineNumber = str2double(char(messages.item(i).getAttribute('line')));
    severities{end+1} = severity;
    lineNumbers(end+1) = lineNumber;
end

% Split the line numbers into two groups based on severity
numErrors = length(lineNumbers);
numSevere = sum(strcmp(severities, 'error'));
numNonSevere = numErrors - numSevere;
severeLineNumbers = lineNumbers(strcmp(severities, 'error'));
nonSevereLineNumbers = lineNumbers(~strcmp(severities, 'error'));

% Calculate the mean line numbers of severe and non-severe errors
meanSevere = mean(severeLineNumbers);
meanNonSevere = mean(nonSevereLineNumbers);

% If the mean line number of severe or non-severe errors is NaN, set the value to 0
if isnan(meanSevere)
    meanSevere = 0;
end
if isnan(meanNonSevere)
    meanNonSevere = 0;
end

% Run a two-sample t-test to compare the means of the severe and non-severe groups
[h, p] = ttest2(severeLineNumbers, nonSevereLineNumbers);

% Plot histograms of the line numbers for each group
figure
histogram(severeLineNumbers, 'BinWidth', 1, 'Normalization', 'probability')
hold on
histogram(nonSevereLineNumbers, 'BinWidth', 1, 'Normalization', 'probability')
xlabel('Line number')
ylabel('Probability')
legend('Severe errors', 'Non-severe errors')

% Print the results of the t-test
fprintf('Number of severe errors: %d\n', numSevere);
fprintf('Number of non-severe errors: %d\n', numNonSevere);
fprintf('Mean line number of severe errors: %f\n', meanSevere);
fprintf('Mean line number of non-severe errors: %f\n', meanNonSevere);
fprintf('t-test p-value: %f\n', p);
if h
    fprintf('There is a significant difference between the means of the severe and non-severe groups.\n');
else
    fprintf('There is no significant difference between the means of the severe and non-severe groups.\n');
end
