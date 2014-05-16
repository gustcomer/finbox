%%
clear;
clc;

dbint = dbinterface('brasil');

ciel = bovespastock(dbint,'CIEL3.SA','startday','Jan 1 12','endday','Apr 11 14');

dbint = dbinterface('brasil');
petr = bovespastock(dbint,'PETR4.SA','startday','Jan 1 12','endday','Apr 11 14');
embr = bovespastock(dbint,'EMBR3.SA','startday','Jan 1 12','endday','Apr 11 14');
oi = bovespastock(dbint,'OIBR4.SA','startday','Jan 1 12','endday','Apr 11 14');
vale = bovespastock(dbint,'VALE5.SA','startday','Jan 1 12','endday','Apr 11 14');