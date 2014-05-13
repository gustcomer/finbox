function [hastr,pos] = findstringcell(x,str)
    hastr = false;
    pos = [];
    for i=1:length(x)
        if isequal(x{i},str)
            hastr = true;
            pos = [pos i];
        end  
    end
end