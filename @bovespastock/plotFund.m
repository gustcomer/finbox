function obj = plotFund(obj)
    x = 1:length(obj.fund.date);
    p = plot(x,obj.fund.pl,x,obj.fund.ll,x,obj.fund.at,x,(obj.fund.pc+obj.fund.pnc));
    title(obj.ticker);
    set(p,'LineWidth',2)
    legend('Patrimonio Líquido','Lucro Líquido','Ativo Total','Passivo terceiros')
end