function fa = getFundamentalHistory(obj)
    res = obj.dbint.getFundHistory(obj.ticker);
    fa.date = cell2mat(res(:,1));
    fa.at = cell2mat(res(:,2));
    fa.ac = cell2mat(res(:,3));
    fa.pc = cell2mat(res(:,4));
    fa.pl = cell2mat(res(:,5));
    fa.ll = cell2mat(res(:,6));
    fa.pt = fa.at;
    fa.anc = fa.at-fa.ac;
    fa.pnc = fa.pt-fa.pl-fa.pc;
end