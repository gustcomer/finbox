function obj = calculateReturns(obj)
    v = obj.price;
    obj.ret = 100*(v(2:end)-v(1:end-1))./v(1:end-1);
end