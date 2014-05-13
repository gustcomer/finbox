function daysout = calculateDaysOut(obj,market)
    [indexon,~] = ismember(market.date,obj.date);
    daysout = market.date(~indexon);
    if length(daysout)==0
        daysout=0;
    end
end