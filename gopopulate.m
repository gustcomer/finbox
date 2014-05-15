clear;
clc;

dbint = dbinterface('brasil');


first = 'Jan 01 07';
last = 'May 14 14';

%acoes = {'ABEV3.SA','AEDU3.SA','ALLL3.SA','BBAS3.SA','BBDC3.SA','BBDC4.SA','BBSE3.SA','BISA3.SA','BRAP4.SA','BRFS3.SA','BRKM5.SA','BRML3.SA','BRPR3.SA','BVMF3.SA','CCRO3.SA','CESP6.SA','CIEL3.SA','CMIG4.SA','CPFE3.SA','CPLE6.SA','CRUZ3.SA','CSAN3.SA','CSNA3.SA','CTIP3.SA','CYRE3.SA','DTEX3.SA','ECOR3.SA','ELET3.SA','ELET6.SA','ELPL4.SA','EMBR3.SA','ENBR3.SA','ESTC3.SA','EVEN3.SA','FIBR3.SA','GFSA3.SA','GGBR4.SA','GOAU4.SA','GOLL4.SA','HGTX3.SA','HYPE3.SA','ITSA4.SA','ITUB4.SA','JBSS3.SA','KLBN11.SA','KROT3.SA','LAME4.SA','LIGT3.SA','LREN3.SA','MMXM3.SA','MRFG3.SA','MRVE3.SA','NATU3.SA','OIBR4.SA','PCAR4.SA','PDGR3.SA','PETR3.SA','PETR4.SA','QUAL3.SA','RENT3.SA','RSID3.SA','SANB11.SA','SBSP3.SA','SUZB5.SA','TBLE3.SA','TIMP3.SA','UGPA3.SA','USIM5.SA','VALE3.SA','VALE5.SA','VIVT4.SA'};
acoes = {'ABEV3.SA','CIEL3.SA','ELET3.SA','EMBR3.SA','GGBR4.SA','HGTX3.SA','PETR4.SA','OIBR4.SA','VALE5.SA'};

con = yahoo;

for i=1:length(acoes)
    ticker = acoes{i};
    fail = 0;
    try
    data = fetch(con, ticker, {'Open','Close','Adj Close','High','Low','Volume'},first,last);
    catch err
        fail=1;
        fprintf('%s: BAD\n',ticker);
    end
    if fail==0
        fprintf('%s: GOOD\n',ticker);
        dbint.createTable(ticker);
        for j=1:size(data,1)
            dbint.insertEntry(ticker,'date',data(j,1),'open',data(j,2),'close',data(j,3),'adjclose',data(j,4),'high',data(j,5),'low',data(j,6),'volume',data(j,7));
        end
    end
end