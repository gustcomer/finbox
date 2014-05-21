%% usages
%% Test stocks
%stock1 = stock([2; -1.4; 0.5; 1],'returns');
%stock0 = stock([100;101;105;106;107]);
%stock2 = stock([2; -1.4; 0.5; 1],'returns','rf',0.1);
%% resolucao exercicio
%market = stock([1; -0.8; 0; 0.7],'returns','rf',0.1,'ismarket');
%ativo = stock([2; -1.4; 0.5; 1],'returns','rf',0.1,'market',market);
%% testes extras
%ativoincompleto = stock([2; -1.4; 0.5],'returns','dates',[1;2;3;4],'rf',0.1,'market',market);
%% usando precos
%market = stock([100; 101; 105; 108],'rf',0.1,'dates',[2;4;5;8],'ismarket');
%ativo = stock([55; 57; 63; 80],'rf',0.1,'dates',[2;4;5;8],'market',market);

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
        obj = plot(obj,varargin);
    end
end