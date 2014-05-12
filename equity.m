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
            obj.semivar = utils.calculateSemivar(obj);
            obj.semisd = sqrt(obj.semivar);
        end
        function obj = calculateReturns(obj)
            v = obj.price;
            obj.ret = 100*(v(2:end)-v(1:end-1))./v(1:end-1);
        end
        function p = simulatePrice(obj,ret)
            nret = length(ret);
            p = [100; zeros(nret,1)];
            for count = 2:length(p)
                p(count) = p(count-1)*(1+ret(count-1)/100);
            end
        end
        function obj = plotHistogram(obj)
            hist(obj.ret,20);
        end
    end
end