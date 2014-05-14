classdef dbinterface
    properties
        conn = 0;
        name = '';
    end
    methods
        function obj = dbinterface(varargin)
            obj.name = varargin{1};
            javaaddpath 'mysql-connector-java-5.1.30-bin.jar';
            address = sprintf('jdbc:mysql://localhost/%s',obj.name);
            obj.conn = database(obj.name, 'root', '', 'com.mysql.jdbc.Driver',address);
            
        end
        function obj = createTable(obj,name)
            exp= sprintf('CREATE TABLE IF NOT EXISTS `%s` (`DATE` int(11) NOT NULL,`OPEN` double DEFAULT NULL,`CLOSE` double DEFAULT NULL,`ADJCLOSE` double DEFAULT NULL,`HIGH` double DEFAULT NULL,`LOW` double DEFAULT NULL,`VOLUME` int(11) DEFAULT NULL,PRIMARY KEY (`DATE`))  ENGINE=InnoDB DEFAULT CHARSET=latin1;',name);
            fetch(exec(obj.conn,exp));
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
            exp= sprintf('INSERT INTO `ABEV3.SA` (`DATE`, `OPEN`, `CLOSE`, `ADJCLOSE`, `HIGH`, `LOW`, `VOLUME`) VALUES (''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'');',num2str(date),num2str(open),num2str(close),num2str(adjclose),num2str(high),num2str(low),num2str(volume));
            rs=fetch(exec(obj.conn,exp));
            success=rs;
        end
        function success = deleteEntry(obj,name,date)
            exp= sprintf('DELETE FROM `%s` WHERE DATE = %s;',num2str(name),num2str(date));
            rs=fetch(exec(obj.conn,exp));
            success = rs;
        end
    end
end