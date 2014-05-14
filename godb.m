%%
clear;
clc;

dbint = dbinterface('brasil');
tables = dbint.getTables();

%%

dbint.insertEntry('brasil','date',15,'open',2,'close',5,'adjclose',4,'high',7,'low',-3,'volume',100);
dbint.deleteEntry('ABEV3',13)