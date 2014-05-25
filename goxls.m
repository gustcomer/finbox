clear;
clc;

dbint = dbinterface('brasil','brasil-fundam');

acoes = {'BBAS3','EMBR3','HGTX3','PETR4'};

for i=1:length(acoes)
    ticker = acoes{i};
    fail = 0;
    try
    [NUM,TXT,RAW]=xlsread(sprintf('/Users/gustcomer/Documents/devel/finbox/data/%s.xls',ticker));
    date
    posAT = find(ismember(TXT,'Ativo Total'))-2;
    posAC = find(ismember(TXT,'Ativo Circulante'))-2;
    posPC = find(ismember(TXT,'Passivo Circulante'))-2;
    posPL = find(ismember(TXT,'Patrimonio Liquido'))-2;
    
    ndates = size(TXT,2)-1;
    
    [NUMDRE,TXTDRE,RAWDRE]=xlsread(sprintf('/Users/gustcomer/Documents/devel/finbox/data/%s.xls',ticker),'Dem. Result.');
    posLL = find(ismember(TXTDRE,'Lucro Liquido'))-1;
    catch err
        fail=1;
        fprintf('%s: BAD\n',ticker);
    end
    
    if fail==0
        fprintf('%s: GOOD\n',ticker);
        
        if ~dbint.isThereFund([ticker,'.SA'])
            dbint.createFundTable([ticker,'.SA']);
        end

        for j=1:ndates
            datestr = TXT{2,j+1};
            year = str2num(datestr(7:10));
            trim = str2num(datestr(4:5))/3;
            
            at = int64(NUM(posAT,j));
            ac = int64(NUM(posAC,j));
            pc = int64(NUM(posPC,j));
            pl = int64(NUM(posPL,j));
            ll = int64(NUMDRE(end,j));
            
            dbint.insertFundEntry([ticker,'.SA'],trim,year,at,ac,pc,pl,ll);
        end
    end
end

