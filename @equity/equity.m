%% usages
%equity0 = equity([100;101;105;106;107]);
%equity1 = equity([2; -1.4; 0.5; 1],'returns');
%equity2 = equity([100;101;105;106;107],'dates',[2;4;7;8;9]);
%equity3 = equity([1; -0.8; 0; 0.7],'returns','dates',[3;6;7;8;9]);
%marketequity = equity([1; -0.8; 0; 0.7],'returns');

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