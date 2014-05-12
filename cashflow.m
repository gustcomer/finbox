function cf = cashflow(values,ta)
    n = length(values);
    terms = zeros(1,n);
    for ii=1:n
        terms(ii) = values(ii)/(1+ta)^ii;
    end
    cf = sum(terms);
end