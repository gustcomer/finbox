%%
clear;
clc;

dbint = dbinterface('brasil','brasil-fundam');
ibov = bovespastock(dbint,'^BVSP','nyears',1);
petr = bovespastock(dbint,'PETR4.SA','nyears',1);
embr = bovespastock(dbint,'EMBR3.SA','nyears',1);
oi = bovespastock(dbint,'OIBR4.SA','nyears',1);
vale = bovespastock(dbint,'VALE5.SA','nyears',1);
ciel = bovespastock(dbint,'CIEL3.SA','nyears',1);
bb = bovespastock(dbint,'BBAS3.SA','nyears',1);
% ibov = bovespastock(dbint,'^BVSP','startday','May 18 12','endday','May 18 14');
% petr = bovespastock(dbint,'PETR4.SA','startday','Jan 1 12','endday','Apr 11 14');
% embr = bovespastock(dbint,'EMBR3.SA','startday','Jan 1 12','endday','Apr 11 14');
% oi = bovespastock(dbint,'OIBR4.SA','startday','Jan 1 12','endday','Apr 11 14');
% vale = bovespastock(dbint,'VALE5.SA','startday','Jan 1 12','endday','Apr 11 14');

%%
%ibov = bovespastock(dbint,'HGTX3.SA','nmonths',12);

%%
%ibov = bovespastock(dbint,'^BVSP','nmonths',24);
%ibov = bovespastock(dbint,'^BVSP','startday','May 18 12','endday','May 18 14');
%ibov = bovespastock(dbint,'^BVSP','nmonths',6);
%ibov = bovespastock(dbint,'^BVSP','nyears',6);

%%
%bras = bovespastock(dbint,'BBAS3.SA','nmonths',24);
%%

%dbint = dbinterface('brasil');

%ciel = bovespastock(dbint,'CIEL3.SA','startday','Jan 1 12','endday','Apr 11 14');

% dbint = dbinterface('brasil');
% ibov = bovespastock(dbint,'^BVSP','startday','May 18 12','endday','May 18 14');
% petr = bovespastock(dbint,'PETR4.SA','startday','Jan 1 12','endday','Apr 11 14');
% embr = bovespastock(dbint,'EMBR3.SA','startday','Jan 1 12','endday','Apr 11 14');
% oi = bovespastock(dbint,'OIBR4.SA','startday','Jan 1 12','endday','Apr 11 14');
% vale = bovespastock(dbint,'VALE5.SA','startday','Jan 1 12','endday','Apr 11 14');