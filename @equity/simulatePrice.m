function p = simulatePrice(obj,ret)
    nret = length(ret);
    p = [100; zeros(nret,1)];
    for count = 2:length(p)
        p(count) = p(count-1)*(1+ret(count-1)/100);
    end
end