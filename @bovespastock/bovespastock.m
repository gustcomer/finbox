%% usages
%ibov = bovespastock(dbint,'^BVSP','startday','Jan 1 12','endday','Apr 11 14');
%ativo1 = bovespastock(dbint,'PETR4.SA','startday','Jan 1 12','endday','Apr 11 14');
%ativo2 = bovespastock(dbint,'EMBR3.SA','nyears',2);
%ativo3 = bovespastock(dbint,'OIBR4.SA','nmonths',5);
%ativo4 = bovespastock(dbint,'ABEV3.SA','ndays',60);

classdef bovespastock < stock
    properties
        ticker = '';
        dbint = 0;
    end
    methods
        function obj = bovespastock(varargin)
            days = 0;
            prices = 0;
            dbi = varargin{1};
            tick = varargin{2};
            [has_startday,posstartday]=findstringcell(varargin,'startday');
            [has_endday,posendday]=findstringcell(varargin,'endday');
            [has_nyears,posnyears]=findstringcell(varargin,'nyears');
            [has_nmonths,posnmonths]=findstringcell(varargin,'nmonths');
            [has_ndays,posndays]=findstringcell(varargin,'ndays');
            
            if has_startday & has_endday
                initial = datenum(varargin{posstartday+1});
                final = datenum(varargin{posendday+1});
            elseif has_nmonths
                nmonths = varargin{posnmonths+1};
                initial = today()-30*nmonths;
                final = today();
            elseif has_nyears
                nyears = varargin{posnyears+1};
                initial = today()-365*nyears;
                final = today();
            end
            
            try
            	lastday = datenum(dbi.getLastDay(tick));
            catch err
                dbi.createTable(tick);
                lastday = final-365*5;
            end
            
            
            if lastday<final;
                dbi.populate(tick,lastday,final);
            end

            [fdays,fprices] = dbi.getInterest('di',initial,final);
            rf = calculateRf(fdays,fprices);
            [mdays,mprices] = dbi.getPrices('^BVSP',initial,final);
            market = stock(mprices,'rf',rf,'dates',mdays,'ismarket');
            [days,prices] = dbi.getPrices(tick,initial,final);
                
            obj = obj@stock(prices,'rf',rf,'dates',days,'market',market);
            obj.dbint = dbi;
            obj.ticker = tick;
        end
        obj = getDay(obj,varargin);
    end
end