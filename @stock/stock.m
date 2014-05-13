classdef stock < equity
    properties
        rf = 0;
        sharpe = 0;
        sortino = 0;
        daysout = 0;
        beta = 0;
        treynor = 0;
        alpha = 0;
        m2 = 0;
        t2 = 0;
        temeanmarket = 0;
        temarket = 0;
        ir = 0;
    end
    methods
        function obj = stock(varargin)
            obj = obj@equity(varargin{:});
            % initialize Rf, if the case
            [has_rf,posrf]=findstringcell(varargin,'rf');
            [has_market,posmarket]=findstringcell(varargin,'market');
            ismarket=findstringcell(varargin,'ismarket');
            if has_rf
                obj.rf = varargin{posrf+1};
                obj.initializeRfindexes(obj.rf);
            else
                obj.rf=0;
            end
            %initialize index for nonmarket dependents
            if has_market & has_rf
                obj.initializeMarketandRfindexes(obj.rf,varargin{posmarket+1});
            end
            %some special initialization if stock is the market
            if ismarket
                obj.initializeMarket();
            end
        end
        
        obj = initializeRfindexes(obj,rf);
        obj = initializeMarketandRfindexes(obj,rf,market);
    end
end