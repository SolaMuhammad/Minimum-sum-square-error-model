function [ output_args ] = Ass1ts(  dimX, dimY)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

FVMatrix = zeros( dimX*dimY*2,100);

for i = 0:9
    for j = 1:10
        % Read the image and show it
        
        FVI = getFV( strcat(int2str(i),'_',int2str(j),'.bmp'),dimX, dimY ); 
      
        FVI = FVI.' ;
        %Every column represent a feature vector 
        for p=1:dimX*dimY*2
            FVMatrix(p,(i*10)+j)= FVI(p,1);
        end
        
    end
end

dlmwrite('FV1.txt',FVMatrix);

end

