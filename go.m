%%
clear;
clc;

dbint = dbinterface('brasil');

%%
ibov = bovespastock(dbint,'HGTX3.SA','nmonths',24);
ibov.plot()

%%
ibov = bovespastock(dbint,'^BVSP','nmonths',24);
ibov.plot()

%%
ibov = bovespastock(dbint,'^BVSP','startday','May 18 12','endday','May 18 14');
ibov.plot()

%%
ibov = bovespastock(dbint,'^BVSP','nmonths',6);
ibov.plot()

%%
ibov = bovespastock(dbint,'^BVSP','nyears',6);
ibov.plot()

%%
bras = bovespastock(dbint,'BBAS3.SA','nmonths',24);
%%

%dbint = dbinterface('brasil');

%ciel = bovespastock(dbint,'CIEL3.SA','startday','Jan 1 12','endday','Apr 11 14');

dbint = dbinterface('brasil');
ibov = bovespastock(dbint,'^BVSP','startday','May 18 12','endday','May 18 14');
petr = bovespastock(dbint,'PETR4.SA','startday','Jan 1 12','endday','Apr 11 14');
embr = bovespastock(dbint,'EMBR3.SA','startday','Jan 1 12','endday','Apr 11 14');
oi = bovespastock(dbint,'OIBR4.SA','startday','Jan 1 12','endday','Apr 11 14');
vale = bovespastock(dbint,'VALE5.SA','startday','Jan 1 12','endday','Apr 11 14');