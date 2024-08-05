function NBC = NormalizedBettiNumberCurve(img, O)

    tmpimg = imopen(img, strel('square', O));  %change here if we want variable opening size
    runPerseus('PD', tmpimg,2)
    pd = load('PD_1.txt');

    for i = 1:255
       indt = find(pd(:,1) <= i & pd(:,2) > i);
       NBC(i) = length(indt);
    end
    NBC = NBC/length(pd);
end
