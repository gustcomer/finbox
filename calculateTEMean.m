function temean = calculateTEMean(obj,comp)
    [compindexon,~] = ismember(comp.date,obj.date);
    [objectindexon,~] = ismember(obj.date,comp.date);
    temean = mean(obj.ret(objectindexon(2:end))-comp.ret(compindexon(2:end)));
end