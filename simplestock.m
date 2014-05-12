classdef simplestock < handle
    properties
        nrdays = 0;
        ret = 0;
        rf = 0;
        logret = 0;
        rmean = 0;
        rvar = 0;
        rsd = 0;
        semivar = 0;
        semisd = 0;
        beta = 0;
        sharpe = 0;
        treynor = 0;
        alpha = 0;
        m2 = 0;
        t2 = 0;
        temeanmarket = 0;
        temarket = 0;
        ir = 0;
        sortino = 0;
    end
    methods
        function obj = simplestock(r,rf,market)
            obj.nrdays = size(r,1);
            obj.ret = r;
            obj.rmean = mean(obj.ret);
            obj.rvar = var(obj.ret,1);
            obj.rsd = sqrt(obj.rvar);
            obj.semivar = utils.calculateSemivar(obj);
            obj.semisd = sqrt(obj.semivar);
            if exist('rf','var')
               obj.rf = rf;
               obj.sharpe = (obj.rmean-rf)/obj.rsd;
               obj.sortino = (obj.rmean-rf)/obj.semisd; %
            end
            if exist('rf','var') & exist('market','var')
                obj.marketCalculations(market,rf);
            else
                obj.beta=1;
                obj.treynor = (obj.rmean-rf)/obj.beta;
            end
        end
        function obj = marketCalculations(obj,market,rf)
            obj.beta=obj.calculateBeta(market);
            obj.treynor = (obj.rmean-rf)/obj.beta;
            obj.alpha = obj.rmean-(rf + obj.beta*(market.rmean-rf));
            obj.m2 = (obj.sharpe-market.sharpe)*market.rsd;
            obj.t2 = obj.treynor-market.treynor;
            obj.temeanmarket = obj.calculateTEMean(market);
            obj.temarket = obj.calculateTE(market);
            obj.ir = (obj.rmean-market.rmean)/obj.temarket;
        end
        function beta = calculateBeta(obj,market)
            covm = cov(obj.ret,market.ret,1);
            beta = covm(1,2)/covm(2,2);
        end
        function temean = calculateTEMean(obj,comp)
            temean = mean(obj.ret-comp.ret);
        end
        function te = calculateTE(obj,comp)
            te = sqrt(cov(obj.ret-comp.ret,1));
        end
    end
end