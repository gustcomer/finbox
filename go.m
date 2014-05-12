%%
clear all;
clc;

%%
di = 10;
first = 'Apr 30 13';
last = 'Apr 30 14';

rf = ((1+di/100)^(1/365)-1)*100;

%%
ibo = stock('^BVSP',first,last,rf);
petr = stock('PETR4.SA',first,last,rf,ibo);
embr = stock('EMBR3.SA',first,last,rf,ibo);
gren = stock('GRND3.SA',first,last,rf,ibo);