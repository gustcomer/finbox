function beta = calculateBeta(obj,market)
    [marketindexon,~] = ismember(market.date,obj.date);
    [objectindexon,~] = ismember(obj.date,market.date);
    retmarket = market.ret(marketindexon(2:end));
    retobj = obj.ret(objectindexon(2:end));
    covm = cov(retmarket,retobj,1);
    beta = covm(1,2)/covm(1,1);
end