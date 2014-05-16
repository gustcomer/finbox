%% usage:
%% calculateTotalReturn([1;2;3])

function rf = calculateTotalReturn(values)
    totalret=1;
    for i=1:length(values)
        totalret = totalret*(1+values(i)/100);
    end
    rf = (totalret-1)*100;
end