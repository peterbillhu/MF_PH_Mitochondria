function CI = ConnectivityIndex(img, T)

bwmat = img > T;
%% Get opening filtration
A = zeros( size(bwmat));
for i = 20:-1:2
    A = A + imopen( bwmat, strel('square', i));    
end
A = A + bwmat;


%% Compute Vertical PD
runPerseus('PD', A+1, 2);
pd1 = load('PD_1.txt');
    
%% Compute Size distribution
if isempty(pd1)
    CI = 1;
else
    indC = pd1(:,1)>=2;
    CI = sum( pd1(indC,2) - pd1(indC,1))/sum(pd1(:,2)-pd1(:,1));
end

end
