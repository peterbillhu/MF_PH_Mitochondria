function SDB = SizeDistrBettiNumber(img, T)

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
    SDB = [zeros(1,19)];
else
    indS = (pd1(:,1)==1);
    if isempty(indS)
        SDB = [zeros(1,19)];
    else
        [counts, d] = hist(pd1(indS,2), 1:20);
        SDB = [ counts(2:end)/sum(counts)];
    end
end

end
