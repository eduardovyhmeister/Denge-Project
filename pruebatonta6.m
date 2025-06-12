%batch run simulation.
b1=findobj(gcf,'Tag','pushbutton47'); %Start simulation
b2=findobj(gcf,'Tag','radiob87'); %Constant Weather Variable
b3=findobj(gcf,'Tag','radiob88'); %Use Weather Matrix from beggining
b4=findobj(gcf,'Tag','edit25'); % Number of Clusters
b5=findobj(gcf,'Tag','edit119'); % Number of Weather Vaiables
b6=findobj(gcf,'Tag','radiob36'); %SEIR-SEI model
b7=findobj(gcf,'Tag','radiob37'); %SEIR-LSEI model
b8=findobj(gcf,'Tag','edit48'); %text temperature

T1=findobj(gcf,'Tag','uitable13'); %Q matrix SEIR-SEI
T2=findobj(gcf,'Tag','uitable10'); %Initial Conditions SEIR-SEI
T3=findobj(gcf,'Tag','uitable9'); %Parameters SEIR-SEI

T4=findobj(gcf,'Tag','uitable23'); %Q matrix SEIR-LSEI
T5=findobj(gcf,'Tag','uitable22'); %Initial Conditions SEIR-LSEI
T6=findobj(gcf,'Tag','uitable21'); %Parameters SEIR-LSEI


Data1=load('Cluster1.mat');
Data2=load('Cluster2.mat');
Data3=load('Cluster3_A.mat');
Data4=load('Cluster3_B.mat');



try
Data1=Data1.Data1;
catch
end

try
Data2=Data2.Data3;
catch
end

try
Data3=Data3.Data3;
catch
end

try
Data4=Data4.Data3;
catch
  Data4=Data4; 
end

Initial=load('Initial3.mat');
Initial2=load('Initial3_2.mat');
Params=load('Parameters_SEIR_SEI.mat');
%Params2=load('Parameters_SEIR_LSEI.mat');
Params2=load('Parameters_SEIR_LSEI_2.mat');

%%% modify the values of params for new runs considering other conditions.
for i=1:size(Params.Data5,2)
%Params.Data5{3,i}=0.165 %0.165; %was 0.033
if i~=1
Params2.Params2.Data6{16,i}=0.033
else
Params.Data5{3,i}=0.165  
end
end

for i=1:size(Params2.Params2.Data6,2)
if i~=1
Params2.Params2.Data6{16,i}=0.0033%0.033; %was 0.0033
else
Params2.Params2.Data6{16,i}=0.033    
end
end
% activation limits

for i=1:size(Params2.Params2.Data6,2)
Params2.Params2.Data6{20,i}=10; %was 298.15
Params2.Params2.Data6{22,i}=10;
Params2.Params2.Data6{24,i}=10;
end


%%%%%%%%%%%

Initial_LSEI_1=Initial.Initial.Data4(:,1:2);
Initial_LSEI_2=Initial.Initial.Data4(:,1:4);
Initial_LSEI_3=Initial.Initial.Data4(:,1:6);
Initial_SEI_1=Initial2.Data2(:,1:2);
Initial_SEI_2=Initial2.Data2(:,1:4);
Initial_SEI_3=Initial2.Data2(:,1:6);





params={};
RESULTS={};
SENSIBILIDADH={};
SENSIBILIDADV={};
RESULTS_2={};
SENSIBILIDADH_2={};
SENSIBILIDADV_2={};
set(b8,'String','310.51')
feval(get(b8,'Callback'),b8,[])

%%%%%%%% 1 cluster, SEIR-SEI T fijo %%%%%%%%%%%%%%%%%%
for i=2:(size(Params.Data5,1))+1
    set(b6,'Value',1) %Elegir modelo
    feval(get(b6,'Callback'),b6,[]) %realizo el callback the elegir el modelo

    set(b4,'String','1') %Elijo el numero de clusters
    feval(get(b4,'Callback'),b4,[]) %realizo el callback the elegir el numero de clusters

    set(b5,'String','1') %Elijo el numero de variables ambientales
    feval(get(b5,'Callback'),b5,[]) %realizo el callback the elegir el numero de variables ambientales
    if isempty(params)==1
    params=loadparams(1,1,Params.Data5,'SEI');
    end
    set(T1,'Data',Data1) %Fijo la matriz de cluste
    set(T2,'Data',Initial_SEI_1) %Fijo la matriz de valores inicialse
    set(T3,'Data',params) %Fijo la matriz de parametros

    feval(get(b1,'Callback'),b1,[]) %Inicio simulacion
    Results=getappdata(0,'SimResults2');
    %figure
    %plot(Results.TIME,Results.Ih1)
    RESULTS{end+1}=Results;
    setappdata(0,'RESULTS',RESULTS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%modifie the value of one of the variables at the same time.
    if i==2 
    params{i,1}=params{i,1}*1.1;
    SENSIBILIDADH{end+1}=Results.Ih1(end);
    SENSIBILIDADV{end+1}=Results.Iv1(end);
    elseif i~=2 && i<12
    params{i-1,1}=params{i-1,1}/1.1;    
    params{i,1}=params{i,1}*1.1;
    SENSIBILIDADH{end+1}=Results.Ih1(end);
    SENSIBILIDADV{end+1}=Results.Iv1(end);
    else
    SENSIBILIDADH{end+1}=Results.Ih1(end);
    SENSIBILIDADV{end+1}=Results.Iv1(end);
    end
i
end

%%%%%%%% 2 cluster, SEIR-SEI T fijo %%%%%%%%%%%%%%%%%%
set(b6,'Value',1) %Elegir modelo
feval(get(b6,'Callback'),b6,[]) %realizo el callback the elegir el modelo

set(b4,'String','2') %Elijo el numero de clusters
feval(get(b4,'Callback'),b4,[]) %realizo el callback the elegir el numero de clusters

set(b5,'String','1') %Elijo el numero de variables ambientales
feval(get(b5,'Callback'),b5,[]) %realizo el callback the elegir el numero de variables ambientales

params=loadparams(1,2,Params.Data5,'SEI');

set(T1,'Data',Data2) %Fijo la matriz con 1 solo cluster
set(T2,'Data',Initial_SEI_2) %Fijo la matriz de valores inicialse
set(T3,'Data',params) %Fijo la matriz de parametros

feval(get(b5,'Callback'),b5,[]) %realizo el callback the elegir el numero de variables ambientales
feval(get(b4,'Callback'),b4,[]) %realizo el callback the elegir el numero de clusters
feval(get(b1,'Callback'),b1,[]) %Inicio simulacion
Results=getappdata(0,'SimResults2');
RESULTS{end+1}=Results;
setappdata(0,'RESULTS',RESULTS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%% 3A cluster, SEIR-SEI T fijo %%%%%%%%%%%%%%%%%%
set(b6,'Value',1) %Elegir modelo
feval(get(b6,'Callback'),b6,[]) %realizo el callback the elegir el modelo

set(b4,'String','3') %Elijo el numero de clusters
feval(get(b4,'Callback'),b4,[]) %realizo el callback the elegir el numero de clusters

set(b5,'String','1') %Elijo el numero de variables ambientales
feval(get(b5,'Callback'),b5,[]) %realizo el callback the elegir el numero de variables ambientales

params=loadparams(1,3,Params.Data5,'SEI');







set(T1,'Data',Data3) %Fijo la matriz con 1 solo cluster
set(T2,'Data',Initial_SEI_3) %Fijo la matriz de valores inicialse
set(T3,'Data',params) %Fijo la matriz de parametros

feval(get(b1,'Callback'),b1,[]) %Inicio simulacion
Results=getappdata(0,'SimResults2');
RESULTS{end+1}=Results;
setappdata(0,'RESULTS',RESULTS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%% 3B cluster, SEIR-SEI T fijo %%%%%%%%%%%%%%%%%%
set(b6,'Value',1) %Elegir modelo
feval(get(b6,'Callback'),b6,[]) %realizo el callback the elegir el modelo

set(b4,'String','3') %Elijo el numero de clusters
feval(get(b4,'Callback'),b4,[]) %realizo el callback the elegir el numero de clusters

set(b5,'String','1') %Elijo el numero de variables ambientales
feval(get(b5,'Callback'),b5,[]) %realizo el callback the elegir el numero de variables ambientales

params=loadparams(1,3,Params.Data5,'SEI');

set(T1,'Data',Data4) %Fijo la matriz con 1 solo cluster
set(T2,'Data',Initial_SEI_3) %Fijo la matriz de valores inicialse
set(T3,'Data',params) %Fijo la matriz de parametros

feval(get(b1,'Callback'),b1,[]) %Inicio simulacion
Results=getappdata(0,'SimResults2');
RESULTS{end+1}=Results;
setappdata(0,'RESULTS',RESULTS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

params=[];
%%%%%%%% 1 cluster, SEIR-LSEI T fijo %%%%%%%%%%%%%%%%%%
for i=2:24+1

    set(b7,'Value',1) %Elegir modelo
    feval(get(b7,'Callback'),b7,[]) %realizo el callback the elegir el modelo
    
    if isempty(params)==1
    params=loadparams(1,1,Params2.Params2.Data6,'SEI');
    end     
    set(T6,'Data',params) %Fijo la matriz de parametros

    set(b4,'String','1') %Elijo el numero de clusters
    feval(get(b4,'Callback'),b4,[]) %realizo el callback the elegir el numero de clusters

    set(b5,'String','1') %Elijo el numero de variables ambientales
    feval(get(b5,'Callback'),b5,[]) %realizo el callback the elegir el numero de variables ambientales    
    
    set(T4,'Data',Data1) %Fijo la matriz con 1 solo cluster
    set(T5,'Data',Initial_LSEI_1) %Fijo la matriz de valores inicialse

    feval(get(b1,'Callback'),b1,[]) %Inicio simulacion
    Results=getappdata(0,'SimResults2');
    RESULTS_2{end+1}=Results;
    setappdata(0,'RESULTS_2',RESULTS_2)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %modifie the value of one of the variables at the same time.
    if i==2
    params{i,1}=params{i,1}*1.1;
    SENSIBILIDADH_2{end+1}=Results.Ih1(end);
    SENSIBILIDADV_2{end+1}=Results.Iv1(end);
    elseif i~=2 && i<size(Params2.Params2.Data6,1)+1
    params{i-1,1}=params{i-1,1}/1.1;    
    params{i,1}=params{i,1}*1.1;
    SENSIBILIDADH_2{end+1}=Results.Ih1(end);
    SENSIBILIDADV_2{end+1}=Results.Iv1(end);
    else 
    SENSIBILIDADH_2{end+1}=Results.Ih1(end);
    SENSIBILIDADV_2{end+1}=Results.Iv1(end);  
    end
   i
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%% 2 cluster, SEIR-LSEI T fijo %%%%%%%%%%%%%%%%%%
set(b7,'Value',1) %Elegir modelo
feval(get(b7,'Callback'),b7,[]) %realizo el callback the elegir el modelo
params=loadparams(1,2,Params2.Params2.Data6,'LSEI');
set(T6,'Data',params) %Fijo la matriz de parametros

set(b4,'String','2') %Elijo el numero de clusters
feval(get(b4,'Callback'),b4,[]) %realizo el callback the elegir el numero de clusters

set(b5,'String','1') %Elijo el numero de variables ambientales
feval(get(b5,'Callback'),b5,[]) %realizo el callback the elegir el numero de variables ambientales

set(T4,'Data',Data2) %Fijo la matriz con 2 solo cluster
set(T5,'Data',Initial_LSEI_2) %Fijo la matriz de valores inicialse

feval(get(b1,'Callback'),b1,[]) %Inicio simulacion
Results=getappdata(0,'SimResults2');
RESULTS_2{end+1}=Results;
setappdata(0,'RESULTS_2',RESULTS_2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% 3 cluster, SEIR-LSEI T fijo %%%%%%%%%%%%%%%%%%
set(b7,'Value',1) %Elegir modelo
feval(get(b7,'Callback'),b7,[]) %realizo el callback the elegir el modelo
params=loadparams(1,3,Params2.Params2.Data6,'LSEI');
set(T6,'Data',params) %Fijo la matriz de parametros

set(b4,'String','3') %Elijo el numero de clusters
feval(get(b4,'Callback'),b4,[]) %realizo el callback the elegir el numero de clusters

set(b5,'String','1') %Elijo el numero de variables ambientales
feval(get(b5,'Callback'),b5,[]) %realizo el callback the elegir el numero de variables ambientales

set(T4,'Data',Data3) %Fijo la matriz con 1 solo cluster
set(T5,'Data',Initial_LSEI_3) %Fijo la matriz de valores inicialse

feval(get(b1,'Callback'),b1,[]) %Inicio simulacion
Results=getappdata(0,'SimResults2');
RESULTS_2{end+1}=Results;
setappdata(0,'RESULTS_2',RESULTS_2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% 3 cluster, SEIR-LSEI T fijo %%%%%%%%%%%%%%%%%%
set(b7,'Value',1) %Elegir modelo
feval(get(b7,'Callback'),b7,[]) %realizo el callback the elegir el modelo
params=loadparams(1,3,Params2.Params2.Data6,'LSEI');
set(T6,'Data',params) %Fijo la matriz de parametros

set(b4,'String','3') %Elijo el numero de clusters
feval(get(b4,'Callback'),b4,[]) %realizo el callback the elegir el numero de clusters

set(b5,'String','1') %Elijo el numero de variables ambientales
feval(get(b5,'Callback'),b5,[]) %realizo el callback the elegir el numero de variables ambientales

set(T4,'Data',Data4) %Fijo la matriz con 1 solo cluster
set(T5,'Data',Initial_LSEI_3) %Fijo la matriz de valores inicialse

feval(get(b1,'Callback'),b1,[]) %Inicio simulacion
Results=getappdata(0,'SimResults2');
RESULTS_2{end+1}=Results;
setappdata(0,'RESULTS_2',RESULTS_2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%analisis de sensibilidad
RESSENSIBILIDADH={};
RESSENSIBILIDADV={};
RESSENSIBILIDADH_2={};
RESSENSIBILIDADV_2={};
for L=1:11
    RESSENSIBILIDADH{end+1} = (SENSIBILIDADH{L}-SENSIBILIDADH{1})*100/SENSIBILIDADH{1};
    RESSENSIBILIDADV{end+1} = (SENSIBILIDADV{L}-SENSIBILIDADV{1})*100/SENSIBILIDADV{1};
end

for L=1:24
    RESSENSIBILIDADH_2{end+1}=(SENSIBILIDADH_2{L}-SENSIBILIDADH_2{1})*100/SENSIBILIDADH_2{1};
    RESSENSIBILIDADV_2{end+1}=(SENSIBILIDADV_2{L}-SENSIBILIDADV_2{1})*100/SENSIBILIDADV_2{1};
end


for i=1:length(RESULTS)  
    cell=RESULTS{i};
    filename=strcat('Ressults_1_',num2str(i),'.xlsx');
    writetable(cell,filename)
end

for i=1:length(RESULTS_2)
    cell=RESULTS_2{i};
    filename=strcat('Ressults_2_',num2str(i),'.xlsx');
    writetable(cell,filename)
end


%%%%%%%%%%%%%%%%%%%%%%%%%

function paramsoutput=loadparams(nenv,nclus,Params,txt)
if strcmp(txt,'SEI')==1
paramsoutput=Params(:,1:2*nclus);  
else
paramsoutput=Params(1:(18+6*nenv),1:2*nclus);
end
end
