classdef equity < handle
    properties
        price = 0;
        date = 0;
        ret = 0;
        nrdays = 0;
        rmean = 0;
        rvar = 0;
        rsd = 0;
        semivar = 0;
        semisd = 0;
    end
    methods
        function obj = equity(varargin)
            values = varargin{1};
            if findstringcell(varargin,'returns');
                   obj.ret = values;
                   obj.price = obj.simulatePrice(values);
            else
                obj.price = values;
                obj.calculateReturns();
            end
            [has_dates,posdates]=findstringcell(varargin,'dates');
            if has_dates
                obj.date = varargin{posdates+1};
            else
                obj.date = (1:length(obj.price))';
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