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
%         function [hist_date, hist_high, hist_low, hist_open, hist_close, hist_vol] = get_hist_google_stock_data(stock_symbol)
% 
% 
%             % Define starting year (the further back in time, the longer it takes to download)
%             start_year = '2000';
% 
% 
%             % Get current date
%             [this_year, this_month, this_day, dummy, dummy] = datevec(date);
% 
% 
%             % Build URL string
%             url_string = 'http://www.google.com/finance/historical?q=';
%             url_string = strcat(url_string, upper(stock_symbol), '&output=csv');
% 
% 
%             % Open a connection to the URL and retrieve data into a buffer
%             buffer      = java.io.BufferedReader(...
%                           java.io.InputStreamReader(...
%                           openStream(...
%                           java.net.URL(url_string))));
% 
% 
%             % Read the first line (a header) and discard
%             dummy   = readLine(buffer);
% 
% 
%             % Read all remaining lines in buffer
%             ptr = 1;
%             while 1
%                 % Read line
%                 buff_line = char(readLine(buffer)); 
% 
%                 % Break if this is the end
%                 if length(buff_line)<3, break; end
% 
%                 % Find comma delimiter locations
%                 commas    = find(buff_line== ',');
% 
%                 % Extract high, low, open, close, etc. from string
%                 DATEtemp{ptr,1} = buff_line(1:commas(1)-1);
%                 OPENtemp(ptr,1)   = str2num( buff_line(commas(1)+1:commas(2)-1) );
%                 HIGHtemp(ptr,1)   = str2num( buff_line(commas(2)+1:commas(3)-1) );
%                 LOWtemp (ptr,1)    = str2num( buff_line(commas(3)+1:commas(4)-1) );
%                 CLOSEtemp(ptr,1)  = str2num( buff_line(commas(4)+1:commas(5)-1) );
%                 VOLtemp(ptr,1)    = str2num( buff_line(commas(5)+1:end) );
% 
%                 ptr = ptr + 1;
%             end
% 
%             % Reverse to normal chronological order, so 1st entry is oldest data point
%             hist_date  = flipud(DATEtemp);
%             hist_open  = flipud(OPENtemp);
%             hist_high  = flipud(HIGHtemp);
%             hist_low   = flipud(LOWtemp);
%             hist_close = flipud(CLOSEtemp);
%             hist_vol   = flipud(VOLtemp);
%         end
    end
end