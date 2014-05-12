classdef stock < handle
    properties
        ticker = '';
        date = 0;
        value = 0;
        volume = 0;
        nrdays = 0;
        daysout = 0;
        ret = 0;
        rf = 0;
        logret = 0;
        rmean = 0;
        rvar = 0;
        rlogmean = 0;
        rlogvar = 0;
        rsd = 0;
        rlogsd = 0;
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
        function obj = stock(ticker,firstDay,lastDay,rf,market)
            con = yahoo;
            try
            data = fetch(con, ticker, {'Adj Close','Volume'},firstDay,lastDay);
            catch err
                fprintf('error\n');
                % continue;
            end
            obj.ticker = ticker;
            obj.date = flipud(data(:,1));
            obj.value = flipud(data(:,2));
            obj.volume = flipud(data(:,3));
            obj.nrdays = size(data,1);
            obj.calculateReturns();
            obj.calculateLogReturns();
            obj.rmean = mean(obj.ret);
            obj.rvar = var(obj.ret,1);
            obj.rlogmean = mean(obj.logret);
            obj.rlogvar = var(obj.logret,1);
            obj.rsd = sqrt(obj.rvar);
            obj.rlogsd = sqrt(obj.rlogvar);
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
        function obj = calculateReturns(obj)
            v = obj.value;
            obj.ret = 100*(v(2:end)-v(1:end-1))./v(1:end-1);
        end
        function obj = calculateLogReturns(obj)
            v = obj.value;
            obj.logret = 100*log(v(2:end))-log(v(1:end-1));
        end
        function obj = marketCalculations(obj,market,rf)
            obj.daysout=utils.calculateDaysOut(obj,market);
            obj.beta=utils.calculateBeta(obj,market);
            obj.treynor = (obj.rmean-rf)/obj.beta;
            obj.alpha = obj.rmean-(rf + obj.beta*(market.rmean-rf));
            obj.m2 = (obj.sharpe-market.sharpe)*market.rsd;
            obj.t2 = obj.treynor-market.treynor;
            obj.temeanmarket = utils.calculateTEMean(obj,market);
            obj.temarket = utils.calculateTE(obj,market);
            obj.ir = (obj.rmean-market.rmean)/obj.temarket;
        end
        function obj = plotHistogram(obj,option)
            if exist('option','var')
               if strcmp(option,'log')
                   hist(obj.logret,20);
               end
            else
                hist(obj.ret,20);
            end
        end
    end
end