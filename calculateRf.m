%% usage:
%% 
function rf = calculateRf(days,values)
    first = days(1);
    last = days(end);
    rfvector = zeros(last-first+1,1);
    
    for i=1:length(days)
        j = days(i)-days(1)+1;
        if i==length(days)
            delta = 0;
        else
            delta = days(i+1)-days(i)-1;
        end
        rfvector(j:(j+delta))=values(i);
    end
    rtotal=1;
    for i=1:length(rfvector)
        daily = ((1+rfvector(i)/100)^(1/365)-1);
        rtotal = rtotal*(1+daily);
    end
    
    ndaysmarket = length(values);
    rf = (rtotal^(1/ndaysmarket)-1)*100;
end