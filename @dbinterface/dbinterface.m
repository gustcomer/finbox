%% usage
%dbint = dbinterface('brasil');
%dbint.createTable(?EMBR3.SA?);
%dbint.isThere('VOLE5.SA') % retorna 0 pois é VALE
%dbint.insertEntry(ticker,'date',data(j,1),'open',data(j,2),'close',data(j,3),'adjclose',data(j,4),'high',data(j,5),'low',data(j,6),'volume',data(j,7));
%dbint.insertEntry('ABEV3.SA','date',15,'open',2,'close',5,'adjclose',4,'high',7,'low',-3,'volume',100);
%dbint.deleteEntry('ABEV3.SA',13);
%tables = dbint.getTables();
%dbint.getPrices('HGTX3.SA',733675,733690)
%dbint.createInterestTable('di')
%dbint.insertInterestEntry('di',127,0.02)
%dbint.deleteEntry('di',127);
%dbint.getInterest('di?,383738, 383748);
%dbint.createFundTable('EMBR3.SA')
%dbint.insertFundEntry('EMBR3.SA',1,2014,23223654,13313991,6785173,8235984,258701)

classdef dbinterface
    properties
        conn = 0;
        connf = 0;
        name = '';
        namefund = '';
        webint = 0;
    end
    methods
        function obj = dbinterface(varargin)
            obj.name = varargin{1};
            obj.namefund = varargin{2};
            javaaddpath 'mysql-connector-java-5.1.30-bin.jar';
            address = sprintf('jdbc:mysql://localhost/%s',obj.name);
            obj.conn = database(obj.name, 'root', '', 'com.mysql.jdbc.Driver',address);
            addressf = sprintf('jdbc:mysql://localhost/%s',obj.namefund);
            obj.connf = database(obj.namefund, 'root', '', 'com.mysql.jdbc.Driver',addressf);
            obj.webint = yahoo();
            
        end
        function obj = createTable(obj,name)
            exp= sprintf('CREATE TABLE IF NOT EXISTS `%s` (`DATE` int(11) NOT NULL,`OPEN` double DEFAULT NULL,`CLOSE` double DEFAULT NULL,`ADJCLOSE` double DEFAULT NULL,`HIGH` double DEFAULT NULL,`LOW` double DEFAULT NULL,`VOLUME` int(11) DEFAULT NULL,PRIMARY KEY (`DATE`))  ENGINE=InnoDB DEFAULT CHARSET=latin1;',name);
            fetch(exec(obj.conn,exp));
        end
        function obj = createInterestTable(obj,name)
            exp= sprintf('CREATE TABLE IF NOT EXISTS `%s` (`DATE` int(11) NOT NULL,`RATE` double DEFAULT NULL,PRIMARY KEY (`DATE`))  ENGINE=InnoDB DEFAULT CHARSET=latin1;',name);
            fetch(exec(obj.conn,exp));
        end
        function success = insertInterestEntry(obj,varargin)
            ticker = varargin{1};
            date = varargin{2};
            value = varargin{3};
            exp= sprintf('INSERT INTO `%s` (`DATE`, `RATE`) VALUES (''%s'', ''%s'');',ticker,num2str(date),num2str(value));
            rs=fetch(exec(obj.conn,exp));
            success = rs;
        end
        function obj = deleteTable(obj,name)
            exp= sprintf('DROP TABLE `%s`;',name);
            fetch(exec(obj.conn,exp));
        end
        function tables = getTables(obj)
            exp= sprintf('SHOW TABLES;');
            rs=fetch(exec(obj.conn,exp));
            tables=rs.Data;
        end
        function is = isThere(obj,name)
            exp= sprintf('SHOW TABLES;');
            rs=fetch(exec(obj.conn,exp));
            tables=rs.Data;
            is=any(ismember(tables,name));
        end
        function success = insertEntry(obj,varargin)
            name = varargin{1};
            date = 0;
            open = 0;
            close = 0;
            adjclose = 0;
            high = 0;
            low = 0;
            volume = 0;
            [has_date,posdate]=findstringcell(varargin,'date');
            [has_open,posopen]=findstringcell(varargin,'open');
            [has_close,posclose]=findstringcell(varargin,'close');
            [has_adjclose,posadjclose]=findstringcell(varargin,'adjclose');
            [has_high,poshigh]=findstringcell(varargin,'high');
            [has_low,poslow]=findstringcell(varargin,'low');
            [has_volume,posvolume]=findstringcell(varargin,'volume');
            if has_date
                date = varargin{posdate+1};
            else
                date=0;
            end
            if has_open
                open = varargin{posopen+1};
            else
                open=0;
            end
            if has_close
                close = varargin{posclose+1};
            else
                close=0;
            end
            if has_adjclose
                adjclose = varargin{posadjclose+1};
            else
                adjclose=0;
            end
            if has_high
                high = varargin{poshigh+1};
            else
                high=0;
            end
            if has_low
                low = varargin{poslow+1};
            else
                low=0;
            end
            if has_volume
                volume = varargin{posvolume+1};
            else
                volume=0;
            end
            exp= sprintf('INSERT INTO `%s` (`DATE`, `OPEN`, `CLOSE`, `ADJCLOSE`, `HIGH`, `LOW`, `VOLUME`) VALUES (''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'');',name,num2str(date),num2str(open),num2str(close),num2str(adjclose),num2str(high),num2str(low),num2str(volume));
            rs=fetch(exec(obj.conn,exp));
            success=rs;
        end
        function success = populate(obj,varargin)
            tick = varargin{1};
            first = varargin{2};
            last = varargin{3};
            
            fail = 0;
            try
            data = fetch(obj.webint,tick,{'Open','Close','Adj Close','High','Low','Volume'},first,last);
            catch err
                fail=1;
            end
            
            if fail==0
                for j=1:size(data,1)
                    obj.insertEntry(tick,'date',data(j,1),'open',data(j,2),'close',data(j,3),'adjclose',data(j,4),'high',data(j,5),'low',data(j,6),'volume',data(j,7));
                end
            end
        end
        function success = getentry(obj,varargin)
            ticker=varargin{1};
            day = varargin{2};
            column = varargin{3};
            exp= sprintf('SELECT %s FROM `%s` WHERE DATE = %s;',column,ticker,num2str(day));
            rs=fetch(exec(obj.conn,exp));
            success = rs;
        end
        function [dates,prices] = getPrices(obj,varargin)
            ticker=varargin{1};
            firstday = varargin{2};
            lastday = varargin{3};
            if length(varargin)>3
                exp= sprintf('SELECT DATE,%s FROM `%s` WHERE DATE BETWEEN %s AND %s;',varargin{4},ticker,num2str(firstday),num2str(lastday));
            else
                exp= sprintf('SELECT DATE,ADJCLOSE FROM `%s` WHERE DATE BETWEEN %s AND %s;',ticker,num2str(firstday),num2str(lastday));
            end
            rs=fetch(exec(obj.conn,exp));
            data = rs.Data;
            dates = cell2mat(data(:,1));
            prices = cell2mat(data(:,2));
        end
        function [dates,prices] = getInterest(obj,varargin)
            ticker=varargin{1};
            firstday = varargin{2};
            lastday = varargin{3};
            exp= sprintf('SELECT DATE,RATE FROM `%s` WHERE DATE BETWEEN %s AND %s;',ticker,num2str(firstday),num2str(lastday));
            rs=fetch(exec(obj.conn,exp));
            data = rs.Data;
            dates = cell2mat(data(:,1));
            prices = cell2mat(data(:,2));
        end
        function success = deleteEntry(obj,day,date)
            exp= sprintf('DELETE FROM `%s` WHERE DATE = %s;',num2str(day),num2str(date));
            rs=fetch(exec(obj.conn,exp));
            success = rs;
        end
        function day = getLastDay(obj,varargin)
            ticker=varargin{1};
            exp= sprintf('SELECT DATE FROM `%s` ORDER BY DATE DESC LIMIT 1',ticker);
            rs=fetch(exec(obj.conn,exp));
            day = datestr(rs.Data{1});
        end
        function day = getFirstDay(obj,varargin)
            ticker=varargin{1};
            exp= sprintf('SELECT DATE FROM `%s` ORDER BY DATE ASC LIMIT 1',ticker);
            rs=fetch(exec(obj.conn,exp));
            day = datestr(rs.Data{1});
        end
        function obj = createFundTable(obj,name)
            exp= sprintf('CREATE TABLE IF NOT EXISTS `%s` (`DATE` int(11) DEFAULT NULL,`AT` int(11) DEFAULT NULL,`AC` int(11) DEFAULT NULL,`PC` int(11) DEFAULT NULL,`PL` int(11) DEFAULT NULL,`LL` int(11) DEFAULT NULL, PRIMARY KEY (`DATE`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;',name);
            fetch(exec(obj.connf,exp));
        end
        function is = isThereFund(obj,name)
            exp= sprintf('SHOW TABLES;');
            rs=fetch(exec(obj.connf,exp));
            tables=rs.Data;
            is=any(ismember(tables,name));
        end
        function success = insertFundEntry(obj,varargin)
            name  = varargin{1};
            trim = varargin{2};
            year = varargin{3};
            date = str2num([num2str(year),num2str(trim)]);
            at = varargin{4};
            ac = varargin{5};
            pc = varargin{6};
            pl = varargin{7};
            ll = varargin{8};

            if ~obj.isThereFund(name)
               obj.createFundTable(name);
            end
            
            exp= sprintf('INSERT INTO `%s` (`DATE`,`AT`,`AC`,`PC`,`PL`,`LL`) VALUES (''%s'',''%s'', ''%s'', ''%s'', ''%s'', ''%s'');',name,num2str(date),num2str(at),num2str(ac),num2str(pc),num2str(pl),num2str(ll) );
            rs=fetch(exec(obj.connf,exp));
            success=rs;
        end
        function res = getFundEntry(obj,varargin)
            ticker=varargin{1};
            year = varargin{2};
            trim = varargin{3};
            date = str2num([num2str(year),num2str(trim)]);
            
            exp= sprintf('SELECT * FROM `%s` WHERE DATE = %s;',ticker,num2str(date));
            result=fetch(exec(obj.connf,exp));
            res = result.Data;
        end
        function res = getFundHistory(obj,varargin)
            ticker=varargin{1};
            
            exp= sprintf('SELECT * FROM `%s`;',ticker);
            result=fetch(exec(obj.connf,exp));
            res = result.Data;
        end
    end
end