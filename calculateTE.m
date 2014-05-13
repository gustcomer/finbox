function te = calculateTE(obj,comp)
    [compindexon,~] = ismember(comp.date,obj.date);
    [objectindexon,~] = ismember(obj.date,comp.date);
    te = sqrt(cov(obj.ret(objectindexon(2:end))-comp.ret(compindexon(2:end)),1));
end