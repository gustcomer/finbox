function semivar = calculateSemivar(obj)
    semiret = obj.ret-obj.rmean;
    semiret(semiret>0)=0;
    semivar = sum(semiret.*semiret)/length(semiret);
end