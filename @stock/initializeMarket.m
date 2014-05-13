function obj = initializeMarket(obj)
    obj.beta=1;
    obj.treynor = (obj.rmean-obj.rf)/obj.beta;
end