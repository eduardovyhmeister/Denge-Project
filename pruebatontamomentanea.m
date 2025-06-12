%batch run
b1=findobj(gcf,'Tag','pushbutton148') %joint forcast
b2=findobj(gcf,'Tag','radiobNoFiltering') %ODEs
b3=findobj(gcf,'Tag','radiobEKF') %Extended Kalman Filter
b4=findobj(gcf,'Tag','radiobPF') % Particle Filtering
b5=findobj(gcf,'Tag','radiobInfectedHost') % boton infected
b6=findobj(gcf,'Tag','pushb132') %create Filter EKF
b7=findobj(gcf,'Tag','pushb138') %creafe filter PF
b8=findobj(gcf,'Tag','pushb149') %MSE resultado
b9=findobj(gcf,'Tag','radiob87') %Selecccionar temperatura fija al valor dado
b10=findobj(gcf,'Tag','radiob88') %usar matriz de temperatura cargada
b11=findobj(gcf,'Tag','radiob36') %Seleccionar SEIR-SEI
b12=findobj(gcf,'Tag','radiob37') %Deterministic Seleccionar SERI-LSEI
b13=findobj(gcf,'Tag','pushb50')  %load
b14=findobj(gcf,'Tag','pushbutton146')% remove last forecast
Ch1=findobj(gcf,'Tag','checkbox28') %checkbox optimizacion en ada iteracion EKF
Ch2=findobj(gcf,'Tag','checkbox29') %checkbox con optimizacion en cada iteracion PF
Ch3=findobj(gcf,'Tag','checkbox11') %con optimizacion ODEs
p1=findobj(gcf,'Tag','popupmForecastingDays') %popup forecasting days
p2=findobj(gcf,'Tag','popupm28') %forecasting initial day
E1=findobj(gcf,'Tag','editBackwardDays') %backward days
E2=findobj(gcf,'Tag','edit48') %Temperatura
E3=findobj(gcf,'Tag','edit115') %numerode joint forecast
M1=findobj(gcf,'Tag','uitable10') %tabla initialv SERI-SEI
M2=findobj(gcf,'Tag','uitable22') %tabla initialv SEIR -LSEI
M3=findobj(gcf,'Tag','uitable9') %tabla initialv SEIR -LSEI
M4=findobj(gcf,'Tag','uitable21') %tabla paraemtros SEIR -LSEI


RESULTS={};
MSE={};
TIME={};
set(E2,'String','300.51')
feval(get(E2,'Callback'),E2,[])
setappdata(0,'RESULTS',[])
setappdata(0,'MSE',[])
setappdata(0,'ITERACION',[])



%%%%%%%%%%%% 1 %$%%%%%%%%%%%
%%%%%%%%%%%%%%% mod3 1 day forecast 5 EKF %%%%%%%%%%%%%%
%1 cargo matriz
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.

%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
C=get(M3,'Data');
D=get(M4,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end

for i=5:size(C,1)
C{i,2}=0;
end

for i=3:size(D,1)
D{i,2}=0;
end

set(M1,'Data',A)
set(M2,'Data',B)
set(M3,'Data',C)
set(M4,'Data',D)
%3 fijo la temperatura correspondiente
%set(b9,'Value',1) %Fija
%feval(get(b9,'Callback'),b9,[])
set(b10,'Value',1) %cargada
feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=1; %forecasting days
backward='5';
forecastingIni=2986; %dia inicial para forecasting
veces='90'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)


tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.

%    set(b2,'Value',1) %ODE
 %   set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

   set(b3,'Value',1) %EKF
   feval(get(b6,'Callback'),b6,[]) %creo el filtro
    set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

 %  set(b4,'Value',1)%PF
 %   feval(get(b7,'Callback'),b7,[]) %creo el filtro
 %   set(Ch2,'Value',1) %con optimizacoin en cada forecast
%    set(Ch2,'Value',0) %sin optimizacoin en cada forecast

%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=37; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',time)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%

%%%%%%%%%%%%%%%% 2 %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% sin optim mOD1_PF_ 7DAY 7 DAY BACK %%%%%%%%%%%%%%
%1 cargo matriz
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.

%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end
set(M1,'Data',A)
set(M2,'Data',B)
%3 fijo la temperatura correspondiente
set(b9,'Value',1) %Fija
feval(get(b9,'Callback'),b9,[])
%set(b10,'Value',1) %cargada
%feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=7; %forecasting days
backward='7';
forecastingIni=2986;
veces='14'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)

tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.
%set(b2,'Value',1) %ODE
%    set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

%set(b3,'Value',1) %EKF
 %   feval(get(b6,'Callback'),b6,[]) %creo el filtro
 %   set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

set(b4,'Value',1)%PF
    feval(get(b7,'Callback'),b7,[]) %creo el filtro
%    set(Ch2,'Value',1) %con optimizacoin en cada forecast
    set(Ch2,'Value',0) %sin optimizacoin en cada forecast



%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=5; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% sin optim mod2_PF_ 7DAY 5 DAY BACK %%%%%%%%%%%%%%
%1 cargo matriz
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.

%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end
set(M1,'Data',A)
set(M2,'Data',B)
%3 fijo la temperatura correspondiente
%set(b9,'Value',1) %Fija
%feval(get(b9,'Callback'),b9,[])
set(b10,'Value',1) %cargada
feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=7; %forecasting days
backward='7';
forecastingIni=2986;
veces='14'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)

tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.
%set(b2,'Value',1) %ODE
%    set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

%set(b3,'Value',1) %EKF
%    feval(get(b6,'Callback'),b6,[]) %creo el filtro
%    set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

set(b4,'Value',1)%PF
    feval(get(b7,'Callback'),b7,[]) %creo el filtro
%    set(Ch2,'Value',1) %con optimizacoin en cada forecast
    set(Ch2,'Value',0) %sin optimizacoin en cada forecast



%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=6; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%% 4 %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% sin optim CLASSIC1_PF_ 7DAY 7 DAY BACK %%%%%%%%%%%%%%
%1 cargo matriz
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.

%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end
set(M1,'Data',A)
set(M2,'Data',B)
%3 fijo la temperatura correspondiente
set(b9,'Value',1) %Fija
feval(get(b9,'Callback'),b9,[])
%set(b10,'Value',1) %cargada
%feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=7; %forecasting days
backward='7';
forecastingIni=2986;
veces='14'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)

tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.
%set(b2,'Value',1) %ODE
%    set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

%set(b3,'Value',1) %EKF
%    feval(get(b6,'Callback'),b6,[]) %creo el filtro
%    set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

set(b4,'Value',1)%PF
    feval(get(b7,'Callback'),b7,[]) %creo el filtro
%    set(Ch2,'Value',1) %con optimizacoin en cada forecast
    set(Ch2,'Value',0) %sin optimizacoin en cada forecast


%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=7; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%% 5 %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% sin optim CLASSIC1_PF_ 7DAY 5 DAY BACK %%%%%%%%%%%%%%
%1 cargo matriz
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.

%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end
set(M1,'Data',A)
set(M2,'Data',B)
%3 fijo la temperatura correspondiente
set(b9,'Value',1) %Fija
feval(get(b9,'Callback'),b9,[])
%set(b10,'Value',1) %cargada
%feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=7; %forecasting days
backward='7';
forecastingIni=2986;
veces='14'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)

tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.
%set(b2,'Value',1) %ODE
%    set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

%set(b3,'Value',1) %EKF
%    feval(get(b6,'Callback'),b6,[]) %creo el filtro
%    set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

set(b4,'Value',1)%PF
    feval(get(b7,'Callback'),b7,[]) %creo el filtro
%    set(Ch2,'Value',1) %con optimizacoin en cada forecast
    set(Ch2,'Value',0) %sin optimizacoin en cada forecast


%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=7; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%% 6 %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%  sin optim cLASSIC2_PF_ 1week 7 DAY BACK %%%%%%%%%%%%%%
%1 cargo matriz
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.

%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end
set(M1,'Data',A)
set(M2,'Data',B)
%3 fijo la temperatura correspondiente
%set(b9,'Value',1) %Fija
%feval(get(b9,'Callback'),b9,[])
set(b10,'Value',1) %cargada
feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=7; %forecasting days
backward='7';
forecastingIni=2986;
veces='14'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)

tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.
%set(b2,'Value',1) %ODE
%    set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

%set(b3,'Value',1) %EKF
%    feval(get(b6,'Callback'),b6,[]) %creo el filtro
%    set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

set(b4,'Value',1)%PF
    feval(get(b7,'Callback'),b7,[]) %creo el filtro
 %   set(Ch2,'Value',1) %con optimizacoin en cada forecast
    set(Ch2,'Value',0) %sin optimizacoin en cada forecast



%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=8; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%% 7 &&&&&&&&&&&&&&&&&&&&&&
%%%%%%%%%%%%%%%  sin optim mod3_PF_ 1week 5 DAY BACK %%%%%%%%%%%%%%
%1 cargo matriz
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.

%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end
set(M1,'Data',A)
set(M2,'Data',B)
%3 fijo la temperatura correspondiente
%set(b9,'Value',1) %Fija
%feval(get(b9,'Callback'),b9,[])
set(b10,'Value',1) %cargada
feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=7; %forecasting days
backward='7';
forecastingIni=2986;
veces='14'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)

tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.
%set(b2,'Value',1) %ODE
%    set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

%set(b3,'Value',1) %EKF
%    feval(get(b6,'Callback'),b6,[]) %creo el filtro
%    set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

set(b4,'Value',1)%PF
    feval(get(b7,'Callback'),b7,[]) %creo el filtro
 %   set(Ch2,'Value',1) %con optimizacoin en cada forecast
    set(Ch2,'Value',0) %sin optimizacoin en cada forecast



%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=8; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%% 8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% mod3 7 day forecast 7 day backward PF no opt %%%%%%%%%%%%%%
%1 cargo matriz
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.

%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
C=get(M3,'Data');
D=get(M4,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end

for i=5:size(C,1)
C{i,2}=0;
end

for i=3:size(D,1)
D{i,2}=0;
end

set(M1,'Data',A)
set(M2,'Data',B)
set(M3,'Data',C)
set(M4,'Data',D)
%3 fijo la temperatura correspondiente
%set(b9,'Value',1) %Fija
%feval(get(b9,'Callback'),b9,[])
set(b10,'Value',1) %cargada
feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=7; %forecasting days
backward='7';
forecastingIni=2986; %dia inicial para forecasting
veces='14'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)


tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.

%    set(b2,'Value',1) %ODE
 %   set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

%   set(b3,'Value',1) %EKF
%   feval(get(b6,'Callback'),b6,[]) %creo el filtro
%    set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

   set(b4,'Value',1)%PF
    feval(get(b7,'Callback'),b7,[]) %creo el filtro
%    set(Ch2,'Value',1) %con optimizacoin en cada forecast
    set(Ch2,'Value',0) %sin optimizacoin en cada forecast

%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=37; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%% 9 %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  %%%%%%%%%%%%%%
%1 cargo matriz
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.

%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end
set(M1,'Data',A)
set(M2,'Data',B)
%3 fijo la temperatura correspondiente
set(b9,'Value',1) %Fija
feval(get(b9,'Callback'),b9,[])
%set(b10,'Value',1) %cargada
%feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=7; %forecasting days
backward='7';
forecastingIni=2986; %dia inicial para forecasting
veces='14'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)


tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.

    set(b2,'Value',1) %ODE
    set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

%   set(b3,'Value',1) %EKF
%   feval(get(b6,'Callback'),b6,[]) %creo el filtro
%    set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

%   set(b4,'Value',1)%PF
%    feval(get(b7,'Callback'),b7,[]) %creo el filtro
%    set(Ch2,'Value',1) %con optimizacoin en cada forecast
%    set(Ch2,'Value',0) %sin optimizacoin en cada forecast

%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=25; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%% 10 %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% mod3 1 day forecast 5 day backward with opt %%%%%%%%%%%%%%
%1 cargo matriz
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.

%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
C=get(M3,'Data');
D=get(M4,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end

for i=5:size(C,1)
C{i,2}=0;
end

for i=3:size(D,1)
D{i,2}=0;
end

set(M1,'Data',A)
set(M2,'Data',B)
set(M3,'Data',C)
set(M4,'Data',D)
%3 fijo la temperatura correspondiente
%set(b9,'Value',1) %Fija
%feval(get(b9,'Callback'),b9,[])
set(b10,'Value',1) %cargada
feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=1; %forecasting days
backward='5';
forecastingIni=2986; %dia inicial para forecasting
veces='90'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)


tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.

    set(b2,'Value',1) %ODE
    set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

%   set(b3,'Value',1) %EKF
%   feval(get(b6,'Callback'),b6,[]) %creo el filtro
%    set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

%   set(b4,'Value',1)%PF
%    feval(get(b7,'Callback'),b7,[]) %creo el filtro
%    set(Ch2,'Value',1) %con optimizacoin en cada forecast
%    set(Ch2,'Value',0) %sin optimizacoin en cada forecast

%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=37; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%% MOD3 - EKF 
%%%%%%%%%%%%%%% mod3_EKF_1 day forecast 5 day backward with opt %%%%%%%%%%%%%%
%1 cargo matriz
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.


%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
C=get(M3,'Data');
D=get(M4,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end

for i=5:size(C,1)
C{i,2}=0;
end

for i=3:size(D,1)
D{i,2}=0;
end

set(M1,'Data',A)
set(M2,'Data',B)
set(M3,'Data',C)
set(M4,'Data',D)
%3 fijo la temperatura correspondiente
%set(b9,'Value',1) %Fija
%feval(get(b9,'Callback'),b9,[])
set(b10,'Value',1) %cargada
feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=1; %forecasting days
backward='5';
forecastingIni=2986; %dia inicial para forecasting
veces='90'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)


tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.

%    set(b2,'Value',1) %ODE
%   set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

   set(b3,'Value',1) %EKF
   feval(get(b6,'Callback'),b6,[]) %creo el filtro
    set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

%   set(b4,'Value',1)%PF
%    feval(get(b7,'Callback'),b7,[]) %creo el filtro
%    set(Ch2,'Value',1) %con optimizacoin en cada forecast
%    set(Ch2,'Value',0) %sin optimizacoin en cada forecast

%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=38; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%% 12 %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% mod3_EKF day forecast 5 day backward sin opt %%%%%%%%%%%%%%
%1 cargo matriz
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.


%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
C=get(M3,'Data');
D=get(M4,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end

for i=5:size(C,1)
C{i,2}=0;
end

for i=3:size(D,1)
D{i,2}=0;
end

set(M1,'Data',A)
set(M2,'Data',B)
set(M3,'Data',C)
set(M4,'Data',D)
%3 fijo la temperatura correspondiente
%set(b9,'Value',1) %Fija
%feval(get(b9,'Callback'),b9,[])
set(b10,'Value',1) %cargada
feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=1; %forecasting days
backward='5';
forecastingIni=2986; %dia inicial para forecasting
veces='90'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)


tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.

%    set(b2,'Value',1) %ODE
%    set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

   set(b3,'Value',1) %EKF
  feval(get(b6,'Callback'),b6,[]) %creo el filtro
%    set(Ch1,'Value',1) %con optimizacoin en cada forecast
    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

%   set(b4,'Value',1)%PF
%    feval(get(b7,'Callback'),b7,[]) %creo el filtro
%    set(Ch2,'Value',1) %con optimizacoin en cada forecast
%    set(Ch2,'Value',0) %sin optimizacoin en cada forecast

%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=39; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%% 13 %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% mod3 PF 1 day forecast 10 day backward with opt %%%%%%%%%%%%%%
%1 cargo matriz
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,1,guidata(hObject)),b13,[]) %cargo matriz 1.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,2,guidata(hObject)),b13,[]) %cargo matriz 2.
feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,3,guidata(hObject)),b13,[]) %cargo matriz 3.
%feval(@(hObject,eventdata)IngresoDatos('pushb50_Callback',hObject,4,guidata(hObject)),b13,[]) %cargo matriz 4.

%2 dejo todo unfixed.
A=get(M1,'Data');
B=get(M2,'Data');
C=get(M3,'Data');
D=get(M4,'Data');
for i=1:size(A,1)
A{i,2}=0;    
end
for i=1:size(B,1)
B{i,2}=0;   
end

for i=5:size(C,1)
C{i,2}=0;
end

for i=3:size(D,1)
D{i,2}=0;
end

set(M1,'Data',A)
set(M2,'Data',B)
set(M3,'Data',C)
set(M4,'Data',D)
%3 fijo la temperatura correspondiente
%set(b9,'Value',1) %Fija
%feval(get(b9,'Callback'),b9,[])
set(b10,'Value',1) %cargada
feval(get(b10,'Callback'),b10,[])

%4 seteo que es infected
set(b5,'Value',1)

%5 selecciono numero de forecasting days,backward days i forecasting initial
dias=1; %forecasting days
backward='10';
forecastingIni=2986; %dia inicial para forecasting
veces='90'; %cuantos dias consecutivos
set(p1,'Value',dias)
set(E1,'String',backward)
set(p2,'Value',forecastingIni)
set(E3,'String',veces)


tic
%6 selecciono metodo y sus parametros 1. ode 2. ekf 3. pf.

    set(b2,'Value',1) %ODE
    set(Ch3,'Value',1) %con optimizacion
%    set(Ch3,'Value',0) %sin optimizacion

%   set(b3,'Value',1) %EKF
%   feval(get(b6,'Callback'),b6,[]) %creo el filtro
%    set(Ch1,'Value',1) %con optimizacoin en cada forecast
%    set(Ch1,'Value',0) %sin optimizacoin en cada forecast

%   set(b4,'Value',1)%PF
%    feval(get(b7,'Callback'),b7,[]) %creo el filtro
%    set(Ch2,'Value',1) %con optimizacoin en cada forecast
%    set(Ch2,'Value',0) %sin optimizacoin en cada forecast

%7 Correr y eliminar las forecast
feval(get(b1,'Callback'),b1,[])
time=toc;
F=getappdata(0,'F');
MSEnew=get(b8,'String');
RESULTS{end+1}=F;
MSE{end+1}=MSEnew;
TIME{end+1}=time;
feval(get(b14,'Callback'),b14,[])
ITERACION=37; %saber si hay un error hasta donde llegue
setappdata(0,'RESULTS',RESULTS)
setappdata(0,'MSE',MSE)
setappdata(0,'ITERACION',ITERACION)
setappdata(0,'TIME',TIME)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
