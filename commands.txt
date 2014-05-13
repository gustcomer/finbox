%%
clear;
clc;

%% Test Equities
equity0 = equity([100;101;105;106;107]);
equity1 = equity([2; -1.4; 0.5; 1],'returns');
equity2 = equity([100;101;105;106;107],'dates',[2;4;7;8;9]);
equity3 = equity([1; -0.8; 0; 0.7],'returns','dates',[3;6;7;8;9]);
marketequity = equity([1; -0.8; 0; 0.7],'returns');

%% Test stocks
stock1 = stock([2; -1.4; 0.5; 1],'returns');

stock0 = stock([100;101;105;106;107]);
stock2 = stock([2; -1.4; 0.5; 1],'returns','rf',0.1);

%% resolucao exercicio
market = stock([1; -0.8; 0; 0.7],'returns','rf',0.1,'ismarket');
ativo = stock([2; -1.4; 0.5; 1],'returns','rf',0.1,'market',market);

%% testes extras
ativoincompleto = stock([2; -1.4; 0.5],'returns','dates',[1;2;3;4],'rf',0.1,'market',market);