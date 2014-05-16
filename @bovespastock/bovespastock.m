%% usages
%ativo1 = bovespastock(dbint,'PETR4.SA','startday','Jan 1 12','endday','Apr 11 14');
%ativo2 = bovespastock(dbint,?EMBR3.SA?,?nyears?,2);
%ativo3 = bovespastock(dbint,?OIBR4.SA?,?nmonths?,5);
%ativo4 = bovespastock(dbint,'ABEV3.SA?,?ndays?,60);

classdef bovespastock < stock
    properties
        ticker = ''
    end
    methods
        function obj = bovespastock(varargin)
            days = 0;
            prices = 0;
            dbint = varargin{1};
            tick = varargin{2};
            [has_startday,posstartday]=findstringcell(varargin,'startday');
            [has_endday,posendday]=findstringcell(varargin,'endday');
            [has_nyears,posnyears]=findstringcell(varargin,'nyears');
            [has_nmonths,posnmonths]=findstringcell(varargin,'nmonths');
            [has_ndays,posndays]=findstringcell(varargin,'ndays');
            if has_startday & has_endday
                initial = datenum(varargin{posstartday+1});
                final = datenum(varargin{posendday+1});
                [fdays,fprices] = dbint.getInterest('di',initial,final);
                rf = calculateRf(fdays,fprices);
                [mdays,mprices] = dbint.getPrices('^BVSP',initial,final);
                market = stock(mprices,'rf',rf,'dates',mdays,'ismarket');
                [days,prices] = dbint.getPrices(tick,initial,final);
            end
            obj = obj@stock(prices,'rf',rf,'dates',days,'market',market);
        end
    end
end