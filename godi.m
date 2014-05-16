date = textdata;
dates = datenum(date);

for i=1:length(dates)
    dbint.insertInterestEntry('di',dates(i),data(i));
end