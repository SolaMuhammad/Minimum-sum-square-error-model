function [ number] = MSSETest(  name,  dimX, dimY )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

w = dlmread('weights.txt');

%Get the feature vector for the unknown sample
I = getFV( name, dimX, dimY );

[rows,columns] = size(I) ;
I(1,columns+1) = 1 ;

% columnsRemove = dlmread('cols.txt');
% I(:,columnsRemove(1,:)) = [];
positive = 0 ;

number = 1000 ;
for i = 0:9
    di = I*w(:,i+1) ;
    if di > 0
        number = i ;
        positive = positive + 1 ;
    end
end

if positive > 1
    positive
    number = 1000;
    'Undetermined'
elseif positive == 0
    number = -1;
    'new class'

end
number
end

