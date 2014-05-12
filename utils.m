classdef utils
    properties
    end
    methods(Static = true)
        function obj = plotBeta(obj,market)
            [marketindexon,~] = ismember(market.date,obj.date);
            [objectindexon,~] = ismember(obj.date,market.date);
            retmarket = market.ret(marketindexon(2:end));
            retobj = obj.ret(objectindexon(2:end));
            plot(retmarket,retobj,'.');
        end
        function beta = calculateBeta(obj,market)
            [marketindexon,~] = ismember(market.date,obj.date);
            [objectindexon,~] = ismember(obj.date,market.date);
            retmarket = market.ret(marketindexon(2:end));
            retobj = obj.ret(objectindexon(2:end));
            covm = cov(retmarket,retobj,1);
            beta = covm(1,2)/covm(1,1);
        end
        function daysout = calculateDaysOut(obj,market)
            [indexon,~] = ismember(market.date,obj.date);
            daysout = market.date(~indexon);
        end
        function temean = calculateTEMean(obj,comp)
            [compindexon,~] = ismember(comp.date,obj.date);
            [objectindexon,~] = ismember(obj.date,comp.date);
            temean = mean(obj.ret(objectindexon(2:end))-comp.ret(compindexon(2:end)));
        end
        function te = calculateTE(obj,comp)
            [compindexon,~] = ismember(comp.date,obj.date);
            [objectindexon,~] = ismember(obj.date,comp.date);
            te = sqrt(cov(obj.ret(objectindexon(2:end))-comp.ret(compindexon(2:end)),1));
        end
        function semivar = calculateSemivar(obj)
            semiret = obj.ret-obj.rmean;
            semiret(semiret>0)=0;
            semivar = sum(semiret.*semiret)/length(semiret);
        end
        function te = compareDaysout(obj,comp)
            [compindexon,~] = ismember(comp.date,obj.date);
            [objectindexon,~] = ismember(obj.date,comp.date);
            fprintf('%s:\n',obj.ticker);
            datestr(obj.date(~objectindexon))
            fprintf('%s:\n',comp.ticker);
            datestr(comp.date(~compindexon))
        end
        function cf = cashflow(values,ta)
            n = length(values);
            terms = zeros(1,n);
            for ii=1:n
                terms(ii) = values(ii)/(1+ta)^ii;
            end
            cf = sum(terms);
        end
        function rf = convertRf(rf,option)
            if exist('option','var')
               if strcmp(option,'anualtodaily')
                   rf = ((1+rf/100)^(1/365)-1)*100;
               end
            else
                rf = ((1+rf/100)^(1/365)-1)*100; % default is daily
            end
        end
    end
end