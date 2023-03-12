% Load the XML file
doc = xmlread('main.xml');

% Get the root element
root = doc.getDocumentElement();

% Traverse the XML tree and extract the property values of "file" and "error" nodes
traverse(root, '');

% Function to traverse the XML tree and extract property values
function traverse(node, indent)
    % Get all child nodes of the current node
    childNodes = node.getChildNodes();

    % Extract the property values of "file" and "error" nodes
    switch char(node.getNodeName())
        case 'file'
            name = node.getAttribute('name');
            disp([indent, 'File Name: ', char(name)]);
        case 'error'
            line = node.getAttribute('line');
            column = node.getAttribute('column');
            severity = node.getAttribute('severity');
            message = node.getAttribute('message');
            source = node.getAttribute('source');
            disp([indent, 'Line: ', char(line), ', Column: ', char(column), ', Severity: ', char(severity), ', Message: ', char(message), ', Source: ', char(source)]);
        otherwise
            source = node.getAttribute('source');
    end
    
    % Recursively call the traverse function for each child node
    for i = 0:childNodes.getLength()-1
        childNode = childNodes.item(i);
        if childNode.getNodeType() == childNode.ELEMENT_NODE
            traverse(childNode, [indent, '  ']);
        end
    end
end
