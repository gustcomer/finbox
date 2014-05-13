function obj = initializeRfindexes(obj,rf)
    obj.sharpe = (obj.rmean-rf)/obj.rsd;
    obj.sortino = (obj.rmean-rf)/obj.semisd;
end