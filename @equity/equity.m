classdef equity < handle
    properties
        price = 0;
        ret = 0;
        nrdays = 0;
        rmean = 0;
        rvar = 0;
        rsd = 0;
        semivar = 0;
        semisd = 0;
    end
    methods
        function obj = equity(values,option)
            if exist('option','var')
               if strcmp(option,'returns')
                   obj.ret = values;
                   obj.price = obj.simulatePrice(values);
               end
            else
                obj.price = values;
                obj.calculateReturns();
            end
            obj.nrdays = length(obj.price);
            obj.rmean = mean(obj.ret);
            obj.rvar = var(obj.ret,1);
            obj.rsd = sqrt(obj.rvar);
            obj.semivar = calculateSemivar(obj);
            obj.semisd = sqrt(obj.semivar);
        end
        
        obj = calculateReturns(obj);
        p = simulatePrice(obj,ret);
        obj = plotHistogram(obj);
    end
end