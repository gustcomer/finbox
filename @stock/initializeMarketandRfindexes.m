function obj = initializeMarketandRfindexes(obj,rf,market)
    obj.daysout=calculateDaysOut(obj,market);
    obj.beta = calculateBeta(obj,market);
    obj.treynor = (obj.rmean-rf)/obj.beta;
    obj.alpha = obj.rmean-(rf + obj.beta*(market.rmean-rf));
    obj.m2 = (obj.sharpe-market.sharpe)*market.rsd;
    obj.t2 = obj.treynor-market.treynor;
    obj.temeanmarket = calculateTEMean(obj,market);
    obj.temarket = calculateTE(obj,market);
    obj.ir = (obj.rmean-market.rmean)/obj.temarket;
end