function [ FV ] = getFV( name, dimX, dimY )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Read the image and show it
im = imread(name);
[m,n] = size(im);
%Convert to binary image
im =  im2bw(im);

% get the compliment of the image and show it
im1 = imcomplement(im);


% get the non zero pixels in im image
[y,x] = find(im1);


% get the minimum and maximum of dimensions of the number
% to use it to crop the image
x_min = min(x) ;
y_min = min(y) ;
width = max(x)-min(x);
height = max(y)-min(y);
cropped = imcrop(im1, [x_min y_min width height]);

% Padding with zeros
[m,n] = size(cropped);
pad1 = dimX-mod(m,dimX);
pad2 = dimY-mod(n,dimY);
if pad1 == dimX
    pad1 = 0;
end
if pad2 == dimY
    pad2 = 0;
end

%croppadded = [ [cropped;zeros(1,n)] zeros(m+1,1)];
cropped = [cropped zeros(m,pad2)];

n = n+pad2;

croppadded = [cropped; zeros(pad1 ,n)];
%croppadded = padarray(cropped,padsize);

%divide the matrix into submatrices
[m,n] = size(croppadded);
M = m/dimX*ones(1,dimX);
N = n/dimY*ones(1,dimY);
B = mat2cell(croppadded,M,N);

%iterate on the blocks and calculate the centroid of each block
% c is iterator on number of blocks on the vertical dimension
% d is iterator on number of blocks on the horizontal dimension
% feature vector is the vector of the centroid of the blocks of the
% current image(i,j)
%end1*end2 determines the number of blocks
end1 = dimX;
end2 = dimY;
featureVec = 1:end1*end2*2;
if i == 0 && j == 1
    totalMat = zeros(100,end1*end2*2);
end
%Generate the feature vector
End = 1;
for c = 1:end1
    for d= 1:end2
        [size1,size2] = size(B{c,d});
        % calculate the centroid
        fx = 0;
        fy = 0;
        en = 0;
        for a = 1:size1
            for b = 1:size2
                fx = fx + b*B{c,d}(a,b);
                fy = fy + a*B{c,d}(a,b);
                en = en + B{c,d}(a,b);
                
            end
        end
        
        % Normalization divide xCentroid on the width and ycentroid
        % on the height of the block
        if fx == 0
            fx = 0;
        elseif  en ==0
            fx = 0;
        else
            fx = fx/en;
            fy = fy/en;
        end
        
        if fy == 0
            fy = 0;
        elseif  en ==0
            fy = 0;
        else
            fx = fx/en;
            fy = fy/en;
        end
        %Normalize the vectors
        blockHeight = m/dimX;
        blockWidth = n/dimY;
        featureVec(End) = (fx/blockWidth);
        End = End+1;
        featureVec(End) = (fy/blockHeight);
        End = End+1;
        
        %totalMat(i*10+j,:) = featureVec
        
    end
end
FV = featureVec;


end

