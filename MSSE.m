function [  ] = MSSE()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Get the feature vectors for the training data
FVMatrix = dlmread('FV1.txt');

%Building augmented vectors by adding 1
FVMatrix = FVMatrix.';%z

[rows,columns] = size(FVMatrix) ;

for i = 1:100
    FVMatrix(i,columns+1) = 1 ;
end

[rows,columns] = size(FVMatrix) ;
end1 = 1 ;
ze = zeros(100,1);
columnsRemove = [];
%eliminating 0 columns
for i = 1:columns
    if FVMatrix(:,i) == ze
        columnsRemove(end1) = i;
        end1 = end1 + 1 ;
    end
end

dlmwrite('cols.txt',columnsRemove);
if size(columnsRemove,1) >= 1 && size(columnsRemove,2) >= 1
    FVMatrix(:,columnsRemove(:,1)) = [];
end

[rows,columns] = size(FVMatrix) ;

%Building the model 
b = ones(100,1) ;
w = zeros(columns,10);
%Applying the formula w = (z(transposed)*z)inversed* ztransposed*b
for i = 0:9
    z = FVMatrix ;
    for j = 1:100
        if j < ((i*10)+1) || j > ((i+1)*10)
            z(j,:) = FVMatrix(j,:)*-1 ;
           
        end
        
    end

    ztrans = z.' ;%z transposed
    pro1 = (ztrans*z) ;
    zinv = pinv(pro1) ;
    dotProd = zinv*ztrans ;
    w(:,i+1) = dotProd*b ;
    
end
dlmwrite('weights.txt',w);
end

