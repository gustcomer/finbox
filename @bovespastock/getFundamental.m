function fa = getFundamental(obj,varargin)
    year = varargin{1};
    trim = varargin{2};
    res = obj.dbint.getFundEntry(obj.ticker,year,trim);
    fa.date = res{1};
    fa.at = res{2};
    fa.ac = res{3};
    fa.pc = res{4};
    fa.pl = res{5};
    fa.ll = res{6};
    fa.pt = fa.at;
    fa.anc = fa.at-fa.ac;
    fa.pnc = fa.pt-fa.pl;
end