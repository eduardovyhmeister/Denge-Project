
%convertir una columna de Ihs a CHs
A=getappdata(0,'SimResults2');
B=getappdata(0,'E');
B.Time=datenum(B.Time)
%ydata=cell2mat(table2cell(B));
%ydataest=cell2mat(table2cell(A));
ydata=B
Ydata=ydata
for i=2:size(B,1)
    Ydata{i,2}=ydata{i,2}+Ydata{i-1,2}
    
end

C=[B(:,1:2) A(:,4)]
figure
plot(D.Time,D.InfectCluster1)
hold on
plot(D.Time,D.Ih1)
hold off