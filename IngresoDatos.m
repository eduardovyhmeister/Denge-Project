%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.

function varargout = IngresoDatos(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IngresoDatos_OpeningFcn, ...
                   'gui_OutputFcn',  @IngresoDatos_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

function IngresoDatos_OpeningFcn(hObject,~, handles, varargin)
clc
jFrame=get(handle(handles.figure1),'javaframe'); %this three lines changes the logo
jicon=javax.swing.ImageIcon('gifmosquito.gif');
jFrame.setFigureIcon(jicon);
setappdata(0,'nclusters','1');
set(handles.uipanel1,'visible','off');
set(handles.uipanel2,'visible','off');
set(handles.uipanel3,'visible','off')
set(handles.uipanel4,'visible','off')
set(handles.uipanel5,'visible','off')
set(handles.uipanelxx,'visible','off')
set(handles.uipanel75,'visible','off')
set(handles.uipanel33,'visible','off')
set(handles.uipanel79,'visible','off')
set(handles.uipanel80,'visible','off')
set(handles.uipanel81,'visible','off')
set(handles.uipanel82,'visible','off')
set(handles.pushb1,'visible', 'off')
set(handles.pushb2,'visible', 'off')
set(handles.uibuttongVariableSelection,'visible', 'on')
Generador={0 true};
Name={'Numeric' 'Logical'};
set(handles.uitable13,'ColumnFormat',Name)
set(handles.uitable9,'ColumnFormat',Name)
set(handles.uitable10,'ColumnFormat',Name)
set(handles.uitable21,'ColumnFormat',Name)
set(handles.uitable23,'ColumnFormat',Name)
set(handles.uitable22,'ColumnFormat',Name)
set(handles.uitable18,'ColumnFormat',Name)
set(handles.uitable19,'ColumnFormat',Name)
set(handles.uitableWeatherPrediction,'Data',zeros(1,2))
set(handles.uitable9,'Data',repmat(Generador,11,1))
set(handles.uitable13,'Data',{1 true})
set(handles.uitable10,'Data',repmat(Generador,8,1))
set(handles.uitable21,'Data',repmat(Generador,24,1))
set(handles.uitable23,'Data',{1 true})
set(handles.uitable22,'Data',repmat(Generador,12,1))
set(handles.uitable18,'Data',repmat(Generador,15,1))
set(handles.uitable19,'Data',repmat(Generador,5,1))
set(handles.uipanel6,'visible','off')
set(handles.uipanel29,'visible','off')
set(handles.radiob36,'Value',1)
set(handles.uipanel6,'visible','off')
set(handles.uipanelxx,'visible','off')
set(handles.uitable21,'ColumnEditable',[true true])
set(handles.uitable18,'ColumnEditable',[true true])
set(handles.uitable9,'ColumnEditable',[true true])
set(handles.uitable22,'ColumnEditable',[true true])
set(handles.uitable19,'ColumnEditable',[true true])
set(handles.uitable10,'ColumnEditable',[true true])
set(handles.uitable42,'ColumnEditable',[true true true])
set(handles.uitable47,'ColumnEditable',[true true true])
set(handles.about,'visible','off')
set(handles.uitable23,'ColumnEditable',true)
set(handles.uitable13,'ColumnEditable',true)
set(handles.uipanel36,'visible','off');
set(handles.uipanel35,'visible','off');
set(handles.uipanel32,'visible','on');
set(handles.radiob1, 'Value', 1);
set(handles.radiob2, 'Value', 0);
set(handles.radiob3, 'Value', 0);
set(handles.pushbForecast,'Enable','off')
set(handles.pushbutton81,'Enable','off')
set(handles.popupm15,'Enable','off')
set(handles.popupm6,'String','N.A.')
set(handles.radiobNoFiltering,'Value',1)
radiob49_Callback(@radiob49_Callback,1, handles)
radiobNoFiltering_Callback(@radiobNoFiltering_Callback,1,handles)
edit25_Callback(@edit25_Callback,1,handles)
radiob87_Callback(@radiob87_Callback,1, handles)
radiob36_Callback(@radiob36_Callback,1, handles)
pushb49_Callback(@pushb49_Callback, 1, handles)
bd = load('borderdata.mat');
lat = bd.lat(1:246); 
lon = bd.lon(1:246);
plot(cell2nancat(lon),cell2nancat(lat),'Parent',handles.axes25,'Color',[0.1 0.1 0.1])
set(handles.axes25,'XLim',[-180 180])
set(handles.axes25,'YLim',[-90 90])
text1=[{'Model Name Descriptor'},{'This is the classical model used to describe the stages of vector born diseases. The letter correspond to the (S)usceptible, (E)xpectant, (I)nfected, and (R)ecovered components of the host-vector population'},{'N.A.'};
    {'Model Name Descriptor'},{'This is the model used to describe the vector stages. The stages are (E)ggs, (L)arvae, (P)upae, Immature mosquito, and Addult Mosquito.'},{'N.A.'};
    {'Model Name Descriptor'},{'This is the model describing both the vector born disease and the mosquito stages development It includes all the SEIR-SEI and LSEI stages. They are interconnected by the addult Mosquito'},{'N.A.'};
    {'Commuting Matrix'},{'This represent the communication (traveling) between clusters. Each row is how much time a host from the i cluster spent in the cluster j (Qij)'},{'N.A.'};
    {''},{''},{''};
    {'Host Total Population'},{'Total population of host per cluster it is composed of each element of the Susceptible, Expectant, Infected, and Recovered elements'},{'Number of Hosts'};
    {'Vector Total Population'},{'Total population of host per cluster it is composed of each element of th Susceptible, Expectant, and infected vector (all adults)'},{'Number of Vectors'};
    {'Host Mortality rate'},{'Number of host that are removed from the system per day. an approximation would be in base of ~75 years, (1/75*1/365)'},{'1/Day'};
    {'Vector conversion rate'},{'number of of vectors that transition from latent (expectant) to infectious condition at a daily base'},{'1/Day'};
    {'Host Conversion rate'},{'number of of host that transition from latent (expectant) to infectious condition at a daily base'},{'1/Day'};
    {'Recovery Rate'},{'number of host that transitionfrom infectious to recovered in a daily basis'},{'1/Day'};
    {'Mosquito Biting Rate'},{'Number of meals of vector with the potential to transmit diseases'},{'1/Day'};
    {'Vector Infectious Probability'},{'Probability that a bite preduce a transmision from host to vector'},{'N.A.'};
    {'Host Infectious Probability'},{'Probability that a bite produce a transmision from vector to host'},{'N.A.'};
    {'re-Susceptibility Rate'},{'rate-porcentage dependency that describe the rate of recovered people that could suffer multi-strain diseases. If no multistrain set it as 0'},{'1/Day'};
    {'Carrying Capacity'},{'Inter- and intra- competitiviness that produce a porcentage of te larvae population to be eliminated from the cluster'},{'1/Day'};
    {'Egg Oviposition Rate'},{'Number of eggs that are placed by an adult female mosquito per oviposition'},{'Eggs'};
    {'Pupae Transition Rate'},{'Rate of transition from the pupae stage to immature mosquitoe in the vector development model'},{'1/Day'};
    {'Larvae Transition Rate'},{'Rate of transition from the larvae stage to the pupae stage in the vector development model'},{'1/Day'};
    {'Vector Transition Rate'},{'Rate of transition from immature vector to adult vector in the vector development model'},{'1/Day'};
    {'Egg Transition Rate'},{'Rate of transition from egg to larvae in the vector development model'},{'1/day'};
    {'1st Pre-exponential Factor'},{'pre-Exponential factor for the vector (adult and immature) mortality rate'},{'1/Day'};
    {'2nd Pre-exponential Factor'},{'pre-Exponential factor for the Egg, Larvae, and Pupae mortality rate'},{'1/Day'};
    {'3rd Pre-exponential Factor'},{'pre-Exponential factor for the Egg oviposition rate'},{'1/Day'};
    {'Braking Point 1'},{'Braking point environmental variable affecting the Egg, Larvae, and Pupae'},{'Env. var.units'};
    {'Activation condition 1'},{'Activation variable for the environmental variable 1'},{'Env. var.units'};
    {'Braking Point 2'},{'Braking point environmental variable affecting the vector mortality rate'},{'Env. var.units'};
    {'Activation condition 2'},{'Activation variable for the environmental variable 2'},{'Env. var.units'};
    {'Braking Point 3'},{'Braking point environmental variable affecting the oviposition'},{'Env. var.units'};
    {'Activation condition 3'},{'Activation variable for the environmental variable 3'},{'Env. var.units'};
    {''},{''},{''};
    {'Susceptible Host'},{'Susceptible Host Population in a specific cluster'},{'Population Units'};
    {'Susceptible Adult Vector'},{'Susceptible Adult Vector Population in a specific cluster'},{'Population Units'};
    {'Infected Host'},{'Infected Host Population in a specific cluster'},{'Population Units'};
    {'Infected Vector'},{'Infected vector Population in a specific cluster'},{'Population Units'};
    {'Expectant Host'},{'Expectant Host Population in a specific cluster'},{'Population Units'};
    {'Expectant Vector'},{'Expectant Vector Population in a specific cluster'},{'Population Units'};
    {'Recovered Host'},{'Recovered Host Population in a specific cluster'},{'Population Units'};
    {'Accumulated Host'},{'Accumulated population that had infections simptoms in a specific cluster'},{'Population Units'};
    {'Egg'},{'Egg Population in a specific cluster'},{'Population Units'};
    {'Larvae'},{'Larvae Population in a specific cluster'},{'Population Units'};
    {'Pupae'},{'Pupae Population in a specific cluster'},{'Population Units'};
    {'Immature Vector'},{'Immature Vector Population in a specific cluster'},{'Population Units'}];

text2='Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland. Code cannot be copied and/or distributed without the express permission University College Cork All rights reserved';
set(handles.uitable54,'Data',text1);
set(handles.edit118,'String',text2);
set(handles.table1,'Data',zeros(4,4));
handles.output = hObject;

%%% this is for ARIMA
handles.metricdata.lagsToPlot=20;
handles.metricdata.isLogTransform=false;
handles.metricdata.isMeanCorrected=false;
handles.metricdata.differentiation=0;
handles.metricdata.harmonics=0;
handles.metricdata.seasonalityRemoved=0;
handles.metricdata.tCandidate=0;
handles.metricdata.D=0;
handles.metricdata.Seasonality=0;
handles.metricdata.isARLags=false;
handles.metricdata.isMALags=false;
handles.metricdata.isSARLags=false;
handles.metricdata.isSMALags=false;
handles.metricdata.isAR=false;
handles.metricdata.isMA=false;
handles.metricdata.isSAR=false;
handles.metricdata.isSMA=false;
handles.metricdata.ARLags=0;
handles.metricdata.MALags=0;
handles.metricdata.SARLags=0;
handles.metricdata.SMALags=0;
handles.metricdata.AR=0;
handles.metricdata.MA=0;
handles.metricdata.SAR=0;
handles.metricdata.SMA=0;
handles.metricdata.defaultpDq={'1','0','1'};
handles.metricdata.defaultanswer={'1','1'};
handles.metricdata.advancedFilterNum=1;
handles.metricdata.advancedFilterDen=1;
handles.metricdata.pRange=1;
handles.metricdata.DRange=0;
handles.metricdata.qRange=1;
handles.correlation_type=0;
axes(handles.axes1);
legend('hide')
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('History and Forecast')
xlabel('Time')  
ylim auto

axes(handles.axes11);
legend('hide')
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('History and Forecast')
xlabel('Time')  
ylim auto

axes(handles.axes16);
legend('hide')
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('History and Forecast')
xlabel('Time')  
ylim auto

axes(handles.axes18);
legend('hide')
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('Simulation Results')
xlabel('Time')  
ylim auto
guidata(hObject, handles);

function varargout = IngresoDatos_OutputFcn(~, ~, handles) 
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% ------------------- MENUS ------------------------------------%%%%%%%%%%
function menu_file_Callback(hObject, eventdata, handles)
function menu_case_Callback(hObject, eventdata, handles)  
function menu_load_Callback(hObject, eventdata, handles)
function menu_file_save_Callback(~, eventdata, handles)   
function menu_param_Callback(hObject, eventdata, handles)
function menu_map_Callback(hObject, eventdata, handles)
function menu_info_Callback(hObject, eventdata, handles)
    
function menu_case_forecast_Callback(hObject, eventdata, handles)
set(handles.uipanel1, 'visible', 'off')
set(handles.uipanel2,  'visible', 'on')
set(handles.uipanel3, 'visible','off')
set(handles.uipanel4,  'visible', 'off')
set(handles.uipanel5, 'visible', 'off')
set(handles.uipanelxx, 'visible','off')
set(handles.uipanel33, 'visible', 'off')
set(handles.uipanel75,'visible','off')
set(handles.uipanel82,'visible','off')
set(handles.about,'visible','off')
    
function menu_file_open_Callback(hObject, eventdata, handles)
try
inputOptions={'Epidemiological Data', 'Weather Data', 'Commuting Matrix','Vector Data'};    
defSelection=inputOptions{3};
Resp=bttnChoiseDialog(inputOptions, 'Data Type Selection', defSelection,'');
set(handles.edit1,'string','')
[file,path,~]=uigetfile('*.csv;*.xlsx;*.xls','Select a file with a time stamp in first column in the format dd.mm.yyyy');
set(handles.edit1,'string', path)
set(handles.pushb2,'UserData',[path, file]);
set(handles.radiob3,'Value',1);
answerQ=inputdlg('How many clusters (Columns) are you considering?','Number of clusters',[1 35],{'1'});
radiob3_Callback(@radiob3_Callback,eventdata,handles)
if Resp==1
    set(handles.radiob49,'Value',1)
elseif Resp==2
    set(handles.radiob50,'Value',1)
elseif Resp==3
    set(handles.radiob51,'Value',1)
end
set(handles.edit25,'String',answerQ{1})
pushb1_Callback(@pushb1_Callback, eventdata, handles)
set(handles.uipanell,'visible','on');
set(handles.uipanel2,'visible','off');
set(handles.uipanel3,'visible','off');
set(handles.uipanel4,'visible','off');
set(handles.uipanel5,'visible','off');
set(handles.uipanelxx,'visible','off');
set(handles.uipanel33,'visible','off');
set(handles.uipanel75,'visible','off')
set(handles.uipanel82,'visible','off')
set(handles.about,'visible','off')
menu_case_database_Callback(@menu_case_database_Callback, eventdata, handles)
catch
end

function menu_file_close_Callback(hObject, eventdata, handles)
answer=questdlg('Please confirm that you whant to close','Close','Yes','No','No');
try if answer=='Yes'; close('IngresoDatos'); end; catch me; end

function menu_param_current_Callback(hObject, eventdata, handles)
set(handles.uipanel1, 'visible', 'off')
set(handles.uipanel2,  'visible', 'off')
set(handles.uipanel3, 'visible','off')
set(handles.uipanel4, 'visible','on')
set(handles.uipanel5, 'visible','off')
set(handles.uipanelxx, 'visible', 'off')
set(handles.uipanel33,'visible','off')
set(handles.uipanel75,'visible','off')
set(handles.uipanel82,'visible','off')
set(handles.about,'visible','off')

function menu_param_predict_Callback(hObject, eventdata, handles)
set(handles.uipanel1, 'visible', 'off')
set(handles.uipanel2,  'visible', 'off')
set(handles.uipanel3, 'visible','off')
set(handles.uipanel4, 'visible','off')
set(handles.uipanel5, 'visible', 'on')
set(handles.uipanelxx, 'visible', 'off')
set(handles.uipanel33,'visible','off')
set(handles.uipanel75,'visible','off')
set(handles.uipanel82,'visible','off')
set(handles.about,'visible','off')
set(handles.radiobutton90,'value',1)
radiobutton90_Callback(@radiob87_Callback, eventdata, handles)

function menu_case_simulation_Callback(hObject, eventdata, handles)
set(handles.uipanel1, 'visible', 'off')
set(handles.uipanel2,  'visible', 'off')
set(handles.uipanel3, 'visible','off')
set(handles.uipanel4,  'visible', 'off')
set(handles.uipanel5, 'visible', 'off')
set(handles.uipanelxx, 'visible','on')
set(handles.uipanel33,'visible','off')
set(handles.uipanel75,'visible','off')
set(handles.uipanel82,'visible','off')
set(handles.about,'visible','off')
set(handles.radiob87,'Value',1)
radiob87_Callback(@radiob87_Callback, eventdata, handles)

function menu_information_about_Callback(hObject, eventdata, handles)
set(handles.uipanel1, 'visible', 'off')
set(handles.uipanel2,  'visible', 'off')
set(handles.uipanel3, 'visible','off')
set(handles.uipanel4,  'visible', 'off')
set(handles.uipanel5, 'visible', 'off')
set(handles.uipanelxx, 'visible','off')
set(handles.uipanel33,'visible','off')
set(handles.uipanel75,'visible','off')
set(handles.uipanel82,'visible','off')
set(handles.about,'visible','on')

function menu_information_help_Callback(hObject, eventdata, handles)
set(handles.uipanel1, 'visible', 'off')
set(handles.uipanel2,  'visible', 'off')
set(handles.uipanel3, 'visible','on')
set(handles.uipanel4,  'visible', 'off')
set(handles.uipanel5, 'visible', 'off')
set(handles.uipanelxx, 'visible','off')
set(handles.uipanel33,'visible','off')
set(handles.uipanel75,'visible','off')
set(handles.uipanel82,'visible','off')
set(handles.about,'visible','off')

function menu_load_computer_Callback(hObject, eventdata, handles)
set(handles.uipanel1, 'visible', 'on')
set(handles.uipanel2,  'visible', 'off')
set(handles.uipanel3, 'visible','off')
set(handles.uipanel4,  'visible', 'off')
set(handles.uipanel5, 'visible', 'off')
set(handles.uipanelxx, 'visible','off')
set(handles.uipanel33, 'visible','off')
set(handles.uipanel75,'visible','off')
set(handles.uipanel82,'visible','off')
set(handles.about,'visible','off')

function load_database_Callback(hObject, eventdata, handles)
set(handles.uipanel1, 'visible', 'off')
set(handles.uipanel2,  'visible', 'off')
set(handles.uipanel3, 'visible','off')
set(handles.uipanel4,  'visible', 'off')
set(handles.uipanel5, 'visible', 'off')
set(handles.uipanelxx, 'visible','off')
set(handles.uipanel33, 'visible','off')
set(handles.uipanel75,'visible','on')
set(handles.uipanel82,'visible','off')
set(handles.about,'visible','off')
 
function Menu_map_Simple_Callback(hObject, eventdata, handles)
set(handles.uipanel1, 'visible', 'off')
set(handles.uipanel2,  'visible', 'off')
set(handles.uipanel3, 'visible','off')
set(handles.uipanel4,  'visible', 'off')
set(handles.uipanel5, 'visible', 'off')
set(handles.uipanelxx, 'visible','off')
set(handles.uipanel33, 'visible','off')
set(handles.uipanel75,'visible','off')
set(handles.uipanel82,'visible','on')
set(handles.about,'visible','off')

function menu_file_save_param_Callback(hObject, eventdata, handles)
pushb51_Callback(@pushb51_Callback, eventdata, handles)
    
function menu_file_save_simulation_Cv_Callback(hObject, eventdata, handles)
try
A=getappdata(0,'SimResults');
[filename filepath]=uiputfile('*.xlsx');
sim=strcat(filepath,filename);
writetable(A,sim);
catch 
    warndlg('Make sure that the simulation results exist and use a valid name')
end

function menu_file_save_simulation2_Callback(hObject, eventdata, handles)
try
A=getappdata(0,'SimResults2');
[filename filepath]=uiputfile('*.xlsx');
sim=strcat(filepath,filename);
writetable(A,sim);
catch 
    warndlg('Make sure that the simulation results exist and use a valid name')
end


function menu_file_save_fore_Callback(hObject, eventdata, handles)
try
F=getappdata(0,'F');
[filename filepath]=uiputfile('*.xlsx');
sim=strcat(filepath,filename);
writetable(F,sim);
catch 
    warndlg('Make sure that the simulation results exist and use a valid name')
end   

function menu_clear_all_Callback(hObject, eventdata, handles)
set(handles.text46,'BackgroundColor',[1 0.8 0])
set(handles.text47,'BackgroundColor',[1 0.8 0])
set(handles.text48,'BackgroundColor',[1 0.8 0])
set(handles.text49,'BackgroundColor',[1 0.8 0])
setappdata(0,'A',[])
setappdata(0,'AA',[])
setappdata(0,'ts',[])
setappdata(0,'tsM',[])
setappdata(0,'T',[])
setappdata(0,'Q',[])
setappdata(0,'V',[])
setappdata(0,'E',[])
setappdata(0,'F',[])
setappdata(0,'SimResults',[])
setappdata(0,'myEKF',[])
setappdata(0,'myPF',[])
set(handles.pushbForecast,'Enable','off')
set(handles.pushbutton81,'Enable','off')
set(handles.popupm15,'Enable','off')
axes(handles.axes1);
cla reset;
axes(handles.axes11);
cla reset;
axes(handles.axes16);
cla reset;
set(handles.uitable43, 'Data', cell(size(get(handles.uitable43,'Data'))));
set(handles.uitable52, 'Data', cell(size(get(handles.uitable52,'Data'))));
set(handles.uitable84, 'Data', cell(size(get(handles.uitable84,'Data'))));
set(handles.uitable85, 'Data', cell(size(get(handles.uitable85,'Data'))));
set(handles.uitable30, 'Data', cell(size(get(handles.uitable30,'Data'))));
set(handles.uitable83, 'Data', cell(size(get(handles.uitable83,'Data'))));
set(handles.uitable87, 'Data', cell(size(get(handles.uitable87,'Data'))));
set(handles.uitable53, 'Data', cell(size(get(handles.uitable53,'Data'))));
set(handles.uitable86, 'Data', cell(size(get(handles.uitable86,'Data'))));
set(handles.uitable44, 'Data', cell(size(get(handles.uitable44,'Data'))));
set(handles.table1, 'Data', cell(size(get(handles.table1,'Data'))));
pushb49_Callback(@pushb49_Callback,1, handles)

function menu_clear_figures_Callback(hObject, eventdata, handles)
axes(handles.axes1);
cla reset;
axes(handles.axes11);
cla reset;
axes(handles.axes16);
cla reset;
axes(handles.axes17);
cla reset;
axes(handles.axes18);
cla reset;

function menu_file_save_simulation_Ih_Callback(hObject, eventdata, handles)
try
A=getappdata(0,'SimResults3');
[filename filepath]=uiputfile('*.xlsx');
sim=strcat(filepath,filename);
writetable(A,sim);
catch 
    warndlg('Make sure that the simulation results exist and use a valid name')
end
%%%%%%%%%%%%%%%%%%%%%%%% up to here menus %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pushb1_Callback(hObject, eventdata, handles)
    termino=0;    
%try
while termino==0
    informacion=get(handles.pushb2,'UserData');
    try
        [~,~,ext] = fileparts(informacion);
    catch
        break
    end
    if get(handles.radiob3,'Value')==1
         if strcmp(ext,'.csv')==1 || strcmp(ext,'.xls')==1 || strcmp(ext,'.xlsx')==1 
                A=readtable(informacion);
                valor=floor(str2double(get(handles.edit25,'String'))); 
                if size(A,2)>valor+1 && get(handles.radiob51,'Value')==0
                    answer=questdlg('The number of columns excede the number of clusters. The exceeding columns will be deleted ... do you accept?','Too many columns','Yes','No','Yes');
                    try
                        if strcmp(answer,'Yes')==1
                            A=A(:,1:valor+1);
                        else
                            break
                        end
                    catch
                        break
                    end
                elseif size(A,2)<valor+1 && get(handles.radiob51,'Value')==0
                    answer=questdlg('The number of clusters excede the number of columns. The number of clusters will be reduced ... do you accept?','Too many columns','Yes','No','Yes');
                    try
                        if strcmp(answer,'Yes')==1
                            set(handles.edit22,'String',num2str(size(A,2)-1))
                            set(handles.edit25,'String',num2str(size(A,2)-1))
                        else
                            break
                        end
                    catch
                        break
                    end
             %   elseif get(handles.radiob135,'Value')==1 && size(A,2)<valor*3+1
             %       answer=questdlg('The number of clusters excede the number of columns. The number of clusters will be reduced ... do you accept?','Too many columns','Yes','No','Yes');
             %       try
             %           if strcmp(answer,'Yes')==1
             %               set(handles.edit22,'String',floor(num2str((size(A,2)-1)/3)))
             %               set(handles.edit25,'String',floor(num2str((size(A,2)-1)/3)))
             %           end
             %       catch
             %           break
             %       end
             %   elseif get(handles.radiob135,'Value')==1 && size(A,2)>valor*3+1
             %        answer=questdlg('The number of columns excede the number of clusters. \n The exceeding columns will be deleted ... do you accept?','Too many columns','Yes','No','Yes');
             %       try
             %           if strcmp(answer,'Yes')==1
             %               A=A(:,1:3*valor+1);
             %           end
             %       catch
             %           break
             %       end
                elseif get(handles.radiob51,'Value')==1
                    if size(A,1) ~= size(A,2) || sum(A)~=ones(nclus,1) 
                        warndlg('The Communting matrix is simetric in which each row have to add 1 \n Modify and load again')
                        break
                    end 
                    answer='Yes'; 
                else
                    answer='Yes';
                end          
            if strcmp(answer,'Yes')==1
             nume=seteoNombresStrings(handles);
             A.Properties.VariableNames=nume;
             set(handles.table1,'ColumnName',nume)
             if get(handles.radiob51,'Value')==1
             set(handles.popupm2,'String',char(nume{1:end}))
             set(handles.popupm6,'String',char(nume{1:end}))
             else
             set(handles.popupm2,'String',char(nume{2:end}))
             set(handles.popupm6,'String',char(nume{2:end}))
             end
            end
        else
            errordlg('The file must have a .csv, .xls, or .xlsx extension');
        end
    elseif get(handles.radiob2,'Value')==1
        if (strcmp(ext,'.csv')==1 || strcmp(ext,'.xls')==1 || strcmp(ext,'.xlsx')==1) && (get(handles.radiob51,'Value')==0) %&& get(handles.radiob139,'Value')==0)           
            if strcmp (ext,'.csv')==1 
                try   
                data=importdata(informacion);    
                raw1q=inputdlg('Specify the column for the year (Number)');
                raw2q=inputdlg('Specify the column for the month (Number)');
                raw3q=inputdlg('Specify the column for the day (Number)');
                raw4q=inputdlg('Specify the columns (initial ; final separated by blank space) for the variables to be read');
                rawTIME=cellstr(datestr(datetime([data(:,str2num(raw1q{1})) data(:,str2num(raw2q{1})) data(:,str2num(raw3q{1}))])));
                B=num2cell(data(:,str2num(raw4q{1})));
                A=cell2table([rawTIME B]);                
                catch
                warndlg('Make sure the size the number of raws is the same')    
                end
            else
                q1=inputdlg({'Specify the sheetname. If you dont know leave it blank', 'Specify the range for the year (ej: A2:A25). If you dont know leave it blank and select range'},'YEAR',1);
                if isempty(q1{1,1})==1
                    [~,~,raw1]=xlsread(informacion,-1);
                else
                    [~,~,raw1]=xlsread(informacion,q1{1,1},q1{2,1});
                end
                    
                q2=inputdlg({'Specify the sheetname. If you dont know leave it blank', 'Specify the range for the month (ej: A2:A25). If you dont know leave it blank and select range'},'MONTH',1);
                if isempty(q2{1,1})==1
                    [~,~,raw2]=xlsread(informacion,-1);
                else
                    [~,~,raw2]=xlsread(informacion,q2{1,1},q2{2,1});
                end            
                q3=inputdlg({'Specify the the sheetname. If you dont know leave it blank', 'Specify range for the day (ej: A2:A25). If you dont know leave it blank and select range'},'DAY',1);
                if isempty(q3{1,1})==1
                    [~,~,raw3]=xlsread(informacion,-1);
                else
                    [~,~,raw3]=xlsread(informacion,q3{1,1},q3{2,1});
                end
                q4=inputdlg({'Specify the the sheetname. If you dont know leave it blank', 'Specify range for the variables to be read (ej: A2:C34). If you dont know leave it blank and select range'},'VARIABLES',1);
                if isempty(q4{1,1})==1
                    [~,~,raw4]=xlsread(informacion,-1);
                else
                    [~,~,raw4]=xlsread(informacion,q4{1,1},q4{2,1});
                end               
                fecha=[cell2mat(raw1) cell2mat(raw2) cell2mat(raw3)];
                fecha(any(isnan(fecha),2),:)=[];
                rawTIME=cellstr(datestr(datetime(fecha)));
                A=cell2table([rawTIME raw4]);
            end     
        elseif (strcmp(ext,'.csv')==1 || strcmp(ext,'.xls')==1 || strcmp(ext,'.xlsx')==1) && (get(handles.radiob51,'Value')==1) %|| get(handles.radiob139,'Value')==1)
            if strcmp (ext,'.csv')==1 
                A=inputdlg('Specify the columns for the variables to be read (separated by a :)');
            else
                q4=inputdlg({'Specify the the sheetname. If you dont know leave it blank', 'Specify range for the variables to be read (ej: A2:C34). If you dont know leave it blank and select range'},'VARIABLES',1);
                if isempty(q4{1,1})==1
                    [~,~,A]=xlsread(informacion,-1);
                else
                    [~,~,A]=xlsread(informacion,q4{1,1},q4{2,1});
                end                     
            end
              A=cell2table(A);  
        else
            errordlg('The file must have a .csv, .xls, or .xlsx extension')
            break
        end 
        nclus=str2double(get(handles.edit25,'String'));
        nenv=str2double(get(handles.edit121,'String'));
        if size(A,2)~=nclus+1 && size(A,2)~=nenv+1
            warndlg('The number of clusters set do not correspond to the numbers of columns loaded. Set the number of clusters correctly')
            break
        end             
            nume=seteoNombresStrings(handles);
            A.Properties.VariableNames=nume; %modifico el titulo de las columnas en el data string.
            set(handles.table1,'ColumnName',nume)
            set(handles.popupm2,'String',char(nume{2:end}))
            set(handles.popupm6,'String',char(nume{2:end}))
            set(handles.popupm15,'String',char(nume{2:end}))
    else
        warndlg('You cannot use manually option with loading, please choose between structured and non structured data')
        break
    end     

 if (get(handles.radiob51,'Value')==0) %|| get(handles.radiob139,'Value')==0)
A.TIME=datetime(datevec(datenum(A.TIME)));
ts=datenum(A.TIME);
ts(:,2:size(A,2))=A{:,2:size(A,2)};
AA=table2timetable(A); 
AA=sortrows(AA);
set(handles.edit1,'String','')     
set(handles.table1,'Data',ts,'Visible','on') %tables can not handle time info so used ts
set(handles.popupm2,'Value',1)
seteandoTabla1('on',handles)
setappdata(0,'AA',AA)
setappdata(0,'ts',ts)
setappdata(0,'A',A)
pushb9_Callback(@pushb9_Callback, eventdata, handles)
edit25_Callback(@edit25_Callback, eventdata, handles)
set(handles.edit29,'String',num2str(ts(1,1)))
set(handles.edit30,'String',num2str(ts(end,1)))
 else
set(handles.edit1,'String','')     
set(handles.table1,'Data',A,'Visible','on') %tables can not handle time info so used ts
set(handles.popupm2,'Value',1)
seteandoTabla1('on',handles)    
 end
termino=1;
end

% --- Executes on button press in pushb2.
function pushb2_Callback(hObject, ~, handles)
set(handles.edit1,'string','')
[file,path,~]=uigetfile('*.csv;*.xlsx;*.xls','Select a file with a time stamp in first column in the format dd.mm.yyyy');
set(handles.edit1,'string', path)
set(handles.pushb2,'UserData',[path, file]);

%---------- radio buttons  Load Option---------------------------
function radiob1_Callback(hObject, eventdata, handles)
if get(handles.radiob1,'Value')==1
    set(handles.pushb2,'visible', 'off')
    set(handles.edit1,'visible', 'off')
    set(handles.pushb1,'visible', 'off')
    set(handles.popupm1,'visible','on')
    seteandoTabla1('on',handles)
end
edit25_Callback(@edit25_Callback,eventdata,handles)

function radiob2_Callback(hObject, eventdata, handles)
if get(handles.radiob2,'Value')==1
    set(handles.pushb2,'visible', 'on')
    set(handles.edit1,'visible', 'on')
    set(handles.pushb1,'visible', 'on')   
end
edit25_Callback(@edit25_Callback,eventdata,handles)

function radiob3_Callback(hObject, eventdata, handles)
if get(handles.radiob3,'Value')==1
    set(handles.pushb2,'visible', 'on')
    set(handles.edit1,'visible', 'on')
    set(handles.pushb1,'visible', 'on')
end
edit25_Callback(@edit25_Callback,eventdata,handles)

function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushb4_Callback(hObject, eventdata, handles)
data=get(handles.table1,'Data');
if strcmp(get(handles.edit59,'String'),'')==1 || strcmp(get(handles.edit59,'String'),'0')==1 || strcmp(get(handles.edit59,'String'),'Row #')==1
    if strcmp(class(data),'char')==1 || strcmp(class(data),'double')==1
        newrow=zeros(1,size(data,2));
    elseif strcmp(class(data),'cell')==1
        newrow=cell(1,size(data,2));
    end
data=cat(1,data,newrow);
else
      if strcmp(class(data),'char')==1 || strcmp(class(data),'double')==1
        newrow=zeros(1,size(data,2));
    elseif strcmp(class(data),'cell')==1
        newrow=cell(1,size(data,2));
      end
 pivot=str2double(get(handles.edit59,'String'));
 data=[data(1:pivot,:);newrow;data(pivot+1:end,:)];
end
set(handles.table1,'Data',data);

function pushb7_Callback(hObject, eventdata, handles)
try
AA=get(handles.table1,'Data');
nume=seteoNombresStrings(handles);
AA=array2table(AA,'VariableNames',nume);
AA.TIME=datetime(datevec(AA.TIME));
AA=unique(sortrows(AA));
BB=table2timetable(AA);
ini=get(handles.edit29,'String');
fin=get(handles.edit30,'String');
inic=str2num(ini);
finc=str2num(fin);
stringt=inic:finc;
pu=datetime(datevec(stringt));
info=get(handles.popupm1,'Value');

if info==1
tipo='linear';
elseif info==2
tipo='spline';        
elseif info==3
tipo='pchip';                     
elseif info==4
tipo='makima';
end

pruebasal=retime(BB,pu,tipo);
BB=unique(sortrows([BB;pruebasal])); %unique remove repited data and sortrows las ordena
AA=timetable2table(BB);
AA.TIME=datenum(AA.TIME);
setappdata(0,'AA',AA)
AA=table2array(AA);
set(handles.table1,'Data',AA);
pushb9_Callback(@push9_Callback, eventdata, handles);
catch
   warndlg('Make sure that are not repeated days within the data and it is arranged properly') 
end

function popupm1_Callback(hObject, eventdata, handles)

function popupm1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit22_Callback(hObject, eventdata, handles)
set(handles.edit25,'String',get(handles.edit22,'String'))
edit25_Callback(@edit25_Callback,eventdata,handles)

function edit22_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushb9.
function pushb9_Callback(hObject, eventdata, handles)
try
nume=seteoNombresStrings(handles);
AA=get(handles.table1,'Data');
AA=array2table(AA,'VariableNames',nume);
AA.TIME=datetime(datevec(AA.TIME));
AA=table2timetable(AA);
yy=get(handles.popupm2,'Value');
plot(AA.TIME,AA{:,yy},'LineStyle','none','Marker','o','MarkerEdgeColor','b','MarkerSize',2,'Parent',handles.axes1)
plot(AA.TIME,AA{:,yy},'LineStyle','none','Marker','o','MarkerEdgeColor','b','MarkerSize',2,'Parent',handles.axes11)
plot(AA.TIME,AA{:,yy},'LineStyle','none','Marker','o','MarkerEdgeColor','b','MarkerSize',2,'Parent',handles.axes16)

axes(handles.axes11);
legend('hide')
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('History and Forecast')
xlabel('Time')  
ylim auto

axes(handles.axes1);
legend('hide')
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('History and Forecast')
xlabel('Time')  
ylim auto

axes(handles.axes16);
legend('hide')
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('History and Forecast')
xlabel('Time')  
ylim auto

catch
warndlg('The data could be corrupted for plot. Make sure to make it handable')
end


function popupm2_Callback(hObject, eventdata, handles)
set(handles.popupm6,'Value',get(handles.popupm2,'Value'))

function popupm2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit23_Callback(hObject, eventdata, handles)

function edit23_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function UsoInterno_Callback(hObject, eventdata, handles)

function edit25_Callback(hObject, eventdata, handles)
Nclusters=str2double(get(handles.edit25,'String'));
Nenvironmental=str2double(get(handles.edit121,'String'));
set(handles.edit22,'String',get(handles.edit25,'String'));
Name={};
ColName={};
J=[];
Q=[];
for i=1:Nclusters
    Name{end+1}='Numeric';
    Name{end+1}='Logical';
    ColName{end+1}=strcat('Clust',num2str(i));
    ColName{end+1}='Fixed';
    J{end+1}={true true};
    Q{end+1}={true};
end

if  get(handles.radiob1,'Value')==1 &&  get(handles.radiob50,'Value')==1 && get(handles.radiob51,'Value')~=1 && get(handles.radiob135,'Value')~=1 %&& get(handles.radiob139,'Value')~=1
    infoT1=get(handles.table1,'Data');
    [filas,columnas]=size(infoT1);
    if columnas-3>Nclusters*Nenvironmental
        infoT1(:,Nclusters*Nenvironmental+4:end)=[];
    elseif columnas-3<Nclusters*Nenvironmental
        infoT1(filas,Nclusters*Nenvironmental+3)=0;
    end
    set(handles.table1,'Data',infoT1)
    set(handles.table1,'ColumnEditable',true(1,Nclusters*Nenvironmental+3)); 
elseif get(handles.radiob51,'Value')==1
    infoT1=get(handles.table1,'Data');
    [filas,columnas]=size(infoT1);
    if columnas<Nclusters || filas<Nclusters
        infoT1(Nclusters,Nclusters)=0;
    elseif columnas>Nclusters || filas>Nclusters
        infoT1(:,Nclusters+1:end)=[]; 
        infoT1(Nclusters+1:end,:)=[]; 
    end    
    set(handles.table1,'Data',infoT1)
    set(handles.table1,'ColumnEditable',true(1,Nclusters));

elseif (get(handles.radiob3,'Value')==1 || get(handles.radiob2,'Value')==1) && get(handles.radiob50,'Value')==0 %|| get(handles.radiob139,'Value')==1)
    infoT1=get(handles.table1,'Data');
    [filas,columnas]=size(infoT1);
    if columnas-1>Nclusters
        infoT1(:,Nclusters+2:end)=[];
    elseif columnas-1<Nclusters
        infoT1(filas,Nclusters+1)=0;
    end
    set(handles.table1,'Data',infoT1)
    set(handles.table1,'ColumnEditable',true(1,Nclusters+1));
elseif (get(handles.radiob3,'Value')==1 || get(handles.radiob2,'Value')==1) && get(handles.radiob50,'Value')==1 %|| get(handles.radiob139,'Value')==1)
    infoT1=get(handles.table1,'Data');
    [filas,columnas]=size(infoT1);
    if columnas-1>Nclusters*Nenvironmental
        infoT1(:,Nclusters*Nenvironmental+2:end)=[];
    elseif columnas-1<Nclusters*Nenvironmental
        infoT1(filas,Nclusters*Nenvironmental+1)=0;
    end
    set(handles.table1,'Data',infoT1)
    set(handles.table1,'ColumnEditable',true(1,Nclusters*Nenvironmental+1));
end

A1=get(handles.uitable9,'Data');
A2=get(handles.uitable13,'Data');
A3=get(handles.uitable10,'Data');
A4=get(handles.uitable21,'Data');
A5=get(handles.uitable23,'Data');
A6=get(handles.uitable22,'Data');
A7=get(handles.uitable18,'Data');
A8=get(handles.uitable19,'Data');
A9=get(handles.uitableWeatherPrediction,'Data');
A10=get(handles.uitable47,'Data');
A11=get(handles.uitable42,'Data');

%%%%%tabla de forecasting
    [filas,columnas]=size(A9);
    if columnas-1>Nclusters*Nenvironmental
        A9(:,Nclusters*Nenvironmental+2:end)=[];
    elseif columnas-1<Nclusters*Nenvironmental
        A9(filas,Nclusters*Nenvironmental+1)=0;
    end
    set(handles.uitableWeatherPrediction,'Data',A9)
    set(handles.uitableWeatherPrediction,'ColumnEditable',true(1,Nclusters*Nenvironmental+1));
    
    [filas,columnas]=size(A10);
    if columnas-1>Nclusters*Nenvironmental
        A10(:,Nclusters*Nenvironmental+2:end)=[];
    elseif columnas-1<Nclusters*Nenvironmental
        A10(filas,Nclusters*Nenvironmental+1)=0;
    end
    set(handles.uitable47,'Data',A10)
    set(handles.uitable47,'ColumnEditable',true(1,Nclusters*Nenvironmental+1));
    
    [filas,columnas]=size(A11);
    if columnas-1>Nclusters*Nenvironmental
        A11(:,Nclusters*Nenvironmental+2:end)=[];
    elseif columnas-1<Nclusters*Nenvironmental
        A11(filas,Nclusters*Nenvironmental+1)=0;
    end
    set(handles.uitable42,'Data',A11)
    set(handles.uitable42,'ColumnEditable',true(1,Nclusters*Nenvironmental+1));
    
%%%%%%%%%%%%%%%%
if size(A1,2)/2~=Nclusters
set(handles.uitable9,'Data', repmat(A1(:,1:2),1,Nclusters))
Z=repmat(A2(:,1:2),1,Nclusters);
ZZ=repmat(Z(1,:),Nclusters,1);
set(handles.uitable13,'Data', ZZ)
set(handles.uitable10,'Data', repmat(A3(:,1:2),1,Nclusters))
set(handles.uitable21,'Data', repmat(A4(:,1:2),1,Nclusters))
N=repmat(A5(:,1:2),1,Nclusters);
NN=repmat(N(1,:),Nclusters,1);
set(handles.uitable23,'Data', NN)
set(handles.uitable22,'Data', repmat(A6(:,1:2),1,Nclusters))
set(handles.uitable18,'Data', repmat(A7(:,1:2),1,Nclusters))
set(handles.uitable19,'Data', repmat(A8(:,1:2),1,Nclusters))
end
set(handles.uitable9,'ColumnFormat',Name);
set(handles.uitable18,'ColumnFormat',Name);
set(handles.uitable21,'ColumnFormat',Name);
set(handles.uitable10,'ColumnFormat',Name);
set(handles.uitable22,'ColumnFormat',Name);
set(handles.uitable19,'ColumnFormat',Name);
set(handles.uitable13,'ColumnFormat',Name);
set(handles.uitable23,'ColumnFormat',Name);
set(handles.uitable21,'ColumnEditable',true(1,2*Nclusters));
set(handles.uitable18,'ColumnEditable',true(1,2*Nclusters));
set(handles.uitable9,'ColumnEditable',true(1,2*Nclusters));
set(handles.uitable23,'ColumnEditable',true(1,2*Nclusters));
set(handles.uitable22,'ColumnEditable',true(1,2*Nclusters));
set(handles.uitable19,'ColumnEditable',true(1,2*Nclusters));
set(handles.uitable13,'ColumnEditable',true(1,2*Nclusters));
set(handles.uitable10,'ColumnEditable',true(1,2*Nclusters));
set(handles.uitable21,'ColumnName',ColName);
set(handles.uitable18,'ColumnName',ColName);
set(handles.uitable9,'ColumnName',ColName);
set(handles.uitable23,'ColumnName',ColName);
set(handles.uitable22,'ColumnName',ColName);
set(handles.uitable19,'ColumnName',ColName);
set(handles.uitable13,'ColumnName',ColName);
set(handles.uitable10,'ColumnName',ColName);

%%%%% Para seteo de los tamanos de las matrizes en la seccion forecasting 
if get(handles.checkbox24,'Value')==1 
    if get(handles.radiob36,'value')==1 
    nvar=8;
    elseif get(handles.radiob37,'value')==1 
    nvar=12;
    elseif get(handles.radiob53,'value')==1 
    nvar=5;    
    end     
    set(handles.uitable63,'Data',str2double(get(handles.edit104,'string'))*eye(nvar*Nclusters))
    set(handles.uitable60,'Data',str2double(get(handles.edit105,'string'))*eye(nvar*Nclusters))
else
    if get(handles.radiob36,'value')==1 
    nvar=8;
    elseif get(handles.radiob37,'value')==1 
    nvar=12;
    elseif get(handles.radiob53,'value')==1 
    nvar=5;    
    end     
    A=get(handles.uitable63,'Data');
    B=get(handles.uitable60,'Data');
        AA=diag(nvar);
        BB=diag(nvar);
        AA(1:size(A,1),1:size(A,1))=A;
        BB(1:size(B,1),1:size(B,1))=B;
        set(handles.uitable63,'Data',AA(1:nvar,1:nvar))
        set(handles.uitable60,'Data',BB(1:nvar,1:nvar))
end    
%%%%%%%%%%%%%%%%%

numew={'TIME'};
for j=1:Nclusters
    for i=1:Nenvironmental
        numew{end+1}=strcat('EnvVar',num2str(i),'Clus',num2str(j));
    end
end

set(handles.uitable42,'ColumnName',numew);
set(handles.uitableWeatherPrediction,'ColumnName',numew);
set(handles.uitable47,'ColumnName',numew);

radiobutton90_Callback(@radiobutton90_Callback, eventdata, handles)
DOF(handles)
set(handles.radiob87,'Value',1)
nume=seteoNombresStrings(handles);
set(handles.table1,'ColumnName',nume)

if get(handles.radiob1,'Value')==1
set(handles.popupm2,'String',char(nume{4:end}))
set(handles.popupm6,'String',char(nume{4:end}))
else 
set(handles.popupm2,'String',char(nume{2:end}))
set(handles.popupm6,'String',char(nume{2:end}))
end   


function edit25_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function butg1_CreateFcn(hObject, eventdata, handles)

function togglebutton8_Callback(hObject, eventdata, handles)
function togglebutton9_Callback(hObject, eventdata, handles)
function togglebutton10_Callback(hObject, eventdata, handles)
function togglebutton11_Callback(hObject, eventdata, handles)
function togglebutton12_Callback(hObject, eventdata, handles)
function togglebutton1_Callback(hObject, eventdata, handles)
function togglebutton2_Callback(hObject, eventdata, handles)
function togglebutton3_Callback(hObject, eventdata, handles)
function togglebutton4_Callback(hObject, eventdata, handles)
function togglebutton5_Callback(hObject, eventdata, handles)
function listbox26_Callback(hObject, eventdata, handles)

function listbox26_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)

function edit26_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton13.
function togglebutton13_Callback(hObject, eventdata, handles)

function togglebutton14_Callback(hObject, eventdata, handles)

function togglebutton15_Callback(hObject, eventdata, handles)

function togglebutton16_Callback(hObject, eventdata, handles)

function togglebutton17_Callback(hObject, eventdata, handles)

function togglebutton18_Callback(hObject, eventdata, handles)

function togglebutton19_Callback(hObject, eventdata, handles)


function radiobStochasticSERISEI_Callback(hObject, eventdata, handles)
%setappdata(0,'tipomodelo',1)
handles.data.tipomodelo=1;
set(handles.uipanel6,'visible','off');
set(handles.uipanel7,'visible','on');
set(handles.uipanel29,'visible','off');
set(handles.radiob62,'visible','on');
set(handles.radiob63,'visible','on');
set(handles.radiob54,'visible','off');
set(handles.radiob55,'visible','off');
set(handles.radiob56,'visible','off');
set(handles.radiob57,'visible','off');
set(handles.radiob62,'Value',1);
DOF(handles)

function radiobStochasticSERILSEI_Callback(hObject, eventdata, handles)
%setappdata(0,'tipomodelo',2)
handles.data.tipomodelo=2;
set(handles.uipanel6,'visible','off');
set(handles.uipanel7,'visible','off');
set(handles.uipanel29,'visible','on');
set(handles.radiob62,'visible','on');
set(handles.radiob63,'visible','on');
set(handles.radiob54,'visible','on');
set(handles.radiob55,'visible','on');
set(handles.radiob56,'visible','on');
set(handles.radiob57,'visible','on');
%DOF(handles)

function radiob37_Callback(hObject, eventdata, handles)
%setappdata(0,'tipomodelo',2)
handles.data.tipomodelo=2;
set(handles.uipanel29,'visible','on');
set(handles.uipanel6,'visible','off');
set(handles.uipanel7,'visible','off');
set(handles.uipanel36,'visible','off');
set(handles.uipanel35,'visible','on');
set(handles.uipanel32,'visible','off');
set(handles.radiob62,'visible','on');
set(handles.radiob63,'visible','on');
set(handles.radiob54,'visible','off');
set(handles.radiob55,'visible','off');
set(handles.radiob56,'visible','off');
set(handles.radiob57,'visible','on');
set(handles.radiob121,'visible','off');
set(handles.radiob122,'visible','off');
set(handles.radiob123,'visible','off');
set(handles.radiob124,'visible','on');
set(handles.radiobCAccumulated,'visible','on');
set(handles.radiobInfectedHost,'visible','on');
set(handles.radiobCAccumulated,'Value',1);

%DOF(handles)
edit25_Callback(@edit25_Callback,eventdata,handles)

function radiob36_Callback(hObject, eventdata, handles)
%setappdata(0,'tipomodelo',1)
handles.data.tipomodelo=1;
set(handles.uipanel29,'visible','off');
set(handles.uipanel6,'visible','off');
set(handles.uipanel7,'visible','on');
set(handles.uipanel36,'visible','off');
set(handles.uipanel35,'visible','off');
set(handles.uipanel32,'visible','on');
set(handles.radiob62,'visible','on');
set(handles.radiob63,'visible','on');
set(handles.radiob54,'visible','off');
set(handles.radiob55,'visible','off');
set(handles.radiob56,'visible','off');
set(handles.radiob57,'visible','off');
set(handles.radiob121,'visible','off');
set(handles.radiob122,'visible','off');
set(handles.radiob123,'visible','off');
set(handles.radiob124,'visible','off');
set(handles.radiobCAccumulated,'visible','on');
set(handles.radiobInfectedHost,'visible','on');
set(handles.radiob62,'Value',1);
set(handles.radiobCAccumulated,'Value',1);
%DOF(handles)
edit25_Callback(@edit25_Callback,eventdata,handles)

function radiob53_Callback(hObject, eventdata, handles)
%setappdata(0,'tipomodelo',3)
handles.data.tipomodelo=3;
set(handles.uipanel29,'visible','off');
set(handles.uipanel6,'visible','on');
set(handles.uipanel7,'visible','off');
set(handles.uipanel36,'visible','on');
set(handles.uipanel35,'visible','off');
set(handles.uipanel32,'visible','off');
set(handles.radiob62,'visible','off');
set(handles.radiob63,'visible','off');
set(handles.radiob54,'visible','on');
set(handles.radiob55,'visible','on');
set(handles.radiob56,'visible','on');
set(handles.radiob57,'visible','on');
set(handles.radiob121,'visible','on');
set(handles.radiob122,'visible','on');
set(handles.radiob123,'visible','on');
set(handles.radiob124,'visible','on');
set(handles.radiobCAccumulated,'visible','off');
set(handles.radiobInfectedHost,'visible','off');
set(handles.radiob124,'Value',1);
set(handles.radiob57,'Value',1);
DOF(handles)
edit25_Callback(@edit25_Callback,eventdata,handles)

function pushb36_Callback(hObject, eventdata, handles)
cla(handles.axes1);
cla(handles.axes11);
cla(handles.axes16);
set(handles.table1, 'Data', cell(size(get(handles.table1,'Data'))));

function edit27_Callback(hObject, eventdata, handles)

function edit27_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit28_Callback(hObject, eventdata, handles)

function edit28_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushb10_Callback(hObject, eventdata, handles)

function edit29_Callback(hObject, eventdata, handles)

function edit29_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit30_Callback(hObject, eventdata, handles)

function edit30_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit31_Callback(hObject, eventdata, handles)

function edit31_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit32_Callback(hObject, eventdata, handles)

function edit32_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton38_Callback(hObject, eventdata, handles)

function edit38_Callback(hObject, eventdata, handles)

function edit38_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit37_Callback(hObject, eventdata, handles)

function edit37_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton41.




% --- Executes on button press in togglebutton26.
function togglebutton26_Callback(hObject, eventdata, handles)

    
function togglebutton27_Callback(hObject, eventdata, handles)

    
function togglebutton28_Callback(hObject, eventdata, handles)

    
function togglebutton29_Callback(hObject, eventdata, handles)

    
function togglebutton30_Callback(hObject, eventdata, handles)

    
function togglebutton31_Callback(hObject, eventdata, handles)

    
function uipanel6_CreateFcn(hObject, eventdata, handles)

    
function uipanel7_CreateFcn(hObject, eventdata, handles)

    
function uipanelxx_CreateFcn(hObject, eventdata, handles)

% --------------------------------------------------------------------


% --------------------------------------------------------------------



% --- Executes on button press in radiob49.
function radiob49_Callback(hObject, eventdata, handles)
edit25_Callback(@edit25_Callback,eventdata,handles)


function radiob50_Callback(hObject, eventdata, handles)
edit25_Callback(@edit25_Callback,eventdata,handles)


function radiob51_Callback(hObject, eventdata, handles)
edit25_Callback(@edit25_Callback,eventdata,handles)


function pushb42_Callback(hObject, eventdata, handles)

function togglebutton44_Callback(hObject, eventdata, handles)

function togglebutton45_Callback(hObject, eventdata, handles)

function togglebutton46_Callback(hObject, eventdata, handles)

function togglebutton47_Callback(hObject, eventdata, handles)

function togglebutton48_Callback(hObject, eventdata, handles)

function togglebutton49_Callback(hObject, eventdata, handles)

function togglebutton50_Callback(hObject, eventdata, handles)

function togglebutton51_Callback(hObject, eventdata, handles)

function togglebutton52_Callback(hObject, eventdata, handles)

function togglebutton53_Callback(hObject, eventdata, handles)

function togglebutton54_Callback(hObject, eventdata, handles)

function togglebutton55_Callback(hObject, eventdata, handles)

function togglebutton68_Callback(hObject, eventdata, handles)

function togglebutton69_Callback(hObject, eventdata, handles)

function togglebutton70_Callback(hObject, eventdata, handles)

function togglebutton71_Callback(hObject, eventdata, handles)

function togglebutton72_Callback(hObject, eventdata, handles)

function togglebutton73_Callback(hObject, eventdata, handles)

function togglebutton74_Callback(hObject, eventdata, handles)

function togglebutton75_Callback(hObject, eventdata, handles)

function togglebutton76_Callback(hObject, eventdata, handles)

function togglebutton77_Callback(hObject, eventdata, handles)

function togglebutton78_Callback(hObject, eventdata, handles)

function togglebutton79_Callback(hObject, eventdata, handles)

function togglebutton80_Callback(hObject, eventdata, handles)

function togglebutton81_Callback(hObject, eventdata, handles)

function togglebutton82_Callback(hObject, eventdata, handles)

function togglebutton83_Callback(hObject, eventdata, handles)

function togglebutton84_Callback(hObject, eventdata, handles)

function togglebutton85_Callback(hObject, eventdata, handles)

function togglebutton86_Callback(hObject, eventdata, handles)

function togglebutton87_Callback(hObject, eventdata, handles)

function togglebutton88_Callback(hObject, eventdata, handles)

function togglebutton89_Callback(hObject, eventdata, handles)

function togglebutton90_Callback(hObject, eventdata, handles)

function togglebutton91_Callback(hObject, eventdata, handles)

function pushb43_Callback(hObject, eventdata, handles)
try
task=find([get(handles.radiob36,'Value') get(handles.radiob37,'Value') get(handles.radiob53,'Value')]==1);
nclus=str2double(get(handles.edit25,'String'));
nenv=str2double(get(handles.edit119,'String'));
termino=0;
while termino==0
    
if str2double(get(handles.text50,'String'))==0
  opts=struct('WindowStyle','replace','Interpreter','tex');
  warndlg('The \bf Degrees of Freedom \rm can not be zero in a parameter determination process, check your \bf Parameter Configuration \rm','DOF problem',opts)
  break
end   
  %%%%%%%%%%%%%%%%%%  
    if task==1 
        E=getappdata(0,'E');
        if size(E,2)~=nclus+1
            opts=struct('WindowStyle','replace','Interpreter','tex');
            warndlg('The information has not be set correctly. The \bf size \rm of the set information not correspond to the \bf number of clusters \rm in the memory','Error With Data in Memory',opts)
            break
        end       
        E.TIME=datenum(E.TIME);
        Xdata=E.TIME;%-E{1,1};
        Ydata=E{:,2:end};        
        if get(handles.radiob63,'Value')==1
            selectorvariables=2;
        else
            selectorvariables=1;
        end
        timerange=Xdata'; %[0:1:Xdata(end)]; estaba asi y lo cambie a  xdata traspuesta a ver si funciona
        q=get(handles.uitable13,'Data');
        param=get(handles.uitable9,'Data');
        init=get(handles.uitable10,'Data');
        [PARAM,Q,INIT,SELECTOR,SELECTOR2,SELECTOR3]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);

        INITIAL=[];
        for i=1:8
            for j=1:nclus
                INITIAL=[INITIAL; INIT(i,j)];
            end
        end
        Q(isnan(Q))=0; % makes the variables NaN equal to zero.
        PARAM(isnan(PARAM))=0;
        INITIAL(isnan(INITIAL))=0;
        SELECTOR(isnan(SELECTOR))=0;  
        SETING=[SELECTOR(1,:) SELECTOR(2,:) SELECTOR(3,:) SELECTOR(4,:) SELECTOR(5,:) SELECTOR(6,:) SELECTOR(7,:) SELECTOR(8,:) SELECTOR(9,:) SELECTOR(10,:) SELECTOR(11,:)];
        SETING3=[SELECTOR3(1,:) SELECTOR3(2,:) SELECTOR3(3,:) SELECTOR3(4,:) SELECTOR3(5,:) SELECTOR3(6,:) SELECTOR3(7,:) SELECTOR3(8,:)];
        SETING2=[];
        for i=1:nclus
            SETING2=[SETING2 SELECTOR2(i,:)]; 
        end   
    results=ODEs(4,Xdata,nclus, PARAM(1,:), PARAM(2,:),Q, PARAM(3,:), PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), PARAM(10,:), PARAM(11,:), INITIAL, Ydata, SETING, SETING2, SETING3,selectorvariables);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif task==2 
        E=getappdata(0,'E');
        temp=get(handles.uitable47,'Data');
        if size(E,2)~=nclus+1
            opts=struct('WindowStyle','replace','Interpreter','tex');
            warndlg('The information has not be set correctly. The size of the information \bf Set \rm not correspond to the \bf Number of Clusters \rm in the memory','Configuration Problem',opts)
            break
        end 
        if size(temp,2)~=nenv*nclus+1
            opts=struct('WindowStyle','replace','Interpreter','tex');
            warndlg('The information has not be set correctly. The size of the \bf Environmental Information Set \rm not correspond to the \bf Number of Environmental Variables \rm in the memory','Configuration Problem',opts)
            break
        end

        E.TIME=datenum(E.TIME);        
        Xdata=E.TIME;%
        Ydata=E{:,2:end};
     if get(handles.radiob63,'Value')==1
            selectorvariables=2;
        elseif get(handles.radiob62,'Value')==1
            selectorvariables=1;
        elseif get(handles.radiob57,'Value')==1
            selectorvariables=3;
        end
        timerange=[0:1:Xdata(end)];
        q=get(handles.uitable23,'Data');
        param=get(handles.uitable21,'Data');
        init=get(handles.uitable22,'Data');
        
        [PARAM,Q,INIT,SELECTOR,SELECTOR2,SELECTOR3]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);

        INITIAL=[];
        for i=1:size(SELECTOR3,1)
            for j=1:nclus
                INITIAL=[INITIAL; INIT(i,j)];
            end
        end
        Q(isnan(Q))=0; % makes the variables NaN equal to zero.
        PARAM(isnan(PARAM))=0;
        INITIAL(isnan(INITIAL))=0;
        SELECTOR(isnan(SELECTOR))=0;  
        temp(isnan(temp))=0;
        Nh=PARAM(1,:);
        Uh=PARAM(2,:);
        Kv=PARAM(3,:);
        Kh=PARAM(4,:);
        Gama=PARAM(5,:);
        Alpha=PARAM(6,:);
        Pv=PARAM(7,:);
        Ph=PARAM(8,:);
        Tau=PARAM(9,:);
        ko=PARAM(10,:);
        ep=PARAM(11,:);
        Tp=PARAM(12,:);
        Tl=PARAM(13,:);
        Ti=PARAM(14,:);
        Te=PARAM(15,:); 
        Pre01=PARAM(16,:);
        Pre02=PARAM(17,:);
        Pre03=PARAM(18,:);
        Mu1=[]; Mu2=[]; Mu3=[]; Mu4=[]; Mu5=[]; Mu6=[];
        for i=1:nenv
        Mu1=[Mu1 PARAM(18+i,:)];
        Mu2=[Mu2 PARAM(18+nenv+i,:)];
        Mu3=[Mu3 PARAM(18+2*nenv+i,:)];
        Mu4=[Mu4 PARAM(18+3*nenv+i,:)];
        Mu5=[Mu5 PARAM(18+4*nenv+i,:)];
        Mu6=[Mu6 PARAM(18+5*nenv+i,:)];
        end
        SETING=[SELECTOR(1,:) SELECTOR(2,:) SELECTOR(3,:) SELECTOR(4,:) SELECTOR(5,:) SELECTOR(6,:) SELECTOR(7,:) SELECTOR(8,:) SELECTOR(9,:) SELECTOR(10,:) SELECTOR(11,:) SELECTOR(12,:) SELECTOR(13,:) SELECTOR(14,:) SELECTOR(15,:) SELECTOR(16,:) SELECTOR(17,:) SELECTOR(18,:) reshape(SELECTOR(19:18+nenv,:),[1,nclus*nenv]) reshape(SELECTOR(19+nenv:18+2*nenv,:),[1,nclus*nenv]) reshape(SELECTOR(19+2*nenv:18+3*nenv,:),[1,nclus*nenv]) reshape(SELECTOR(19+3*nenv:18+4*nenv,:),[1,nclus*nenv]) reshape(SELECTOR(19+4*nenv:18+5*nenv,:),[1,nclus*nenv]) reshape(SELECTOR(19+5*nenv:18+6*nenv,:),[1,nclus*nenv])];
        SETING3=[SELECTOR3(1,:) SELECTOR3(2,:) SELECTOR3(3,:) SELECTOR3(4,:) SELECTOR3(5,:) SELECTOR3(6,:) SELECTOR3(7,:) SELECTOR3(8,:) SELECTOR3(9,:) SELECTOR3(10,:) SELECTOR3(11,:) SELECTOR3(12,:)];
        SETING2=[];
        for i=1:nclus
            SETING2=[SETING2 SELECTOR2(i,:)]; 
        end
    results=ODEs(6,Xdata,nclus, temp, Q, Nh, Uh, Kv, Kh, Gama, Alpha, Pv, Ph, Tau, ko, ep, Tp, Tl, Ti, Te, Pre01, Pre02, Pre03, Mu1, Mu2, Mu3, Mu4, Mu5, Mu6, INITIAL, Ydata, SETING, selectorvariables, SETING2, SETING3,nenv);
%%%%%%%%%%%%%%%%%%%%%%          
    elseif task == 3 
        V=getappdata(0,'V');
        if size(V,2)~=nclus+1
            opts=struct('WindowStyle','replace','Interpreter','tex');
            warndlg('The information has not be set correctly. The size of the information \bf Set \rm not correspond to the \bf Number of Clusters \rm in the memory','Configuration Problem',opts)
            break
        end 
        V.TIME=datenum(V.TIME);        
        Xdata=V.TIME;%-V{1,1};
        Ydata=V{:,2:end};
        temp=get(handles.uitable47,'Data');   
        timerange=[0:1:Xdata(end)];
        param=get(handles.uitable18,'Data');
        init=get(handles.uitable19,'Data');           
        [PARAM,~,INIT,SELECTOR,~,SELECTOR3]=EvaluarMatrix(size(param,1),size(init,1),param,[],init,nclus);
        INITIAL=[];
        for i=1:5
            for j=1:nclus
                INITIAL=[INITIAL; INIT(i,j)];
            end
        end    
        PARAM(isnan(PARAM))=0;
        INITIAL(isnan(INITIAL))=0;
        SELECTOR(isnan(SELECTOR))=0;  
        temp(isnan(temp))=0;
        ko=PARAM(1,:);
        ep=PARAM(2,:);
        Tp=PARAM(3,:);
        Tl=PARAM(4,:);
        Ti=PARAM(5,:);
        Te=PARAM(6,:);
        Pre01=PARAM(7,:);
        Pre02=PARAM(8,:);
        Pre03=PARAM(9,:);
        Mu1=[]; Mu2=[]; Mu3=[]; Mu4=[]; Mu5=[]; Mu6=[];
        for i=1:nenv
        Mu1=[Mu1 PARAM(9+i,:)];
        Mu2=[Mu2 PARAM(9+nenv+i,:)];
        Mu3=[Mu3 PARAM(9+2*nenv+i,:)];
        Mu4=[Mu4 PARAM(9+3*nenv+i,:)];
        Mu5=[Mu5 PARAM(9+4*nenv+i,:)];
        Mu6=[Mu6 PARAM(9+5*nenv+i,:)];
        end     
        
    if get(handles.radiob57,'Value')==1
        selectorvariables=4;
    elseif get(handles.radiob56,'Value')==1
     selectorvariables=3;
    elseif get(handles.radiob55,'Value')==1
     selectorvariables=2;
    else
     selectorvariables=1;
    end
    SETING=[SELECTOR(1,:) SELECTOR(2,:) SELECTOR(3,:) SELECTOR(4,:) SELECTOR(5,:) SELECTOR(6,:) SELECTOR(7,:) SELECTOR(8,:) SELECTOR(9,:) reshape(SELECTOR(10:9+nenv,:),[1,nclus*nenv]) reshape(SELECTOR(10+nenv:9+2*nenv,:),[1,nclus*nenv]) reshape(SELECTOR(10+2*nenv:9+3*nenv,:),[1,nclus*nenv]) reshape(SELECTOR(10+3*nenv:9+4*nenv,:),[1,nclus*nenv]) reshape(SELECTOR(10+4*nenv:9+5*nenv,:),[1,nclus*nenv]) reshape(SELECTOR(10+5*nenv:9+6*nenv,:),[1,nclus*nenv])];    
    SETING3=[SELECTOR3(1,:) SELECTOR3(2,:) SELECTOR3(3,:) SELECTOR3(4,:) SELECTOR3(5,:)];    
    results=ODEs(5,Xdata,nclus, temp,ko,ep,Tp,Tl,Ti,Te,Pre01,Pre02,Pre03,Mu1,Mu2,Mu3,Mu4,Mu5,Mu6,INITIAL, Ydata, SETING,selectorvariables,SETING3,nenv);      
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
coef=results{1,1};
coef2=results{1,2};
coef3=results{1,3};
Residuos=results{1,4};
bar(Residuos,'Parent',handles.axes17)
 %for j=1:nparam
 %   for i=1:nclus
 %      COEF(j,i)=coef(1);
 %      coef(1)=[];
 %   end
 %end
if task==1 || task==4
set(handles.uitable30,'Data',reshape(coef,nclus,size(param,1))')
set(handles.uitable83,'Data',reshape(coef2,nclus,nclus)')
set(handles.uitable87,'Data',reshape(coef3,nclus,size(init,1))')
elseif task==2 || task==5
set(handles.uitable52, 'Data',reshape(coef,nclus,size(param,1))')
set(handles.uitable84,'Data',reshape(coef2,nclus,nclus)')
set(handles.uitable85,'Data',reshape(coef3,nclus,size(init,1))')
elseif task==3 || task==6
set(handles.uitable53,'Data',reshape(coef,nclus,size(param,1))')
set(handles.uitable86,'Data',reshape(coef3,nclus,size(init,1))')
end
termino=1;
warndlg('The process has ended')
end
catch
    warndlg('There is a problem with the configuration. Check the environmental variables time (match that of the set information (e.j.: Sva or Ih, etc)','Configuration problem','replace')
end



function pushb44_Callback(hObject, eventdata, handles)
try
nume=seteoNombresStrings(handles);
AA=get(handles.table1,'Data');
AA=array2table(AA,'VariableNames',nume);
AA.TIME=datetime(datevec(AA.TIME));
AA=table2timetable(AA);
yy=get(handles.popupm6,'Value');
plot(AA.TIME,AA{:,yy},'LineStyle','none','Marker','o','MarkerEdgeColor','b','MarkerSize',2,'Parent',handles.axes1)
plot(AA.TIME,AA{:,yy},'LineStyle','none','Marker','o','MarkerEdgeColor','b','MarkerSize',2,'Parent',handles.axes11)
plot(AA.TIME,AA{:,yy},'LineStyle','none','Marker','o','MarkerEdgeColor','b','MarkerSize',2,'Parent',handles.axes16)
catch
warndlg('The data could be corrupted for plot. Make sure to make it handable')
end



function popupm6_Callback(hObject, eventdata, handles)
set(handles.popupm2,'Value',get(handles.popupm6,'Value'))

function popupm6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushb45.
function pushb45_Callback(hObject, eventdata, handles)
    
function edit39_Callback(hObject, eventdata, handles)

function edit39_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit40_Callback(hObject, eventdata, handles)

function edit40_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushb46.
function pushb46_Callback(hObject, eventdata, handles)



function popupmForecastingDays_Callback(hObject, eventdata, handles)
filas=get(handles.popupmForecastingDays,'Value');
E=getappdata(0,'E');
V=getappdata(0,'V');
if isempty(E)==0 
    Origen=datenum(E.TIME(end,1));
elseif isempty(V)==0 && isempty(E)==1
    Origen=datenum(V.TIME(end,1));
else
    Origen=datenum(str2num(get(handles.edit51,'String')),str2num(get(handles.edit52,'String')),str2num(get(handles.edit54,'String')));
end
nclus=str2num(get(handles.edit25,'String'));
A9=get(handles.uitableWeatherPrediction,'Data');
dataActual=get(handles.uitableWeatherPrediction,'Data');
if size(dataActual,1)>filas
dataFinal=dataActual(1:filas,:);
elseif size(dataActual,1)<filas
    dataFinal=[dataActual; zeros(filas-size(dataActual,1),size(dataActual,2))];
    dataFinal(:,1)=[Origen+1:1:Origen+filas]';
else
    dataFinal=dataActual;
end
set(handles.uitableWeatherPrediction,'Data',dataFinal);


function popupmForecastingDays_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)

function popupmenu8_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu9_Callback(hObject, eventdata, handles)

function popupmenu9_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit41_Callback(hObject, eventdata, handles)

function edit41_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit42_Callback(hObject, eventdata, handles)

function edit42_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton47.
function pushbutton47_Callback(hObject, eventdata, handles)
task=find([get(handles.radiob36,'Value') get(handles.radiob37,'Value') get(handles.radiob53,'Value')]==1);
nclus=str2double(get(handles.edit25,'String'));
nenv=str2double(get(handles.edit119,'String'));
inittime=datenum(str2double(get(handles.edit51,'String')),str2double(get(handles.edit52,'String')),str2double(get(handles.edit54,'String')));
timerange=[str2double(get(handles.edit45,'String'))+inittime:1:str2double(get(handles.edit46,'String'))+inittime];
nume={'All'};

if task==1 || task==4 
    q=get(handles.uitable13,'Data');
    param=get(handles.uitable9,'Data');
    init=get(handles.uitable10,'Data');
    [PARAM,Q,INIT,~,~,~]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);
    INITIAL=[];
    for i=1:8
        for j=1:nclus
            INITIAL=[INITIAL; INIT(i,j)];
        end
    end
    Q(isnan(Q))=0; % makes the variables NaN equal to zero.
    PARAM(isnan(PARAM))=0;
    INITIAL(isnan(INITIAL))=0;
    Nh=PARAM(1,:);
    Nv=PARAM(2,:);
    Uv=PARAM(3,:);
    Uh=PARAM(4,:);
    Kv=PARAM(5,:);
    Kh=PARAM(6,:);
    Gama=PARAM(7,:);
    Alpha=PARAM(8,:);
    Pv=PARAM(9,:);
    Ph=PARAM(10,:);
    Tau=PARAM(11,:);
    results=ODEs(1,timerange,nclus,Nh,Nv,Q,Uv,Uh,Kv,Kh,Gama,Alpha,Pv,Ph,Tau,INITIAL);
    for i=1:nclus
        nume{end+1}=strcat('Sh',num2str(i));
    end
    for i=1:nclus
        nume{end+1}=strcat('Sv',num2str(i));
    end
    for i=1:nclus
        nume{end+1}=strcat('Ih',num2str(i));
    end
    for i=1:nclus
        nume{end+1}=strcat('Iv',num2str(i));
    end
    for i=1:nclus
        nume{end+1}=strcat('Eh',num2str(i));
    end
    for i=1:nclus
        nume{end+1}=strcat('Ev',num2str(i));
    end
    for i=1:nclus
        nume{end+1}=strcat('Rh',num2str(i));
    end
    for i=1:nclus
        nume{end+1}=strcat('Ch',num2str(i));
    end

elseif task==2 || task==5
    try
        q=get(handles.uitable23,'Data');
        param=get(handles.uitable21,'Data');
        init=get(handles.uitable22,'Data');
        temp=get(handles.uitable42,'Data');
        [PARAM,Q,INIT,~,~,~]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);
        INITIAL=[];
        for i=1:12
            for j=1:nclus
                INITIAL=[INITIAL; INIT(i,j)];
            end
        end
        Q(isnan(Q))=0; % makes the variables NaN equal to zero.
        PARAM(isnan(PARAM))=0;
        INITIAL(isnan(INITIAL))=0; 
        Nh=PARAM(1,:);
        Uh=PARAM(2,:);
        Kv=PARAM(3,:);
        Kh=PARAM(4,:);
        Gama=PARAM(5,:);
        Alpha=PARAM(6,:);
        Pv=PARAM(7,:);
        Ph=PARAM(8,:);
        Tau=PARAM(9,:);   
        ko=PARAM(10,:);
        ep=PARAM(11,:);
        Tp=PARAM(12,:);
        Tl=PARAM(13,:);
        Ti=PARAM(14,:);
        Te=PARAM(15,:);
        Pre01=PARAM(16,:);
        Pre02=PARAM(17,:);
        Pre03=PARAM(18,:);
        mu1=[];
        mu2=[];
        mu3=[];
        mu4=[];
        mu5=[];
        mu6=[];
        for i=1:nenv
        mu1=[mu1 PARAM(18+i,:)];
        mu2=[mu2 PARAM(18+i+nenv,:)];
        mu3=[mu3 PARAM(18+i+2*nenv,:)];
        mu4=[mu4 PARAM(18+i+3*nenv,:)];
        mu5=[mu5 PARAM(18+i+4*nenv,:)];
        mu6=[mu6 PARAM(18+i+5*nenv,:)];
        end
        results=ODEs(2, timerange, nclus, temp, Q, Nh, Uh, Kv, Kh, Gama, Alpha, Pv, Ph, Tau, ko, ep,Tp, Tl, Ti, Te, Pre01, Pre02, Pre03, mu1, mu2,mu3, mu4,mu5,mu6,INITIAL,0,nenv);
        for i=1:nclus
            nume{end+1}=strcat('Sh',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('Sva',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('Ih',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('Iv',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('Eh',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('Ev',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('Rh',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('Cv',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('E',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('L',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('P',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('Svi',num2str(i));
        end
        for i=1:nclus
            for j=1:nenv
            nume{end+1}=strcat('EnvVar',num2str(j),'Clus',num2str(i));
            end
        end    
        
     interT=zeros(size(results,1),nclus*nenv);
        
            for i=1:nclus
                for k=1:size(results,1)
                    for j=1:nenv
                        interT(k,(i-1)*nenv+j)=interp1(temp(:,1),temp(:,nenv*(i-1)+j+1),results(k,1));
                    end
                end
            end
            results=[results interT];      
        
    catch
        opts=struct('WindowStyle','replace','Interpreter','tex');
        warndlg('Make sure the \bf Environmental Variables \rm is seted correctly (\it 1 per cluster and 1 per environmental condtion \rm) and that all the \bf parameters \rm are specified in a simulation','Setting Configuration Problem',opts)   
    end
   
elseif task == 3 || task==6
    try
        param=get(handles.uitable18,'Data');
        init=get(handles.uitable19,'Data');
        temp=get(handles.uitable42,'Data');
        [PARAM,~,INIT,~,~,~]=EvaluarMatrix(size(param,1),size(init,1),param,[],init,nclus);
        INITIAL=[];
        for i=1:5
            for j=1:nclus
                INITIAL=[INITIAL; INIT(i,j)];
            end
        end
        PARAM(isnan(PARAM))=0;
        INITIAL(isnan(INITIAL))=0;
        ko=PARAM(1,:);
        ep=PARAM(2,:);
        Tp=PARAM(3,:);
        Tl=PARAM(4,:);
        Ti=PARAM(5,:);
        Te=PARAM(6,:);
        Pre01=PARAM(7,:);
        Pre02=PARAM(8,:);
        Pre03=PARAM(9,:);      
        mu1=[];
        mu2=[];
        mu3=[];
        mu4=[];
        mu5=[];
        mu6=[];
        for i=1:nenv
        mu1=[mu1 PARAM(9+i,:)];
        mu2=[mu2 PARAM(9+i+nenv,:)];
        mu3=[mu3 PARAM(9+i+2*nenv,:)];
        mu4=[mu4 PARAM(9+i+3*nenv,:)];
        mu5=[mu5 PARAM(9+i+4*nenv,:)];
        mu6=[mu6 PARAM(9+i+5*nenv,:)];
        end 
        
        results=ODEs(3,timerange,nclus,temp,ko,ep,Tp,Tl,Ti,Te,Pre01,Pre02,Pre03,mu1,mu2,mu3,mu4,mu5,mu6,INITIAL,0,nenv);
        for i=1:nclus
            nume{end+1}=strcat('E',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('L',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('P',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('Svi',num2str(i));
        end
        for i=1:nclus
            nume{end+1}=strcat('Sva',num2str(i));
        end
        for i=1:nclus
            for j=1:nenv
            nume{end+1}=strcat('EnvVar',num2str(j),'Clus',num2str(i));
            end
        end
        
        
            interT=zeros(size(results,1),nclus*nenv);
        
            for i=1:nclus
                for k=1:size(results,1)
                    for j=1:nenv
                        interT(k,(i-1)*nenv+j)=interp1(temp(:,1),temp(:,j+1),results(k,1));
                    end
                end
            end
            results=[results interT];
        
    catch
        warndlg('Make sure the temperature is seted and that all the parameters are specified in a simulation')   
    end
end
try
set(handles.popupm10,'String',char(nume{1:end}))
nume{1}='TIME';
Prueba=array2table(results,'VariableNames',nume);
Prueba.TIME=datetime(datevec(Prueba.TIME));
plot(Prueba.TIME,Prueba{:,2:end},'Marker','o','MarkerSize',2,'Parent',handles.axes18)

axes(handles.axes18);
legend('hide')
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('Simulation Results')
xlabel('Time')  
ylim auto


set(handles.uitable44,'ColumnName',nume)
set(handles.uitable44,'Data',results)
%Salida2=array2table(results,'VariableNames',nume);
setappdata(0,'SimResults2',Prueba)
%%% this goes for the simulations only
if task==1 || task==4
results1=[results(:,1) results(:,7*nclus+2:8*nclus+1)];% this +1 es given since in the results the time is saved
results3=[results(:,1) results(:,2*nclus+2:3*nclus+1)];
nombres={nume{1} nume{7*nclus+2:8*nclus+1}};
nombres3={nume{1} nume{2*nclus+2:3*nclus+1}};
elseif task==2 || task==5
results1=[results(:,1) results(:,7*nclus+2:8*nclus+1)];
nombres={nume{1} nume{7*nclus+2:8*nclus+1}};
results3=[results(:,1) results(:,2*nclus+2:3*nclus+1)];
nombres3={nume{1} nume{2*nclus+2:3*nclus+1}};
elseif task==3 || task==6
results1=[results(:,1) results(:,4*nclus+2:5*nclus+1)];
nombres={nume{1} nume{4*nclus+2:5*nclus+1}};
nombres3=[];
results3=[];
end
Salida=array2table(results1,'VariableNames',nombres);
Salida.TIME=datetime((datevec(Salida.TIME)));
    try
        Salida3=array2table(results3,'VariableNames',nombres3);
        Salida3.TIME=datetime((datevec(Salida.TIME)));
        setappdata(0,'SimResults3',Salida3)
    catch
    end
setappdata(0,'SimResults',Salida)

catch
warndlg('Set the time correctly') 
end


function pushbutton48_Callback(hObject, eventdata, handles)

function pushb49_Callback(hObject, eventdata, handles)
set(handles.text46,'BackgroundColor',[1 0.5 0])
set(handles.text47,'BackgroundColor',[1 0.5 0])
set(handles.text48,'BackgroundColor',[1 0.5 0])
set(handles.text49,'BackgroundColor',[1 0.5 0])
setappdata(0,'A',[])
setappdata(0,'AA',[])
setappdata(0,'ts',[])
setappdata(0,'tsM',[])
setappdata(0,'T',[])
setappdata(0,'Q',[])
setappdata(0,'V',[])
setappdata(0,'E',[])
setappdata(0,'F',[])
set(handles.pushbForecast,'Enable','off')
set(handles.pushbutton81,'Enable','off')
set(handles.popupm15,'Enable','off')
axes(handles.axes1);
cla reset;
axes(handles.axes11);
cla reset;
axes(handles.axes16);
cla reset;
set(handles.table1, 'Data', cell(size(get(handles.table1,'Data'))));

function pushb50_Callback(hObject, eventdata, handles)
try
    if eventdata~=1 && eventdata~=2 && eventdata~=3 && eventdata~=4
    [file,path]=uigetfile('*.mat');
    set(handles.edit43,'String',file)
        name=strcat(path,file);
    elseif eventdata==1
        name='C:\Users\evyhmeister\Desktop\Dengue mode\iquitos1.mat';    
    elseif eventdata==2
        name='C:\Users\evyhmeister\Desktop\Dengue mode\iquitos2.mat';        
    elseif eventdata==3
        name='C:\Users\evyhmeister\Desktop\Dengue mode\iquitos3.mat';                        
    elseif eventdata==4
        name='C:\Users\evyhmeister\Desktop\Dengue mode\iquitos4.mat';
    end
    Info=load(name);
    numclus=Info.VAR{1};
    set(handles.edit25,'String',numclus)
    edit25_Callback(@edit25_Callback,eventdata,handles)
    modelo=Info.VAR{2};   
    if modelo(1)==1
    set(handles.uitable9,'Data',Info.VAR{3});
    set(handles.uitable13,'Data',Info.VAR{4});    
    set(handles.uitable10,'Data',Info.VAR{5});
    set(handles.radiob36,'value',1);
    radiob36_Callback(@radiob36_Callback, eventdata, handles);
    elseif modelo(2)==1
    set(handles.uitable21,'Data',Info.VAR{3})
    set(handles.uitable23,'Data',Info.VAR{4})    
    set(handles.uitable22,'Data',Info.VAR{5})
    set(handles.radiob37,'value',1)
    radiob37_Callback(@radiob37_Callback, eventdata, handles);
    elseif modelo(3)==1
    set(handles.uitable18,'Data',Info.VAR{3})    
    set(handles.uitable19,'Data',Info.VAR{5})
    set(handles.radiob53,'value',1)
    radiob53_Callback(@radiob53_Callback, eventdata, handles);
    %elseif modelo(4)==1
    %set(handles.uitable9,'Data',Info.VAR{3})
    %set(handles.uitable13,'Data',Info.VAR{4})    
    %set(handles.uitable10,'Data',Info.VAR{5})
    %set(handles.radiobStochasticSERISEI,'value',1)
    %radiobStochasticSERISEI_Callback(@radiobStochasticSERISEI_Callback, eventdata, handles);
    %elseif modelo(5)==1
    %set(handles.uitable21,'Data',Info.VAR{3})
    %set(handles.uitable23,'Data',Info.VAR{4})    
    %set(handles.uitable22,'Data',Info.VAR{5})
    %set(handles.radiobStochasticSERILSEI,'value',1)
    %radiobStochasticSERILSEI_Callback(@radiobStochasticSERILSEI_Callback, eventdata, handles);
    %elseif modelo(6)==1
    %set(handles.uitable18,'Data',Info.VAR{3})    
    %set(handles.uitable19,'Data',Info.VAR{5})
    %set(handles.radiob52,'value',1)
    %radiob52_Callback(@radiob52_Callback, eventdata, handles);
    end
    edit25_Callback(@edit25_Callback, eventdata, handles);
catch error
   if error.identifier~='MATLAB:load:emptyFileName'
   warndlg('The Selected file is out of format or corrupted')
   end
end

function pushb51_Callback(hObject, eventdata, handles)
var0=get(handles.edit25,'String');
var1=[get(handles.radiob36,'Value') get(handles.radiob37,'Value') get(handles.radiob53,'Value')];
if var1(1)==1
var2=get(handles.uitable9,'Data');
var3=get(handles.uitable13,'Data');
var4=get(handles.uitable10,'Data');
elseif var1(2)==1
var2=get(handles.uitable21,'Data');
var3=get(handles.uitable23,'Data');
var4=get(handles.uitable22,'Data');
elseif var1(3)==1
var2=get(handles.uitable18,'Data');
var3=[];
var4=get(handles.uitable19,'Data');
end
name=strcat(get(handles.edit43,'String'),'.mat');
VAR={var0 var1 var2 var3 var4};
save(name,'VAR')   
warndlg(strcat('The parameters have been saved as: ',name))
handles.data.Q=var3;

function edit43_Callback(hObject, eventdata, handles)


function edit43_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupm10_Callback(hObject, eventdata, handles)

function popupm10_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton53_Callback(hObject, eventdata, handles)




function edit45_Callback(hObject, eventdata, handles)

function edit45_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit46_Callback(hObject, eventdata, handles)

function edit46_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton54_Callback(hObject, eventdata, handles)

function checkbox10_Callback(hObject, eventdata, handles)


function edit48_Callback(hObject, eventdata, handles)
set(handles.edit50,'String',get(handles.edit48,'String'))
set(handles.radiob87,'Value',1)
set(handles.radiobutton90,'Value',1)
radiob87_Callback(@radiob87_Callback, eventdata, handles)


function edit48_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiob87.
function radiob87_Callback(hObject, eventdata, handles)
nclus=str2double(get(handles.edit22,'String'));
nenv=str2double(get(handles.edit119,'String'));
tbase=datenum(str2double(get(handles.edit51,'String')),str2double(get(handles.edit52,'String')),str2double(get(handles.edit54,'String')));
J=[str2double(get(handles.edit45,'String')):1:str2double(get(handles.edit46,'String'))]';
J=J+tbase;
inputT=str2num(get(handles.edit48,'String'));
if numel(inputT)==nenv*nclus
    A=[J repmat(inputT,[numel(J),1])];
elseif numel(inputT)==1 && nenv*nclus>1
    A=[J ones(size(J,1),nenv*nclus)*inputT];
elseif numel(inputT)>nenv*nclus
    FF=repmat(inputT,numel(J),1);
    A=[J FF(:,1:nenv*nclus)];
elseif numel(inputT)<nenv*nclus
    diff=nenv*nclus-numel(inputT);
    A=[J repmat(inputT,[numel(J)],1) ones(size(J,1),diff).*inputT(1:diff)];
end
%temp=[str2double(get(handles.edit45,'String')) A; str2double(get(handles.edit46,'String')) A];
set(handles.uitable42,'Data',A)
set(handles.uitable47,'Data',A)
set(handles.radiobutton90,'Value',1)





function edit49_Callback(hObject, eventdata, handles)

function edit49_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radiob89_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton55.
function pushbutton55_Callback(hObject, eventdata, handles)
if get(handles.radiob89,'Value')==1
data=get(handles.uitable42,'data');
newrow=zeros(1,size(data,2));
data=[data; newrow];
set(handles.uitable42,'data',data);
set(handles.uitable47,'data',data);
end


% --- Executes on button press in radiob88.
function radiob88_Callback(hObject, eventdata, handles)
    temp=getappdata(0,'T');
    if isempty(temp)==1
        warndlg('The temperature matrix have not been loaded yet')
    else
    ts=datenum(temp.TIME);
    ts(:,2:size(temp,2))=temp{:,2:size(temp,2)};
    set(handles.uitable42,'Data',ts)
    set(handles.uitable47,'Data',ts)
    end



function edit50_Callback(hObject, eventdata, handles)
set(handles.edit48,'String',get(handles.edit50,'String'))
set(handles.radiob87,'Value',1)
set(handles.radiobutton90,'Value',1)
radiobutton90_Callback(@radiobutton90_Callback, eventdata, handles)

function edit50_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushb56_Callback(hObject, eventdata, handles)


% --- Executes on button press in radiob91.
function radiob91_Callback(hObject, eventdata, handles)
    temp=getappdata(0,'T');
    if isempty(temp)==1
        warndlg('The temperature matrix have not been loaded yet')
    else
    tsM=datenum(temp.TIME);
    tsM(:,2:size(temp,2))=temp{:,2:size(temp,2)};
    set(handles.uitable42,'Data',tsM)
    set(handles.uitable47,'Data',tsM) 
    end


% --- Executes on button press in radiobutton90.

function radiobutton90_Callback(hObject, eventdata, handles)
try
nclus=str2double(get(handles.edit22,'String'));
nenv=str2double(get(handles.edit119,'String'));
info2=getappdata(0,'T');
info1=getappdata(0,'E');
if isempty(info2)==0
J=[datenum(info2{1,1}):1:datenum(info2{end,1})]';
elseif isempty(info1)==0
J=[datenum(info1{1,1}):1:datenum(info1{end,1})]';
else
tbase=datenum(str2double(get(handles.edit51,'String')),str2double(get(handles.edit52,'String')),str2double(get(handles.edit54,'String')));
J=[str2double(get(handles.edit45,'String')):1:str2double(get(handles.edit46,'String'))]';
J=J+tbase;
end
inputT=str2num(get(handles.edit50,'String'));

if numel(inputT)==nenv*nclus
    A=[J repmat(inputT,[numel(J),1])];
elseif (numel(inputT)==1 && nenv*nclus>1) 
    A=[J ones(size(J,1),nenv*nclus)*inputT];
elseif numel(inputT)>nenv*nclus
    FF=repmat(inputT,numel(J),1);
    A=[J FF(:,1:nenv*nclus)];
elseif numel(inputT)<nenv*nclus
    diff=nenv*nclus-numel(inputT);
    A=[J repmat(inputT,[numel(J)],1) ones(size(J,1),diff).*inputT(1:diff)];
end
set(handles.uitable42,'Data',A)
set(handles.uitable47,'Data',A)
set(handles.radiob87,'Value',1)
catch
   warndlg('Make sure that you are setting the data correctly') 
end



%function radiob52_CreateFcn(hObject,eventdata, handles)


% --- Executes on button press in text50.
function text50_Callback(hObject, eventdata, handles)


% --- Executes when entered data in editable cell(s) in uitable18.
function uitable18_CellEditCallback(hObject, eventdata, handles)
DOF(handles)

% --- Executes when entered data in editable cell(s) in uitable9.
function uitable9_CellEditCallback(hObject, eventdata, handles)
DOF(handles)

% --- Executes when entered data in editable cell(s) in uitable21.
function uitable21_CellEditCallback(hObject, eventdata, handles)
DOF(handles)


% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)

function edit51_Callback(hObject, eventdata, handles)
popupmForecastingDays_Callback(@popupmForecastingDays_Callback, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit51_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit52_Callback(hObject, eventdata, handles)
popupmForecastingDays_Callback(@popupmForecastingDays_Callback, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit52_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit53_Callback(hObject, eventdata, handles)

function edit53_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit54_Callback(hObject, eventdata, handles)
popupmForecastingDays_Callback(@popupmForecastingDays_Callback, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit54_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton58.
function pushbutton58_Callback(hObject, eventdata, handles)
    
FF=get(handles.uitable44,'Data');
yy=get(handles.popupm10,'Value');
Fecha=[str2double(get(handles.edit51,'String')), str2double(get(handles.edit52,'String')), str2double(get(handles.edit54,'String'))];
Fecha=datenum(Fecha);
Info=zeros(size(FF,1),1);
for i=1:size(FF,1)
Info(i,1)=FF(i,1)+Fecha;
end
Info=[Info FF(:,2:end)];
Prueba=array2table(Info);
Prueba.Info1=datetime(datevec(Prueba.Info1));

if yy==1
plot(Prueba.Info1,Prueba{:,2:end},'LineStyle','none','Marker','o','MarkerSize',2,'Parent',handles.axes18);
else
plot(Prueba.Info1,Prueba{:,yy},'LineStyle','none','Marker','o','MarkerSize',2,'Parent',handles.axes18); 
end

axes(handles.axes18);
legend('hide')
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('Simulation Results')
xlabel('Time')  
ylim auto



function radiob63_Callback(hObject, eventdata, handles)
set(handles.radiobCAccumulated,'Value',1)

% --- Executes on button press in radiobutton92.
function radiobutton92_Callback(hObject, eventdata, handles)


% --- Executes on button press in pushb59.
function pushb59_Callback(hObject, eventdata, handles)

function edit57_Callback(hObject, eventdata, handles)


function edit57_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbForecast_Callback(hObject, eventdata, handles)
recorredor=0;
while recorredor==0
ForeDays=get(handles.popupmForecastingDays,'Value');
initialdaySelection=get(handles.popupm28,'Value');
initialdays=get(handles.popupm28,'String');
nclus=str2double(get(handles.edit25,'String'));
nenv=str2double(get(handles.edit119,'String'));
BackDays=str2double(get(handles.editBackwardDays,'String'));
sistema=[get(handles.radiob36,'Value') get(handles.radiob37,'Value') get(handles.radiob53,'Value')==1];
E=getappdata(0,'E');
V=getappdata(0,'V');
T=getappdata(0,'T');
A=getappdata(0,'A');
Fores=getappdata(0,'F');
optimizoQ=get(handles.checkbox11,'Value')==1;

if isempty(T)==1 || get(handles.radiob87,'Value')==1
    TEMP=get(handles.uitable42,'Data');
else
    TEMP=T(:,1:nclus+nenv);
    TEMP.TIME=datenum(TEMP.TIME);
    TEMP=table2array(TEMP);
end
if get(handles.checkbox22,'Value')==1
   datosT=get(handles.uitableWeatherPrediction,'Data');
    for i=1:size(datosT)
       if isempty(finde(find(TEMP(:,1)==datosT(i,1))))==1  
          TEMP=[TEMP; datosT];  
       end
    end
      TEMP=sortrows(TEMP);  
end

if find(sistema==1)==1 && isempty(E)==0 && get(handles.radiobARIMA,'Value')~=1
    q=get(handles.uitable13,'Data');
    param=get(handles.uitable9,'Data');
    init=get(handles.uitable10,'Data');
    try
        MOM=E(:,1:nclus+1);
    catch
        warndlg('The number of clusters is not set based on the information set','','replace')
    break
    end
    TEMP=[];
    [PARAM,Q,INIT,SETEO1,SETEO2,SETEO3]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);
elseif find(sistema==1)==2 && isempty(E)==0 && get(handles.radiobARIMA,'Value')~=1
    q=get(handles.uitable23,'Data');
    param=get(handles.uitable21,'Data');
    init=get(handles.uitable22,'Data');
    try
    MOM=E(:,1:nclus+1);
    catch
    warndlg('The number of clusters is not set based on the information set','','replace')
    break
    end
    [PARAM,Q,INIT,SETEO1,SETEO2,SETEO3]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);   
elseif find(sistema==1)==3 && isempty(V)==0 && get(handles.radiobARIMA,'Value')~=1
    param=get(handles.uitable18,'Data');
    init=get(handles.uitable19,'Data');  
    [PARAM,Q,INIT,SETEO1,SETEO2,SETEO3]=EvaluarMatrix(size(param,1),size(init,1),param,[],init,nclus);   
    q=[];
    try
    MOM=V(:,1:nclus+1);
    catch
    warndlg('The number of clusters is not set based on the information set and is not relevant to Vector model (set it as 1)','Configuration Problem','replace')
    break
    end
elseif get(handles.radiobARIMA,'Value')==1
    MOM=[];
else
    warndlg('The vecto infomation or host information have not been set correctly in the load pannel','Configuration Problem','replace')
break
end

if isempty(MOM)==0 %&& get(handles.radiobARIMA,'Value')~=1
%xlims=[datenum(MOM.TIME(end))-BackDays, datenum(MOM.TIME(end))];
try
xlims=[datenum(initialdays(initialdaySelection,1))-BackDays, datenum(initialdays(initialdaySelection,1))];
catch
    warndlg('The information set do not include time variables','Information Missing','replace')
end
MOM.TIME=datenum(MOM.TIME);
[~,ind1] = min(abs(xlims(1)-MOM.TIME));
[~,ind2] = min(abs(xlims(2)-MOM.TIME));
%%%%%%%%%%%%%%%%%%%%%%%    
xdata=MOM.TIME(ind1:ind2,1);
ydata=cell2mat(table2cell(MOM(ind1:ind2,2:end)));
Xdata=[xdata; (xdata(end)+1:1:xdata(end)+ForeDays)'];
end

try
if get(handles.radiobODEs,'Value')==1 && get(handles.radiobNoFiltering,'Value')==1
    results=ODEs(7,sistema,nclus,BackDays,ForeDays,E,V,TEMP,A,q,param,init,Q,PARAM,INIT,optimizoQ,handles,xdata,ydata,Xdata,SETEO1,SETEO2,SETEO3,nenv);
    resultsFORE=results{1};
    %coef=results{2};
    %coef2=results{3};
    %coef3=results{4};
    if  find(sistema==1)==1
        %%%%%%%%%%%% SEIRSEI
        %if isempty(coef3)==0
        %set(handles.uitable30,'Data',reshape(coef,nclus,11)')
        %set(handles.uitable83,'Data',reshape(coef2,nclus,nclus)')
        %set(handles.uitable87,'Data',reshape(coef3,nclus,8)')
        %pushbTransferResults_Callback(hObject, eventdata, handles)
        %end
        TransferirParameters(results,nclus,handles)
        if get(handles.radiobInfectedHost,'Value')==1
            Ys=resultsFORE(:,2*nclus+2:3*nclus+1);  
            Tipo='E';
        elseif get(handles.radiobCAccumulated,'Value')==1
            Ys=resultsFORE(:,7*nclus+2:8*nclus+1);
            Tipo='E';
        end
        %%%%%%%%%%%%% SEIRLSEI
    elseif find(sistema==1)==2
        %if isempty(coef3)==0
        %set(handles.uitable52,'Data',reshape(coef,nclus,24)')
        %set(handles.uitable84,'Data',reshape(coef2,nclus,nclus)')
        %set(handles.uitable85,'Data',reshape(coef3,nclus,12)')
        %pushbTransferResults_Callback(hObject, eventdata, handles)
        %end
        TransferirParameters(results,nclus,handles)
        
        if get(handles.radiobInfectedHost,'Value')==1
            Ys=resultsFORE(:,2*nclus+2:3*nclus+1);    
            Tipo='E';
        elseif get(handles.radiobCAccumulated,'Value')==1
            Ys=resultsFORE(:,7*nclus+2:8*nclus+1);
            Tipo='E';
        elseif get(handles.radiob124, 'Value')==1
            Ys=resultsFORE(:,nclus+2:2*nclus+1);
            Tipo='V';
        end
        %%%%%%%%%%%%% LSEI
    elseif find(sistema==1)==3 
        %if isempty(coef3)==0
        %set(handles.uitable53,'Data',reshape(coef,nclus,15)')
        %set(handles.uitable86,'Data',reshape(coef3,nclus,5)')
        %pushbTransferResults_Callback(hObject, eventdata, handles)
        %end
        TransferirParameters(results,nclus,handles)
        
        if get(handles.radiob121, 'Value')==1
            Ys=resultsFORE(:,2:nclus+1);
            Tipo='V';
        elseif get(handles.radiob122,'Value')==1
            Ys=resultsFORE(:,nclus+2:2*nclus+1);  
            Tipo='V';
        elseif get(handles.radiob123,'Value')==1
            Ys=resultsFORE(:,2*nclus+2:3*nclus+1);  
            Tipo='V';
        elseif get(handles.radiob124,'Value')==1
            Ys=resultsFORE(:,4*nclus+2:5*nclus+1);
            Tipo='V';
        end       
    end
   numSalidas=1; 
elseif get(handles.radiobODEs,'Value')==1 && get(handles.radiobEKF,'Value')==1 %%%%%EKF
   %Primero chequeo si el EKF esta creado sino termino proceso
   
 try
 %myEKF=handles.myEKF
 myEKF=getappdata(0,'myEKF');
 if isempty(myEKF)==1
     warndlg('You have to create first the filter before using it')
      break
 end
 
 catch
     warndlg('You have to create first the filter before using it')
      break
 end
if eventdata~=1 
    resultsFORE(1,:)=myEKF.State;
  for k=2:(size(xdata,1))
      setappdata(0,'TSPAN',[xdata(k), xdata(k)+1]) %This is to pass it to ODE11 or ODE9 that need the time to interpolate
      [xpredict,ppredict]=predict(myEKF); 
      [xcorrect,pcorrect]=correct(myEKF,ydata(k,:));    
      resultsFORE(k,:) =xcorrect; 
  end
  for j=size(xdata,1)+1:size(Xdata,1)
      setappdata(0,'TSPAN',[Xdata(j), Xdata(j)+1]) %This is to pass it to ODE11 or ODE9 that need the time to interpolate
      [xpredict,ppredict]=predict(myEKF);
      resultsFORE(j,:)=xpredict;      
  end   
elseif eventdata==1 && ForeDays==1
     datosEKF=getappdata(0,'DatosEKF');
     setappdata(0,'TSPAN',[Xdata(end), Xdata(end)+1]) %This is to pass it to ODE11 or ODE9 that need the time to interpolate
     ekfdata=ydata(end,:);
     [xcorrect,pcorrect]=correct(myEKF,ekfdata);
     [xpredict,ppredict]=predict(myEKF);  
     resultsFOREs(1,:)=xpredict;
     datosEKF(1,:)=[];
     resultsFORE=[datosEKF; resultsFOREs];
elseif (eventdata==1) && (ForeDays<=BackDays+1) && (ForeDays~=1)   
    datosEKF=getappdata(0,'DatosEKF');
    resultsFOREs=[];
    myEKF.State=datosEKF((size(xdata,1)-ForeDays+1),:);
    for k=(size(xdata,1)-ForeDays+1):size(xdata,1)      
        setappdata(0,'TSPAN',[xdata(k), xdata(k)+1])
        [xcorrect,pcorrect]=correct(myEKF,ydata(k,:));
        [xpredict,ppredict]=predict(myEKF); 
        resultsFOREs(end+1,:) =xpredict; 
    end
    for j=size(xdata,1)+1:size(Xdata,1)
        setappdata(0,'TSPAN',[Xdata(j), Xdata(j)+1]) %This is to pass it to ODE11 or ODE9 that need the time to interpolate
      [xpredict,ppredict]=predict(myEKF);
      resultsFOREs(end+1,:)=xpredict; 
    end
    datosEKF(1:size(resultsFOREs,1),:)=[];
    resultsFORE=[datosEKF; resultsFOREs];
elseif (eventdata==1) && (ForeDays>BackDays+1) && (ForeDays~=1)  
    
    warndlg('It is not possible to perform a joint forecast using particle filtering when there is a gap in the days used to correct simulation',' Forecasting Days cannot be higher than backward days','replace') 
    break
end

%%%%%% aqui deberia modificar las matrices 
set(handles.uitable63,'Data',myEKF.StateCovariance)
%%%%%%%%%%%
setappdata(0,'DatosEKF',resultsFORE)
    if get(handles.radiobInfectedHost,'Value')==1 && find(sistema==1)==1
            Ys=resultsFORE(:,2*nclus+1:3*nclus);
            Tipo='E';
    elseif get(handles.radiobCAccumulated,'Value')==1 && find(sistema==1)==1
            Ys=resultsFORE(:,7*nclus+1:8*nclus); 
            Tipo='E';
    elseif get(handles.radiobInfectedHost,'Value')==1 && find(sistema==1)==2
            Ys=resultsFORE(:,2*nclus+1:3*nclus);  
            Tipo='E';
    elseif get(handles.radiobCAccumulated,'Value')==1 && find(sistema==1)==2
            Ys=resultsFORE(:,7*nclus+1:8*nclus);
            Tipo='E';
    elseif get(handles.radiob124, 'Value')==1 && find(sistema==1)==2
            Ys=resultsFORE(:,nclus+1:2*nclus);
            Tipo='V';
    elseif get(handles.radiob121, 'Value')==1 && find(sistema==1)==3 
            Ys=resultsFORE(:,1:nclus);
            Tipo='V';
    elseif get(handles.radiob122,'Value')==1 && find(sistema==1)==3 
            Ys=resultsFORE(:,nclus+1:2*nclus);    
            Tipo='V';
    elseif get(handles.radiob123,'Value')==1 && find(sistema==1)==3 
            Ys=resultsFORE(:,2*nclus+1:3*nclus);         
            Tipo='V';
    elseif get(handles.radiob124,'Value')==1 && find(sistema==1)==3 
            Ys=resultsFORE(:,4*nclus+1:5*nclus);
            Tipo='V';
    end       
  
elseif get(handles.radiobODEs,'Value')==1 && get(handles.radiobPF,'Value')==1 %%%%%%PF
     %Primero chequeo si el PF esta creado sino termino proceso
  try
     %PF=handles.myPF; 
     myPF=getappdata(0,'myPF');
  catch
      warndlg('You have to create first the filter before using it','Configuration Problem','replace')
      break
  end  
  
    if eventdata ~=1
      resultsFORE(1,:)=myPF.State;
    for k=2:size(xdata,1)
       setappdata(0,'TSPAN',[xdata(k), xdata(k)+1]) %this is for ODE 13 or 14
       [xpredict]=predict(myPF); 
        resultsFORE(k,:)=correct(myPF,ydata(k,:));     
    end
    for j=size(xdata,1)+1:size(Xdata,1)
        setappdata(0,'TSPAN',[Xdata(j), Xdata(j)+1]) %This is to pass it to ODE13 or ODE14
        [xpredict]=predict(myPF);
         resultsFORE(j,:)=xpredict;      
    end
    
    elseif eventdata==1 && ForeDays==1
    datosPF=getappdata(0,'DatosPF');
    setappdata(0,'TSPAN',[Xdata(end), Xdata(end)+1])   
    [out]=correct(myPF,ydata(end,:));
    %%%%%%%%%%%%%
   % initialize(myPF,myPF.NumParticles,out,myPF.StateCovariance);
    %%%%%%%%%%%%%%%%%%
    resultsFOREs(1,:)=predict(myPF);  
     datosPF(1,:)=[];
     resultsFORE=[datosPF; resultsFOREs];
    
    elseif (eventdata==1)  && ForeDays~=1          
        datosPF=getappdata(0,'DatosPF');
        resultsFOREs=[];
        if ForeDays<=BackDays+1
            for k=(size(xdata,1)-ForeDays+1):size(xdata,1)        
                setappdata(0,'TSPAN',[xdata(k), xdata(k)+1]) %This is to pass it to ODE11 or ODE9 that need the time to interpolate
                [out]=correct(myPF,ydata(k,:)); 
                %%%%%%%%%%%%%
                % initialize(myPF,myPF.NumParticles,out,myPF.StateCovariance);
                %%%%%%%%%%%%%%%%%%
                resultsFOREs(end+1,:)=predict(myPF);       
            end
        else
           warndlg('The number of backward days in less than forecasting days, its not recommended for simulation purposes','Warning','replace') 
            for k=1:size(xdata,1)        
                setappdata(0,'TSPAN',[xdata(k), xdata(k)+1]) %This is to pass it to ODE11 or ODE9 that need the time to interpolate
                [out]=correct(myPF,ydata(k,:)); 
                %%%%%%%%%%%%%
                % initialize(myPF,myPF.NumParticles,out,myPF.StateCovariance);
                %%%%%%%%%%%%%%%%%%
                resultsFOREs(end+1,:)=predict(myPF);
            end
        end
        for j=size(xdata,1)+1:size(Xdata,1)
            setappdata(0,'TSPAN',[Xdata(j), Xdata(j)+1]) %This is to pass it to ODE11 or ODE9 that need the time to interpolate
            [xpredict,ppredict]=predict(myPF);
            resultsFOREs(end+1,:)=xpredict; 
        end
    datosPF(1:size(resultsFOREs,1),:)=[];
    resultsFORE=[datosPF; resultsFOREs];
    end   
    setappdata(0,'DatosPF',resultsFORE)
    
    if get(handles.radiobInfectedHost,'Value')==1 && find(sistema==1)==1
            Ys=resultsFORE(:,2*nclus+1:3*nclus);   
            Tipo='E';
    elseif get(handles.radiobCAccumulated,'Value')==1 && find(sistema==1)==1
            Ys=resultsFORE(:,7*nclus+1:8*nclus);
            Tipo='E';
    elseif get(handles.radiobInfectedHost,'Value')==1 && find(sistema==1)==2
            Ys=resultsFORE(:,2*nclus+1:3*nclus);
            Tipo='E';
    elseif get(handles.radiobCAccumulated,'Value')==1 && find(sistema==1)==2
            Ys=resultsFORE(:,7*nclus+1:8*nclus);
            Tipo='E';
    elseif get(handles.radiob124, 'Value')==1 && find(sistema==1)==2
            Ys=resultsFORE(:,nclus+1:2*nclus);
            Tipo='V';
    elseif get(handles.radiob121, 'Value')==1 && find(sistema==1)==3 
       Ys=resultsFORE(:,1:nclus);
            Tipo='V';
    elseif get(handles.radiob122,'Value')==1 && find(sistema==1)==3 
       Ys=resultsFORE(:,nclus+1:2*nclus);   
            Tipo='V';
    elseif get(handles.radiob123,'Value')==1 && find(sistema==1)==3 
       Ys=resultsFORE(:,2*nclus+1:3*nclus); 
            Tipo='V';
    elseif get(handles.radiob124,'Value')==1 && find(sistema==1)==3 
       Ys=resultsFORE(:,4*nclus+1:5*nclus);
            Tipo='V';
    end  
    
elseif get(handles.radiobARIMA,'Value')==1
    

estModel=handles.metricdata.estModel;
isLogTransform=handles.metricdata.isLogTransform;
numFutureSamples=get(handles.popupmForecastingDays,'Value');
numPaths=get(handles.popupmenu19,'Value');
x=handles.metricdata.data;
y=x;
if isLogTransform
    y=log10(x);
end
%%%%%%%%%%%%%%%%




%%%%%%%%% find minimum and maximum allowed values %%%%
%prompt={'Minimum value:','Maximum value:'};
%name='';
%numlines=1;
%defaultanswer={'',''}; 
%answer=inputdlg(prompt,name,numlines,defaultanswer);
%try
%   physicalLimitations(1)=str2num(answer{1});
%catch
%   physicalLimitations(1)=-10e30;
%end
%try
%   physicalLimitations(2)=str2num(answer{2});
%catch
%   physicalLimitations(2)=10e30;
%end
%minimum_value=physicalLimitations(1);
%maximum_value=physicalLimitations(2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
res = infer(estModel,y);
initial_vector=repmat(y,1,numPaths);
for futureSamples=1:numFutureSamples
    out(futureSamples,:)=simulate(estModel,1,'Y0',initial_vector,'NumPaths',numPaths,'E0',res);
    initial_vector=[repmat(y(futureSamples+1:end,1),1,numPaths);out(1:futureSamples,:)];
end

cla(handles.axes11)
axes(handles.axes11);
legend('hide')
plot(1:length(y),y,'linewidth',1);
hold on
plot(length(y):length(y)+numFutureSamples,[y(end)*ones(1,numPaths);out])
xlim([0 length(y)+numFutureSamples])
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('History and Forecast')
xlabel('Time (sample)')  
ylim auto
handles.metricdata.out=out;
set(handles.save,'Enable','on');
guidata(hObject, handles);  
set(handles.uitable43,'Data',out)
Fores{end+1}=out;
setappdata(0,'F',Fores);
recorredor=1;    
end
%catch
%    break
%end
if get(handles.radiobARIMA,'Value')~=1
resultsfinal=resultsFORE;
try
resultsfinal2=[Xdata Ys];
catch
    warndlg('There is no enough backward days','backward days','replace')
    break
end
resultsfinal2=array2table(resultsfinal2);
set(handles.uitable43,'Data',resultsfinal);
nume=seteoNombresStrings(handles);
resultsfinal2.Properties.VariableNames=nume;
resultsfinal2.TIME=datetime(datevec(resultsfinal2.TIME));
setappdata(0,'Fores1',resultsfinal)
setappdata(0,'Fores2',resultsfinal2)

if isempty(Fores)==1
Fores{1}=resultsfinal2;
setappdata(0,'F',Fores);
else
Fores{end+1}=resultsfinal2;
setappdata(0,'F',Fores);
end

set(handles.popupm15,'String',char(nume{2:end}))
set(handles.pushbutton81,'Enable','on')
set(handles.pushbutton146,'Enable','on')
set(handles.popupm15,'Enable','on')
set(handles.pushbSaveResultsForecasting,'Enable','on')

if get(handles.checkbox25,'Value')==1
    info1=resultsfinal2(end-ForeDays+1:end,:);
    if strcmp(Tipo,'E')==1
    find(E(:,1)==info1(1,1))
    E=[E; info1];
    Origen=datenum(E.TIME(end,1));
    setappdata(0,'E',E)
    elseif strcmp(Tipo,'V')==1
    V=[V; info1];
    setappdata(0,'V',V)
    Origen=datenum(V.TIME(end,1));
    end
    F=getappdata(0,'F');
    F{end}=[];
    F=F(~cellfun('isempty',F));
    setappdata(0,'F',F)
    filas=get(handles.popupmForecastingDays,'Value');
    dataActual=get(handles.uitableWeatherPrediction,'Data');
    dataFinal=[dataActual; zeros(filas-size(dataActual,1),size(dataActual,2))];
    dataFinal(:,1)=[Origen+1:1:Origen+filas]';
    set(handles.uitableWeatherPrediction,'Data',dataFinal);
end
MSE(handles,resultsfinal2,Tipo,nclus)
pushbutton81_Callback(@pushbutton81_Callback, eventdata, handles)
recorredor=1;
end
catch
    break
end

end




function pushbutton62_Callback(hObject, eventdata, handles)


function pushbutton63_Callback(hObject, eventdata, handles)


function pushbutton64_Callback(hObject, eventdata, handles)


function pushbutton65_Callback(hObject, eventdata, handles)


function pushbutton66_Callback(hObject, eventdata, handles)


function uitable19_CellEditCallback(hObject, eventdata, handles)
DOF(handles)

function uitable10_CellEditCallback(hObject, eventdata, handles)
DOF(handles)

function uitable22_CellEditCallback(hObject, eventdata, handles)
DOF(handles)


function pushbutton67_Callback(hObject, eventdata, handles)

function pushbutton68_Callback(hObject, eventdata, handles)

function pushb69_Callback(hObject, eventdata, handles)
info=get(handles.table1,'Data');
if get(handles.radiob1,'Value')==1
    if get(handles.radiob51,'Value')~=1 %&& get(handles.radiob139,'Value')~=1
    ts=zeros(size(info,1),size(info,2)-2);
    ts(:,1)=datenum(datetime(info(:,1),info(:,2),info(:,3)));
    ts(:,2:size(info,2)-3)=info(:,4:size(ts,2));
    if class(ts)=='double'
        A=cell2table(num2cell(ts));
    else
        A=cell2table(ts);
    end
    set(handles.radiob3,'Value',1);
    nume=seteoNombresStrings(handles);
    A.Properties.VariableNames=nume;
    A.TIME=datetime(datevec(A.TIME));
    end
else %estoy con datos estructurados
    ts=zeros(size(info,1),size(info,2));
    if get(handles.radiob51,'Value')~=1 %&& get(handles.radiob139,'Value')~=1
    ts(:,1)=datenum(datetime(datevec(info(:,1))));
    ts(:,2:end)=info(:,2:end);
        if class(info)=='double'
            A=cell2table(num2cell(info));
        else
            A=cell2table(info);
        end
        nume=seteoNombresStrings(handles);
        A.Properties.VariableNames=nume;
        A.TIME=datetime(datevec(ts(:,1)));
    end
        
end

if get(handles.radiob51,'Value')==0 %&& get(handles.radiob139,'Value')==0
AA=table2timetable(A);
AA=sortrows(AA);
AA=unique(AA);
A=timetable2table(AA);
tsM(:,1)=ts(:,1)-ts(1,1);
tsM(:,2:size(A,2))=A{:,2:size(A,2)};
setappdata(0,'A',A)
setappdata(0,'AA',AA)
setappdata(0,'ts',info)
setappdata(0,'tsM',tsM)
end
Nclus=str2double(get(handles.edit25,'String'));
%---------------- depending on the type of data, it is saved in a different
if get(handles.radiob49,'Value')==1
setappdata(0,'E',A)
set(handles.text46,'BackgroundColor',[0.9 1 1])
iniinfo=datevec(A.TIME(1,1));
largo=datenum(A.TIME(end,1))-datenum(A.TIME(1,1));
elseif get(handles.radiob50,'Value')==1
setappdata(0,'T',A)
set(handles.text47,'BackgroundColor',[0.9 1 1])
iniinfo=datevec(A.TIME(1,1));
largo=datenum(A.TIME(end,1))-datenum(A.TIME(1,1));
elseif get(handles.radiob51,'Value')==1
tamano=size(info,2);
set(handles.edit25,'String',num2str(tamano))
edit25_Callback(@edit25_Callback, eventdata, handles)
set(handles.text48,'BackgroundColor',[0.9 1 1])
set(handles.uitable13,'Data',info)
set(handles.uitable23,'Data',info)
elseif get(handles.radiob67,'Value')==1
setappdata(0,'V',A)
set(handles.text49,'BackgroundColor',[0.9 1 1])
iniinfo=datevec(A.TIME(1,1));
largo=datenum(A.TIME(end,1))-datenum(A.TIME(1,1));
%elseif get(handles.radiob135,'Value')==1
%    E=[A.TIME A(:,2:Nclus+1)];
%    V=[A.TIME A(:,Nclus+2:2*Nclus+1)];
%    T=[A.TIME A(:,2*Nclus+2:3*Nclus+1)];
%setappdata(0,'E',E)
%setappdata(0,'V',V)
%setappdata(0,'T',T)
%set(handles.text46,'BackgroundColor',[0.9 1 1])
%set(handles.text47,'BackgroundColor',[0.9 1 1])
%set(handles.text49,'BackgroundColor',[0.9 1 1])
%iniinfo=datevec(A.TIME(1,1));
%largo=datenum(A.TIME(end,1))-datenum(A.TIME(1,1));
%elseif get(handles.radiob139,'Value')==1
%    set(handles.textGeoreferencingData,'BackgroundColor',[0.9 1 1])
%    setappdata(0,'GEO',info)
%    setappdata(0,'AA',info)
end
set(handles.edit1,'String','')     
%set(handles.table1,'Data',ts) %tables can not handle time info so used ts
%seteandoTabla1('on',handles)
if get(handles.radiob49,'Value')==1 || get(handles.radiob50,'Value')==1 || get(handles.radiob67,'Value')==1 % || get(handles.radiob135,'Value')==1
    set(handles.edit45,'String','0')
    set(handles.edit46,'String',num2str(largo))
    set(handles.edit51,'String',num2str(iniinfo(1)))
    set(handles.edit52,'String',num2str(iniinfo(2)))
    set(handles.edit54,'String',num2str(iniinfo(3)))
end
edit25_Callback(@edit25_Callback,eventdata,handles)
pushb9_Callback(@pushb9_Callback, eventdata, handles)
set(handles.pushbForecast,'Enable','on')
set(handles.pushbutton148,'Enable','on')

if get(handles.radiobInfectedHost,'Value')==1 || get(handles.radiobCAccumulated,'Value')==1
fechas=getappdata(0,'E');
else
fechas=getappdata(0,'V');
end

if isempty(fechas)==0
fechas=cellstr(table2array(fechas(:,1)));
set(handles.popupm28,'String',fechas(:,1))

end
set(handles.popupm15,'String',char(nume{2:end}))

function edit59_Callback(hObject, eventdata, handles)

function edit59_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function uitable23_CellEditCallback(hObject, eventdata, handles)
DOF(handles)

function uitable13_CellEditCallback(hObject, eventdata, handles)
DOF(handles)

function pushbutton70_Callback(hObject, eventdata, handles)
try
A=get(handles.table1,'Data');
nume=seteoNombresStrings(handles);
A=array2table(A,'VariableNames',nume);
if exist(A.TIME)~=0
   A.TIME=datetime(datevec(A.TIME)); 
end
[filename filepath]=uiputfile('*.xlsx');
sim=strcat(filepath,filename);
writetable(A,sim);
catch 
    warndlg('Make sure that the simulation results exist and use a valid name')
end

function pushb7_CreateFcn(hObject, eventdata, handles)


function edit60_Callback(hObject, eventdata, handles)

function edit60_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function radiob67_Callback(hObject, eventdata, handles)
edit25_Callback(@edit25_Callback,eventdata,handles)




%function radiob68_Callback(hObject, eventdata, handles)
%edit25_Callback(@edit25_Callback,eventdata,handles)
%set(handles.uibuttong38,'Visible','off')


function popupmenu14_Callback(hObject, eventdata, handles)

function popupmenu14_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton72_Callback(hObject, eventdata, handles)


function editBackwardDays_Callback(hObject, eventdata, handles)

    
function editBackwardDays_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function radiobODEs_Callback(hObject, eventdata, handles)
set(handles.panelARIMA,'Visible','off')
set(handles.panelODEsOptions,'Visible','on')

% --- Executes on button press in radiobARIMA.
function radiobARIMA_Callback(hObject, eventdata, handles)
%set(handles.panelARIMA,'Visible','on')
set(handles.panelODEsOptions,'Visible','off')
set(handles.panelARIMA,'Visible','on')
%run('TSAF') %momentarily while I do not transfer all the information.

%%%%%%%%%

set(handles.lagsToPlot,'String','30');%
set(handles.seasonalityRemoved,'string',num2str(0)); %
set(handles.isLogTransform,'Value',0) %
set(handles.isMeanCorrected,'Value',0) %
set(handles.differentiation,'string',num2str(0)); %
set(handles.harmonics,'string',num2str(0)); %
set(handles.D,'string',num2str(0)); 
set(handles.Seasonality,'string',num2str(0));
handles.metricdata.lagsToPlot=30;
handles.metricdata.isLogTransform=false;
handles.metricdata.isMeanCorrected=false;
handles.metricdata.differentiation=0;
handles.metricdata.harmonics=0;
handles.metricdata.seasonalityRemoved=0;
handles.metricdata.D=0;
handles.metricdata.Seasonality=0;
handles.metricdata.isARLags=false;
handles.metricdata.isMALags=false;
handles.metricdata.isSARLags=false;
handles.metricdata.isSMALags=false;
handles.metricdata.isAR=false;
handles.metricdata.isMA=false;
handles.metricdata.isSAR=false;
handles.metricdata.isSMA=false;

num=get(handles.table1,'Data');
dataColumn=1;
    if (size(num,2)>1)
        msg=sprintf('Select the data column: \n');
        prompt= msg;
        name='';
        numlines=1;
        defaultanswer={'1'};
        answer=inputdlg(prompt,name,numlines,defaultanswer);
        try
            dataColumn=str2num(cell2mat(answer));
        catch
            return
        end
    end
 
    if (size(num,2)==0)
        errordlg('Your selected file includes no number.', 'Error');
        return 
    else
        try
            data=num(:,dataColumn);
            plot_all(data,hObject);
            handles.metricdata.data=data;
        catch
            msg=sprintf('Selected column containts no data! \n');
            errordlg(msg); 
        end
    end    
guidata(hObject, handles);



% --- Executes on button press in pushbutton71.
function pushbutton71_Callback(hObject, eventdata, handles)
try
data=get(handles.table1,'Data');
data2=getappdata(0,'A');
data3=getappdata(0,'AA');
if strcmp(get(handles.edit60,'String'),'')==1 || strcmp(get(handles.edit60,'String'),'0')==1 || strcmp(get(handles.edit60,'String'),'Row #')==1
data(end,:)=[];
data2{end,:}=[];
data3{end,:}=[];
else
 pivot=str2double(get(handles.edit60,'String'));
 data(pivot,:)=[];
 data2(pivot,:)=[];
 data3(pivot,:)=[];
end
set(handles.table1,'Data',data);
setappdata(0,'A',data2)
setappdata(0,'AA',data3)
pushb9_Callback(@push9_Callback, eventdata, handles)
set(handles.edit29,'string',num2str(data(1,1)))
set(handles.edit30,'string',num2str(data(end,1)))
catch
    warndlg('Cannot remove a line from that position')
end


%-------------------- funciones propiass --------------------
function seteandoTabla1(estado,handles)
    if strcmp(estado,'on')==1
        set(handles.pushb7,'visible','on')
        set(handles.popupm1,'visible','on')
    %    set(handles.pushb6,'visible','on')
     %   set(handles.edit20,'visible','on')
    %    set(handles.edit24,'visible', 'on') 
    else
        set(handles.pushb7,'visible','off')
        set(handles.popupm1,'visible','off')
   %     set(handles.pushb6,'visible','off')
    %    set(handles.edit20,'visible','off')
    %    set(handles.edit24,'visible', 'off') 

    end

    function matrizout=ValidarMatriz(matrizin) %esto es para el extended kalman filter cuando la matrix de covarianza es no simetrica y negativa
    [~, err]=cholcoved(matrizin,0);
    if err~=0
    [v, d]=eig(matrizin);
    v=real(v);
    d=real(d);
    d(d<=0)=1E-8;
    matrizout=real(v*d*v');
    else
    matrizout=matrizin;
    end
   
   function cof=translateLagsToCof(input,pair,condition)

temp=zeros(1,input(end));
index=1;
for i=input
     if(~condition)
          temp(i)=NaN;
     else
          temp(i)=pair(index);
     end
     index=index+1;
end

cof=num2cell(temp); 
    
    
    
function DOF(handles)
nclus=str2double(get(handles.edit25,'String'));
%nenvironmental=str2double(get(handles.edit119,'String'));
task=find([get(handles.radiob36,'Value') get(handles.radiob37,'Value') get(handles.radiob53,'Value')]==1);
if task==1
    param=get(handles.uitable9,'Data');
    param2=get(handles.uitable10,'Data');
    param3=get(handles.uitable13,'Data');
    PARAM=zeros(size(param,1),nclus);
    PARAM2=zeros(size(param2,1),nclus);
    PARAM3=zeros(nclus,nclus);
    for i=1:nclus
        for j=1:size(PARAM,1)
            if isempty(param{j,2+2*(i-1)})==1      
                PARAM(j,i)=0;
            else
                PARAM(j,i)=param{j,2+2*(i-1)};
            end
        end
        
        for j=1:size(PARAM2,1)
            if isempty(param2{j,2+2*(i-1)})==1
                PARAM2(j,i)=0;
            else
                PARAM2(j,i)=param2{j,2+2*(i-1)};
            end
        end
        for j=1:nclus
            if isempty(param3{j,2+2*(i-1)})==1
                PARAM3(j,i)=0;
            else
                PARAM3(j,i)=param3{j,2+2*(i-1)};
            end
        end
        
        
    end
    total=(size(PARAM,1)+size(PARAM2,1)+nclus)*nclus;
elseif task==2
    param=get(handles.uitable21,'Data');
    param2=get(handles.uitable22,'Data');
    param3=get(handles.uitable23,'Data');
    size1=size(param,1);
    size2=size(param2,1);
    PARAM=zeros(size1,nclus);
    PARAM2=zeros(size2,nclus);
    PARAM3=zeros(nclus,nclus);
    for i=1:nclus
        for j=1:size1
            if isempty(param{j,2+2*(i-1)})==1
               PARAM(j,i)=0;
            else
             PARAM(j,i)=param{j,2+2*(i-1)};
            end
        end
        for j=1:size2
            if isempty(param2{j,2+2*(i-1)})==1
                PARAM2(j,i)=0;
            else
                PARAM2(j,i)=param2{j,2+2*(i-1)};
            end
        end
        for j=1:nclus
            if isempty(param3{j,2+2*(i-1)})==1
                PARAM3(j,i)=0;
            else
                PARAM3(j,i)=param3{j,2+2*(i-1)};
            end
        end
    end
    total=(size1+size2+nclus)*nclus;
elseif task==3 
    param=get(handles.uitable18,'Data');
    param2=get(handles.uitable19,'Data');
    size1=size(param,1);
    size2=size(param2,1);
    PARAM=zeros(size1,nclus);
    PARAM2=zeros(size2,nclus);
    PARAM3=zeros(nclus,nclus);
    for i=1:nclus
        for j=1:size1
           if isempty(param{j,2+2*(i-1)})==1
               PARAM(j,i)=0;
           else
               PARAM(j,i)=param{j,2+2*(i-1)};
           end
        end
        
        for j=1:size2
           if isempty(param2{j,2+2*(i-1)})==1
               PARAM2(j,i)=0;
           else
               PARAM2(j,i)=param2{j,2+2*(i-1)};
           end
        end
    end
    total=(size1+size2)*nclus;
elseif task==4 || task==5 || task==5
    warndlg('The Stochastic versions will be available in new versions','Coming','replace')
    
end
GradosLibertad=num2str(total-sum(PARAM(:))-sum(PARAM2(:))-sum(PARAM3(:)));
set(handles.text50,'String',GradosLibertad);

function MSE(handles,valores,Tipo,nclus) %realiza el calculo del error de prediccion de la tabla Valores en funcion del Tipo de dato a comparar

try
    indices=[];
    if strcmp(Tipo,'E')==1
        E=getappdata(0,'E');
       for i=1:size(valores,1)
        indices(i)=find(datenum(E{:,1})==datenum(valores{i,1}));
       end
       MSE=1/length(indices)*sum(sum((E{indices,2:nclus+1}-valores{:,2:nclus+1}).^2));
       %MSE=immse((E{indices,2}),valores{:,2});
       set(handles.pushb149,'String',num2str(MSE));
    elseif strcmp(Tipo,'V')==1
        V=getappdata(0,'V');
       indices=find(V(:,1)==valores(:,1));
       %MSE=immse((V(indices,2))-valores(:,2));
       MSE=1/length(indices)*sum((E{indices,2}-valores{:,2}).^2);
       set(handles.pushb149,'String',num2str(MSE));             
    end    
catch 
end

function TransferirParameters(coefin,nclus,handles)
sistema=[get(handles.radiob36,'Value') get(handles.radiob37,'Value') get(handles.radiob53,'Value')==1];
nenv=str2double(get(handles.edit119,'String'));
    coef=coefin{2};
    coef2=coefin{3};
    coef3=coefin{4};    
        if isempty(coef3)==0 && find(sistema==1)==1
            set(handles.uitable30,'Data',reshape(coef,nclus,11)')
            set(handles.uitable83,'Data',reshape(coef2,nclus,nclus)')
            set(handles.uitable87,'Data',reshape(coef3,nclus,8)')
            pushbTransferResults_Callback(@pushbTransferResults_Callback, 1, handles)
        end  
        if find(sistema==1)==2 && isempty(coef3)==0
        set(handles.uitable52,'Data',reshape(coef,nclus,18+6*nenv)')
        set(handles.uitable84,'Data',reshape(coef2,nclus,nclus)')
        set(handles.uitable85,'Data',reshape(coef3,nclus,12)')
        pushbTransferResults_Callback(@pushbTransferResults_Callback, 1, handles)
        end       
       if isempty(coef3)==0 && find(sistema==1)==3
        set(handles.uitable53,'Data',reshape(coef,nclus,9+6*nenv)')
        set(handles.uitable86,'Data',reshape(coef3,nclus,5)')
        pushbTransferResults_Callback(@pushbTransferResults_Callback, 1, handles)
       end     
        

function nume=seteoNombresStrings(handles)
Nclus=str2double(get(handles.edit25,'String'));
Nenvironmental=str2double(get(handles.edit119,'String'));
if get(handles.radiob3,'Value')==1 || get(handles.radiob2,'Value')==1
    if get(handles.radiob49,'Value')==1 %Si la informacion es para infeccion.
        nume={'TIME'};
            for i=1:Nclus
                nume{end+1}=strcat('InfectInfo',num2str(i));
            end
    elseif get(handles.radiob50,'Value')==1 %Si la informacion es para temperatura
        nume={'TIME'};
            for i=1:Nclus
                for j=1:Nenvironmental
                 nume{end+1}=strcat('EnvVa',num2str(j),'Clust',num2str(i));
                end
            end
    elseif get(handles.radiob51,'Value')==1
        for i=1:Nclus                                     
            nume{i}=strcat('Cluster',num2str(i));
        end
    elseif get(handles.radiob67,'Value')==1
        nume={'TIME'};
            for i=1:Nclus
                nume{end+1}=strcat('VECT',num2str(i));
            end
    %elseif get(handles.radiob135,'Value')==1
    %    nume={'TIME'};
    %            for i=1:Nclus
    %                nume{end+1}=strcat('InfectInfo',num2str(i));
    %            end
    %            for i=1:Nclus
    %                nume{end+1}=strcat('VECT',num2str(i));
    %            end
    %            for i=1:Nclus
    %                for j=1:Nenvironmental
    %                nume{end+1}=strcat('EnvVa',num2str(j),'Clust',num2str(i));
    %                end
    %            end
  %  elseif get(handles.radiob139,'Value')==1
  %      for i=1:Nclus
  %         nume{i}=strcat('Coordinate(La,Lo)',num2str(i)); 
  %      end
    end
elseif get(handles.radiob1,'Value')==1 
    nume={'Year','Month','Day'};
    if get(handles.radiob49,'Value')==1 %Si la informacion es para infeccion.
            for i=1:Nclus
                nume{end+1}=strcat('InfectCluster',num2str(i));
            end
    elseif get(handles.radiob50,'Value')==1 %Si la informacion es para temperatura
            for i=1:Nclus
                for j=1:Nenvironmental
                 nume{end+1}=strcat('EnvVa',num2str(j),'Clust',num2str(i));
                end
            end
    elseif get(handles.radiob51,'Value')==1
        nume={};
        for i=1:Nclus                                     
            nume{i}=strcat('Cluster',num2str(i));
        end
    elseif get(handles.radiob67,'Value')==1
        nume={'Year','Month','Day'};
            for i=1:Nclus
                nume{end+1}=strcat('VECT',num2str(i));
            end
   %  elseif get(handles.radiob135,'Value')==1
   %     nume={'Year','Month','Day'};
   %             for i=1:Nclus
   %                 nume{end+1}=strcat('InfectCluster',num2str(i));
   %             end
   %             for i=1:Nclus
   %                 nume{end+1}=strcat('VECT',num2str(i));
   %             end
   %             for i=1:Nclus
   %                 for j=1:Nenvironmental
   %                 nume{end+1}=strcat('EnvVa',num2str(j),'Clust',num2str(i));
   %                 end
   %             end
  %   elseif get(handles.radiob135,'Value')==1 && get(handles.radiob136,'Value')==1
   %     nume={'Year','Month','Day'};
   %     for i=1:Nclus
   %         nume{i+3}=strcat('Sh',num2str(i));
   %         nume{Nclus+3+i}=strcat('Sv',num2str(i));
   %         nume{2*Nclus+3+i}=strcat('Ih',num2str(i));
   %         nume{3*Nclus+3+i}=strcat('Iv',num2str(i));
   %         nume{4*Nclus+3+i}=strcat('Eh',num2str(i));
   %         nume{5*Nclus+3+i}=strcat('Ev',num2str(i));
   %         nume{6*Nclus+3+i}=strcat('Rh',num2str(i));
   %         nume{7*Nclus+3+i}=strcat('Cv',num2str(i));
   %     end
   % elseif get(handles.radiob135,'Value')==1 && get(handles.radiob137,'Value')==1
   %     nume={'Year','Month','Day'};
   %     for i=1:Nclus
   %         nume{3+i}=strcat('Sh',num2str(i));
   %         nume{Nclus+3+i}=strcat('Sva',num2str(i));
   %         nume{2*Nclus+3+i}=strcat('Ih',num2str(i));
   %         nume{3*Nclus+3+i}=strcat('Iv',num2str(i));
   %         nume{4*Nclus+3+i}=strcat('Eh',num2str(i));
   %         nume{5*Nclus+3+i}=strcat('Ev',num2str(i));
   %         nume{6*Nclus+3+i}=strcat('Rh',num2str(i));
   %         nume{7*Nclus+3+i}=strcat('Cv',num2str(i));
   %         nume{8*Nclus+3+i}=strcat('E',num2str(i));
   %         nume{9*Nclus+3+i}=strcat('L',num2str(i));
   %         nume{10*Nclus+3+i}=strcat('P',num2str(i));
   %         nume{11*Nclus+3+i}=strcat('Svi',num2str(i));
   %     end
   % elseif get(handles.radiob135,'Value')==1 && get(handles.radiob138,'Value')==1
   %     nume={'Year','Month','Day'};
   %     for i=1:Nclus
   %         nume{3+i}=strcat('E',num2str(i));
   %         nume{Nclus+3+i}=strcat('L',num2str(i));
   %         nume{2*Nclus+3+i}=strcat('P',num2str(i));
   %         nume{3*Nclus+3+i}=strcat('Svi',num2str(i));
   %         nume{4*Nclus+3+i}=strcat('Sva',num2str(i));
   %     end
   % elseif get(handles.radiob139,'Value')==1
   %     nume={};
    %    for i=1:Nclus
    %       nume{i}=strcat('Coordinate(La,Lo)',num2str(i)); 
    %    end
    end
end
    


function [PARAM,Q,INIT,SELECTOR,SELECTOR2,SELECTOR3]=EvaluarMatrix(nparam,ninit,param,q,init,nclus)
for i=1:nclus
    % this is for q matrix no chang
        for j=1:nclus
            if iscellstr(q)==1 && isempty(q)==0
                Q(j,i)=str2double(q(j,1+2*(i-1)));
                if isempty(q(j,2+2*(i-1)))==1
                    SELECTOR2(j,i)=0;
                else
                    SELECTOR2(j,i)=str2double(q(j,2+2*(i-1)));
                end
            elseif isempty(q)==0
                Q(j,i)=q{j,1+2*(i-1)};
                if isempty(q{j,2+2*(i-1)})==1
                    SELECTOR2(j,i)=0;
                else
                    SELECTOR2(j,i)=double(q{j,2+2*(i-1)});
                end
            else
                Q=[];
                SELECTOR2=[];
            end
        end
        %---this is for initial values ..... no change
        for j=1:ninit
            if iscellstr(init)==1
                INIT(j,i)=str2double(init(j,1+2*(i-1)));
                if isempty(init(j,2+2*(i-1)))==1
                    SELECTOR3(j,i)=0;
                else
                    SELECTOR3(j,i)=str2double(init(j,2+2*(i-1)));
                end
            else
                INIT(j,i)=init{j,1+2*(i-1)};
                if isempty(init{j,1+2*(i-1)})==1
                    SELECTOR3(j,i)=0;
                else
                    SELECTOR3(j,i)=double(init{j,2+2*(i-1)});
                end
            end
        end
        %this is for the parameters.
        for j=1:nparam
            if iscellstr(param)==1 
                PARAM(j,i)=str2double(param(j,1+2*(i-1)));
                if isempty(param(j,2+2*(i-1)))==1
                    SELECTOR(j,i)=0;
                else
                    SELECTOR(j,i)=str2double(param(j,2+2*(i-1)));
                end
            else
                PARAM(j,i)=param{j,1+2*(i-1)};
                if isempty(param{j,2+2*(i-1)})==1
                    SELECTOR(j,i)=0;    
                else
                    SELECTOR(j,i)=double(param{j,2+2*(i-1)});
                end              
                
            end
        end
end

function radiob135_Callback(hObject, eventdata, handles)
edit25_Callback(@edit25_Callback,1,handles)

function save_Callback(hObject, eventdata, handles)
handles = guidata(gcbo);
estModel=handles.metricdata.estModel;
isLogTransform=handles.metricdata.isLogTransform;
numPaths=get(handles.popupmenu19,'Value');
x=handles.metricdata.data;
out=handles.metricdata.out;
temp=out;

if isLogTransform
    temp=10.^(out);
end


fileopen_error_flag=1;
while(fileopen_error_flag==1)
    try
        xlswrite('forecast.xls',1)
        fileopen_error_flag=0;
    catch
        msg=sprintf('forecast.xls file is open, please close it now.\n');
        uiwait(warndlg(msg));
    end
end


final_data=[repmat(x,1,numPaths);temp];
delete forecast.xls;
columns_per_sheet=200;
sheets=ceil(numPaths/columns_per_sheet);
jump=0;
for i=1:sheets
    end_index=min(columns_per_sheet+jump,size(final_data,2));
    xlswrite('forecast.xls',final_data(:,1+jump:end_index),i);
    jump=jump+columns_per_sheet;
end 

msg=sprintf('Data is saved in a file named "forecast.xls" \nin %d sheets',sheets);
h=msgbox(msg);
ah = get( h, 'CurrentAxes' );
ch = get( ah, 'Children' );
set( ch, 'FontSize', 9 );
uiwait(h);

save('estimated_model','estModel')
msg=sprintf('Model is saved as an object named "estimated_model" \n');
h=msgbox(msg);
ah = get( h, 'CurrentAxes' );
ch = get( ah, 'Children' );
set( ch, 'FontSize', 9 );
uiwait(h);
    
    
    
function radiob136_Callback(hObject, eventdata, handles)
edit25_Callback(@edit25_Callback,1,handles)


function radiob137_Callback(hObject, eventdata, handles)
edit25_Callback(@edit25_Callback,1,handles)


function radiob138_Callback(hObject, eventdata, handles)
edit25_Callback(@edit25_Callback,1,handles)

function pushb74_Callback(hObject, eventdata, handles)
menu_file_save_simulation2_Callback(@menu_file_save_simulation2_Callback, eventdata, handles)







function plot_all(x,hObject)
handles = guidata(gcbo);
isLogTransform=handles.metricdata.isLogTransform;
isMeanCorrected=handles.metricdata.isMeanCorrected; 
lags=handles.metricdata.lagsToPlot;
differentiation=handles.metricdata.differentiation;
harmonics=handles.metricdata.harmonics;
seasonalityRemoved=handles.metricdata.seasonalityRemoved;
advancedFilterNum=handles.metricdata.advancedFilterNum;
advancedFilterDen=handles.metricdata.advancedFilterDen;


if isLogTransform
    x=log10(x);
end

if isMeanCorrected
    x=x-mean(x);
end


if differentiation>0
    x=diff(x,differentiation);
end



x=filter(advancedFilterNum,advancedFilterDen,x);
x=x(length(advancedFilterNum):end);


x_memory=x;
[T,oo,~,ff,ind]=find_periods(x_memory,harmonics,5);
tCandidate=find_period_candidate(T);
handles.metricdata.tCandidate=tCandidate;
if seasonalityRemoved>0
    x=x(seasonalityRemoved+1:end)-x(1:end-seasonalityRemoved);
end
axes(handles.axes23);
cla
[~,o,~,f,~]=find_periods(x,harmonics,5);

ending=min(length(ff),length(oo));
plot(ff(1:ending),abs(oo(1:ending)),'r');
hold on

if seasonalityRemoved>0
    plot(f,abs(o),'b:','linewidth',2)
    legend('data','seasonality removed')
else
    legend('hide')
end
plot(ff(ind),abs(oo(ind)),'k^','linewidth',2)
for i=1:harmonics
    msg=num2str(1/ff(ind(i)), '%.1f');
    text(ff(ind(i))+0.02,abs(oo(ind(i))),msg)
end
xlim([0 0.5])
ylim auto
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('Amplitude Response')
xlabel('Frequency (cycle per sample)')


axes(handles.axes11);
cla;
plot(x,'.-')
xlim([0 length(x)])
ylim auto
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('Signal')
xlabel('Time (sample)')       





























if (handles.correlation_type==0)
    axes(handles.axes24);
    cla
    [acf,lags_interval,bounds]=autocorr(x,lags);
    h=stem(lags_interval,acf,'filled','MarkerFaceColor',[1 .5 0]);
    set(h,'Color',[1 .5 0])
    hold on
    plot(linspace(0.5,lags_interval(end),2),bounds(1)*ones(1,2),'m')
    plot(linspace(0.5,lags_interval(end),2),bounds(2)*ones(1,2),'m')
    set(gca,'FontName','Times New Roman','FontSize',11)
    ylim([min(acf)-0.2 max(acf)+0.2])
    ylabel('Sample Autocorrelation')
    xlabel('Lag')
else
    axes(handles.axes24);
    cla
    [pcf,lags_interval,bounds]=parcorr(x,lags);
    h=stem(lags_interval,pcf,'filled','MarkerFaceColor',[1 .5 0]);
    set(h,'Color',[1 .5 0])
    hold on
    plot(linspace(0.5,lags_interval(end),2),bounds(1)*ones(1,2),'m')
    plot(linspace(0.5,lags_interval(end),2),bounds(2)*ones(1,2),'m')
    set(gca,'FontName','Times New Roman','FontSize',11)
    ylim([min(pcf)-0.2 max(pcf)+0.2])
    ylabel('Sample Partial Autocorrelation')
    xlabel('Lag')
end


guidata(hObject, handles);
















% ------------------------------- fin funciones propias-------------

function pushbSaveResultsForecasting_Callback(hObject, eventdata, handles)
try

J=getappdata(0,'F');
F=J{1,end};
%F=get(handles.uitable43,'Data');
[filename filepath]=uiputfile('*.xlsx');
sim=strcat(filepath,filename);
writetable(F,sim);
catch 
    warndlg('Make sure that the forecasting results exist and use a valid name')
end






function edit62_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit62_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton75.
function pushbutton75_Callback(hObject, eventdata, handles)



% --- Executes on button press in pushbutton76.
function pushbutton76_Callback(hObject, eventdata, handles)



% --- Executes on button press in pushbutton77.
function pushbutton77_Callback(hObject, eventdata, handles)




function edit63_Callback(hObject, eventdata, handles)

function edit63_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit64_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit64_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton78.
function pushbutton78_Callback(hObject, eventdata, handles)



% --- Executes on button press in pushbutton79.
function pushbutton79_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton80.
function pushbutton80_Callback(hObject, eventdata, handles)

function edit65_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit65_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton81.
function pushbutton81_Callback(hObject, eventdata, handles)
E=getappdata(0,'E');
V=getappdata(0,'V');
Results=getappdata(0,'F');
Numero=size(Results,2);
nclus=str2double(get(handles.edit25,'String'));
yy=get(handles.popupm15,'Value');
axes(handles.axes11);
cla
hold on
if get(handles.radiobCAccumulated,'Value')==1 || get(handles.radiobInfectedHost,'Value')==1
plot(E.TIME,E{:,yy+1},'LineStyle','none','Marker','*','MarkerEdgeColor','b','MarkerSize',2,'Parent',handles.axes11)
else
plot(V.TIME,V{:,yy+1},'LineStyle','none','Marker','*','MarkerEdgeColor','b','MarkerSize',2,'Parent',handles.axes11)
end
try
for i=1:Numero
actual=Results{i};  
%actual=table2timetable(actual);
    plot(actual.TIME,actual{:,yy+1},'LineStyle','none','Marker','*','MarkerEdgeColor','r','MarkerSize',2,'Parent',handles.axes11)
end
catch
    warndlg(' there is no enough information in the results to plot the corresponding axis or there are previous forcasting with mistmatching number of clusters. Remov the previous forecastings','Missing results','replace')
end
legend('hide')
set(gca,'FontName','Times New Roman','FontSize',11)
ylabel('History and Forecast')
xlabel('Time')  
ylim auto
hold off


% --- Executes on selection change in popupm15.
function popupm15_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function popupm15_CreateFcn(hObject, eventdata, handles)

%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbTransferResults.
function pushbTransferResults_Callback(hObject, eventdata, handles)
%try
nclus=str2double(get(handles.edit25,'String'));
nenv=str2double(get(handles.edit119,'String'));
if get(handles.radiob36,'Value')==1 
q=get(handles.uitable13,'Data');
param=get(handles.uitable9,'Data');
init=get(handles.uitable10,'Data');
[~,~,~,SELECTOR,SELECTOR2,SELECTOR3]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);
B1=num2cell(logical(reshape(SELECTOR,size(param,1),nclus)));
B2=num2cell(logical(reshape(SELECTOR2,nclus,nclus)));
B3=num2cell(logical(reshape(SELECTOR3,size(init,1),nclus)));   
A1=num2cell(get(handles.uitable30,'Data')); %infectmatrix
A2=num2cell(get(handles.uitable83,'Data')); %Qmatrix
A3=num2cell(get(handles.uitable87,'Data')); %initialconditions
%B1=num2cell(logical(ones(size(A1,1),size(A1,2))));
%B2=num2cell(logical(ones(size(A2,1),size(A2,2))));
%B3=num2cell(logical(ones(size(A3,1),size(A3,2))));
C1=reshape([A1;B1],size(A1,1),2*size(A1,2));
C2=reshape([A2;B2],size(A2,1),[]);
C3=reshape([A3;B3],size(A3,1),2*size(A1,2));
set(handles.uitable9,'Data',C1);
set(handles.uitable13,'Data',C2);
set(handles.uitable10,'Data',C3);
setappdata(0,'Q',C2)
elseif get(handles.radiob37,'Value')==1 
q=get(handles.uitable23,'Data');
param=get(handles.uitable21,'Data');
init=get(handles.uitable22,'Data');    
[~,~,~,SELECTOR,SELECTOR2,SELECTOR3]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);    
B1=num2cell(logical(reshape(SELECTOR,size(param,1),nclus)));
B2=num2cell(logical(reshape(SELECTOR2,nclus,nclus)));
B3=num2cell(logical(reshape(SELECTOR3,size(init,1),nclus)));          
A1=num2cell(get(handles.uitable52,'Data')); %infectmatrix
A2=num2cell(get(handles.uitable84,'Data')); %Qmatrix
A3=num2cell(get(handles.uitable85,'Data')); %initialconditions
%B1=num2cell(logical(ones(size(A1,1),size(A1,2))));
%B2=num2cell(logical(ones(size(A2,1),size(A2,2))));
%B3=num2cell(logical(ones(size(A3,1),size(A3,2))));
C1=reshape([A1;B1],size(A1,1),2*size(A1,2));
C2=reshape([A2;B2],size(A2,1),[]);
C3=reshape([A3;B3],size(A3,1),2*size(A1,2));
set(handles.uitable21,'Data',C1);
set(handles.uitable23,'Data',C2);
set(handles.uitable22,'Data',C3);
setappdata(0,'Q',C2)
elseif get(handles.radiob53,'Value')==1 
param=get(handles.uitable18,'Data');
init=get(handles.uitable19,'Data');  
[~,~,~,SELECTOR,~,SELECTOR3]=EvaluarMatrix(size(param,1),size(init,1),param,[],init,nclus); 
B1=num2cell(logical(reshape(SELECTOR,size(param,1),nclus)));
B3=num2cell(logical(reshape(SELECTOR3,size(init,1),nclus)));    
A1=num2cell(get(handles.uitable53,'Data')); %infectmatrix
A3=num2cell(get(handles.uitable86,'Data')); %initialconditions
%B1=num2cell(logical(ones(size(A1,1),size(A1,2))));
%B3=num2cell(logical(ones(size(A3,1),size(A3,2))));
C1=reshape([A1;B1],size(A1,1),2*size(A1,2));
C3=reshape([A3;B3],size(A3,1),2*size(A1,2));
set(handles.uitable18,'Data',C1)
set(handles.uitable19,'Data',C3)
end
DOF(handles)
%catch
%   warnmsg('Make sure to perform parameters prediction first before transfering') 
%end
% --------------------------------------------------------------------


% --- Executes on button press in radiobNoFiltering.
function radiobNoFiltering_Callback(hObject, eventdata, handles)
set(handles.uipanelNoFiltering,'Visible','on')
set(handles.uipanelPFParameters,'Visible','off')
set(handles.uipanelEKFParameters,'Visible','off')
%set(handles.radiobCAccumulated,'Visible','on')

% --- Executes on button press in radiobEKF.
function radiobEKF_Callback(hObject, eventdata, handles)
set(handles.uipanelNoFiltering,'Visible','of')
set(handles.uipanelPFParameters,'Visible','off')
set(handles.uipanelEKFParameters,'Visible','on')
%set(handles.radiobCAccumulated,'Visible','off')
%if get(handles.radiobCAccumulated,'Value')==1
%set(handles.radiobInfectedHost,'Value',1)
%end


% --- Executes on button press in radiobPF.
function radiobPF_Callback(hObject, eventdata, handles)
set(handles.uipanelNoFiltering,'Visible','off')
set(handles.uipanelPFParameters,'Visible','on')
set(handles.uipanelEKFParameters,'Visible','off')
%set(handles.radiobCAccumulated,'Visible','off')
%if get(handles.radiobCAccumulated,'Value')==1
%set(handles.radiobInfectedHost,'Value',1)
%end

% --- Executes on button press in pushbutton109.
function pushbutton109_Callback(hObject, ~, handles)

% --- Executes on button press in pushbutton110.
function pushbutton110_Callback(hObject, eventdata, handles)

% --- Executes on selection change in popupmenu19.
function popupmenu19_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function popupmenu19_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton111.
function pushbutton111_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton113.
function pushbutton113_Callback(hObject, eventdata, handles)




function edit80_Callback(hObject, eventdata, handles)

function edit80_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu22.
function popupmenu22_Callback(hObject, eventdata, handles)

function popupmenu22_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton114.
function pushbutton114_Callback(hObject, eventdata, handles)

% --- Executes on selection change in popupmenu20.
function popupmenu20_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function popupmenu20_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton112.
function pushbutton112_Callback(hObject, eventdata, handles)


% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)

function edit81_Callback(hObject, eventdata, handles)



function edit81_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%% ARIMA  %%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in isLogTransform.
function isLogTransform_Callback(hObject, eventdata, handles)
data=handles.metricdata.data;
if (get(hObject,'Value'))
    handles.metricdata.isLogTransform=true;
else
    handles.metricdata.isLogTransform=false;
end
guidata(hObject, handles);
plot_all(data,hObject)

% --- Executes on button press in isMeanCorrected.
function isMeanCorrected_Callback(hObject, eventdata, handles)
data=handles.metricdata.data;
if (get(hObject,'Value'))
    handles.metricdata.isMeanCorrected=true;
else
    handles.metricdata.isMeanCorrected=false;
end
guidata(hObject, handles);
plot_all(data,hObject)

% --- Executes on selection change in popupmenu24.
function popupmenu24_Callback(hObject, eventdata, handles)
data=handles.metricdata.data;
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
case 'Autocorrelation' % User selects peaks.
   handles.correlation_type = 0;
case 'Partial Autocorrelation' % User selects membrane.
   handles.correlation_type = 1;
end
% Save the handles structure.
guidata(hObject,handles)
plot_all(data,hObject)
    
    
    
% --- Executes during object creation, after setting all properties.
function popupmenu24_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lagsToPlot_Callback(hObject, eventdata, handles)
data=handles.metricdata.data;
handles.metricdata.lagsToPlot=str2num(get(hObject,'String'));
guidata(hObject, handles);
plot_all(data,hObject)
    
    
% --- Executes during object creation, after setting all properties.
function lagsToPlot_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ARLags_Callback(hObject, eventdata, handles)
temp = get(hObject, 'String');
ARLags = str2num(temp);
handles.metricdata.ARLags = ARLags;
guidata(hObject,handles);
    
% --- Executes during object creation, after setting all properties.
function ARLags_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in isARLags.
function isARLags_Callback(hObject, eventdata, handles)
if (get(hObject,'Value'))
    handles.metricdata.isARLags=true;
else
    handles.metricdata.isARLags=false;
end
guidata(hObject, handles);
    
    
    
function MALags_Callback(hObject, eventdata, handles)
temp = get(hObject, 'String');
MALags = str2num(temp);
handles.metricdata.MALags = MALags;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function MALags_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in isMALags.
function isMALags_Callback(hObject, eventdata, handles)
if (get(hObject,'Value'))
    handles.metricdata.isMALags=true;
else
    handles.metricdata.isMALags=false;
end
guidata(hObject, handles);
    
    
function AR_Callback(hObject, eventdata, handles)
temp = get(hObject, 'String');
AR = str2num(temp);
handles.metricdata.AR = AR;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function AR_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MA_Callback(hObject, eventdata, handles)
temp = get(hObject, 'String');
MA = str2num(temp);
handles.metricdata.MA = MA;
guidata(hObject,handles);

    
% --- Executes during object creation, after setting all properties.
function MA_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in isAR.
function isAR_Callback(hObject, eventdata, handles)
if (get(hObject,'Value'))
    handles.metricdata.isAR=true;
else
    handles.metricdata.isAR=false;
end
guidata(hObject, handles);
    
% --- Executes on button press in isMA.
function isMA_Callback(hObject, eventdata, handles)
if (get(hObject,'Value'))
    handles.metricdata.isMA=true;
else
    handles.metricdata.isMA=false;
end
guidata(hObject, handles);

function SARLags_Callback(hObject, eventdata, handles)
temp = get(hObject, 'String');
SARLags = str2num(temp);
handles.metricdata.SARLags = SARLags;
guidata(hObject,handles);
    
% --- Executes during object creation, after setting all properties.
function SARLags_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SAR_Callback(hObject, eventdata, handles)
temp = get(hObject, 'String');
SAR = str2num(temp);
handles.metricdata.SAR = SAR;
guidata(hObject,handles);
    
% --- Executes during object creation, after setting all properties.
function SAR_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in isSARLags.
function isSARLags_Callback(hObject, eventdata, handles)
if (get(hObject,'Value'))
    handles.metricdata.isSARLags=true;
else
    handles.metricdata.isSARLags=false;
end
guidata(hObject, handles);


% --- Executes on button press in isSAR.
function isSAR_Callback(hObject, eventdata, handles)
if (get(hObject,'Value'))
    handles.metricdata.isSAR=true;
else
    handles.metricdata.isSAR=false;
end
guidata(hObject, handles);

% --- Executes on button press in isSMALags.
function isSMALags_Callback(hObject, eventdata, handles)
if (get(hObject,'Value'))
    handles.metricdata.isSMALags=true;
else
    handles.metricdata.isSMALags=false;
end
guidata(hObject, handles);
    
    
    
function SMALags_Callback(hObject, eventdata, handles)
temp = get(hObject, 'String');
SMALags = str2num(temp);
handles.metricdata.SMALags = SMALags;
guidata(hObject,handles);
    
% --- Executes during object creation, after setting all properties.
function SMALags_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in isSMA.
function isSMA_Callback(hObject, eventdata, handles)
if (get(hObject,'Value'))
    handles.metricdata.isSMA=true;
else
    handles.metricdata.isSMA=false;
    set(handles.SMA,'string',num2str(''));
end
guidata(hObject, handles);

function SMA_Callback(hObject, eventdata, handles)
temp = get(hObject, 'String');
SMA = str2num(temp);
handles.metricdata.SMA = SMA;
guidata(hObject,handles);
    
% --- Executes during object creation, after setting all properties.
function SMA_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Seasonality_Callback(hObject, eventdata, handles)
Seasonality=str2num(get(hObject,'String'));
handles.metricdata.Seasonality=Seasonality;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Seasonality_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function D_Callback(hObject, eventdata, handles)
D=str2num(get(hObject,'String'));
handles.metricdata.D=D;
guidata(hObject, handles);
    
% --- Executes during object creation, after setting all properties.
function D_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton124.
function pushbutton124_Callback(hObject, eventdata, handles)
handles = guidata(gcbo);
isARLags=handles.metricdata.isARLags;
isMALags=handles.metricdata.isMALags;
isSARLags=handles.metricdata.isSARLags;
isSMALags=handles.metricdata.isSMALags;
AR=handles.metricdata.AR;
MA=handles.metricdata.MA;
SAR=handles.metricdata.SAR;
SMA=handles.metricdata.SMA;
D=handles.metricdata.D;
Seasonality=handles.metricdata.Seasonality;
isLogTransform=handles.metricdata.isLogTransform;
x=handles.metricdata.data;
y=x;
if isLogTransform
    y=log10(x);
end
model=arima;
try
    if (handles.metricdata.isAR)
        model.AR=num2cell(AR);
    end
    if (handles.metricdata.isMA)
        model.MA=num2cell(MA);
    end
    if (handles.metricdata.isSAR)
        model.SAR=num2cell(SAR);
    end

    if (handles.metricdata.isSMA)
        model.SMA=num2cell(SMA);
    end
catch
    msg=sprintf('System is not either stable or causal!\n');
    errordlg(msg, 'Error');
    return
end
try
    if (isARLags)
        model.AR=translateLagsToCof(handles.metricdata.ARLags,AR,handles.metricdata.isAR);
    end
    if (isMALags)
        model.MA=translateLagsToCof(handles.metricdata.MALags,MA,handles.metricdata.isMA);
    end

    if (isSARLags)
        model.SAR=translateLagsToCof(handles.metricdata.SARLags,SAR,handles.metricdata.isSAR);
    end

    if (isSMALags)
        model.SMA=translateLagsToCof(handles.metricdata.SMALags,SMA,handles.metricdata.isSMA);
    end
catch
    msg=sprintf('Lags and Coefficients vectors must have the same length!\n');
    errordlg(msg, 'Error');
    return
end
model.D=D;
model.Seasonality=Seasonality;
%h = waitbar(0,'Please wait ...');
%hw=findobj(h,'Type','Patch');
%set(hw,'EdgeColor',[0 0 0],'FaceColor',[0 1 0]) % changes the color to green
try
     estModel=estimate(model,y);
     info=summarize(estModel);
     rows=char(info.Table.Properties.RowNames);
     list={cat(2,rows,repmat('    ',size(rows,1),1),num2str(info.Table{:,1}))};
     listdlg('PromptString','PARAMETERS','ListString',list);
  %   waitIteration(20,1,0);
    % close(h)
     handles.metricdata.estModel=estModel;
catch
 %    waitIteration(20,1,0);
   %  close(h)
     errordlg('The model is unstable', 'Error');
end
set(handles.pushbForecast,'Enable','on')
guidata(hObject,handles);


% --- Executes on button press in pushbutton125.
function pushbutton125_Callback(hObject, eventdata, handles)

function edit102_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit102_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit103_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit103_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton126.
function pushbutton126_Callback(hObject, eventdata, handles)

function differentiation_Callback(hObject, eventdata, handles)
data=handles.metricdata.data;
handles.metricdata.differentiation=str2num(get(hObject,'String'));
guidata(hObject, handles);
plot_all(data,hObject)
    
% --- Executes during object creation, after setting all properties.
function differentiation_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function seasonalityRemoved_Callback(hObject, eventdata, handles)
data=handles.metricdata.data;
handles.metricdata.seasonalityRemoved=str2num(get(hObject,'String'));
guidata(hObject, handles);
plot_all(data,hObject)
    
% --- Executes during object creation, after setting all properties.
function seasonalityRemoved_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function harmonics_Callback(hObject, eventdata, handles)
data=handles.metricdata.data;
handles.metricdata.harmonics=str2num(get(hObject,'String'));
guidata(hObject, handles);
plot_all(data,hObject)
% --- Executes during object creation, after setting all properties.
function harmonics_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton122.
function pushbutton122_Callback(hObject, eventdata, handles)
message = sprintf('Seasonality observed every %d Samples \n',handles.metricdata.tCandidate);
h=msgbox(message,'','modal');
%ah = get( h, 'CurrentAxes' );
%ch = get( ah, 'Children' );
%set( ch, 'FontSize', 9);
%set( ch, 'FontName', 'Times New Roman' );    
    
    
    
%%%%%%%%%%%%%%%%%%%% end ARIMA %%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton130.
function pushbutton130_Callback(hObject, eventdata, handles)


% --- Executes on button press in radiob139.
%function radiob139_Callback(hObject, eventdata, handles)
%edit25_Callback(@edit25_Callback,1,handles)


% --- Executes on button press in textGeoreferencingData.
function textGeoreferencingData_Callback(hObject, eventdata, handles)
% hObject    handle to textGeoreferencingData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit104_Callback(hObject, eventdata, handles)
% hObject    handle to edit104 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit104 as text
%        str2double(get(hObject,'String')) returns contents of edit104 as a double


% --- Executes during object creation, after setting all properties.
function edit104_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit104 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit105_Callback(hObject, eventdata, handles)
% hObject    handle to edit105 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit105 as text
%        str2double(get(hObject,'String')) returns contents of edit105 as a double


% --- Executes during object creation, after setting all properties.
function edit105_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit105 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushb132.
function pushb132_Callback(hObject, eventdata, handles)
try
%handles=guidata(gcbo);
nclus=str2double(get(handles.edit25,'String'));
nenv=str2double(get(handles.edit119,'String'));
sistema=[get(handles.radiob36,'Value') get(handles.radiob37,'Value') get(handles.radiob53,'Value')==1];
Covariance=get(handles.uitable63,'Data');
ProcesNoise=get(handles.uitable60,'Data');
MeasNoise=str2double(get(handles.edit106,'String'));
ForeDays=get(handles.popupmForecastingDays,'Value');
initialdaySelection=get(handles.popupm28,'Value');
initialdays=get(handles.popupm28,'String');
BackDays=str2double(get(handles.editBackwardDays,'String'));
E=getappdata(0,'E');
V=getappdata(0,'V');
T=getappdata(0,'T');
A=getappdata(0,'A');

if isempty(T)==1 || get(handles.radiob87,'Value')==1
    TEMP=get(handles.uitable42,'Data');
else
    TEMP=T(:,1:nclus+1);
    TEMP.TIME=datenum(TEMP.TIME);
    TEMP=table2array(TEMP);
end

if get(handles.checkbox22,'Value')==1
   datosT=get(handles.uitableWeatherPrediction,'Data');
    for i=1:size(datosT)
       if isempty(finde(find(TEMP(:,1)==datosT(i,1))))==1  
          TEMP=[TEMP; datosT];  
       end
    end
      TEMP=sortrows(TEMP);  
end


if get(handles.radiobInfectedHost,'Value')==1
    caso=1;
elseif get(handles.radiobCAccumulated,'Value')==1
    caso=2;
elseif get(handles.radiob124,'Value')==1 && get(handles.radiob37,'Value')==1 
    caso=3;
elseif get(handles.radiob124,'Value')==1 && get(handles.radiob53,'Value')==1
    caso=4;
elseif get(handles.radiob123,'Value')==1
    caso=5;
elseif get(handles.radiob122,'Value')==1
    caso=6;
elseif get(handles.radiob121,'Value')==1
    caso=7;
end

if find(sistema==1)==1
    q=get(handles.uitable13,'Data');
    param=get(handles.uitable9,'Data');
    init=get(handles.uitable10,'Data');
    [PARAM,Q,INIT,SETEO1,SETEO2,SETEO3]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);
    MOM=E(:,1:nclus+1);
    %xlims=[datenum(MOM.TIME(end))-BackDays, datenum(MOM.TIME(end))];
    xlims=[datenum(initialdays(initialdaySelection,1))-BackDays, datenum(initialdays(initialdaySelection,1))];
    MOM.TIME=datenum(MOM.TIME);
    [~,ind1] = min(abs(xlims(1)-MOM.TIME));
    [~,ind2] = min(abs(xlims(2)-MOM.TIME));
    %%%%%%%%%%%%%%%%%%%%%%%    
    xdata=MOM.TIME(ind1:ind2,1);
    ydata=cell2mat(table2cell(MOM(ind1:ind2,2:end)));
    Xdata=[xdata; (xdata(end)+1:1:xdata(end)+ForeDays)'];    
    if get(handles.checkbox27,'Value')==1
  %  ResultadosFijarCoef=ODEs(7,sistema,nclus,BackDays,ForeDays,E,V,T,A,q,param,init,Q,PARAM,INIT,1,handles,xdata,ydata,Xdata);    
    ResultadosFijarCoef=ODEs(7,sistema,nclus,BackDays,ForeDays,E,V,TEMP,A,q,param,init,Q,PARAM,INIT,1,handles,xdata,ydata,Xdata,SETEO1,SETEO2,SETEO3,nenv);    
    %pushbTransferResults_Callback(hObject, eventdata, handles)
    INITekf=ResultadosFijarCoef{4};
    TransferirParameters(ResultadosFijarCoef,nclus,handles)
    else
        for i=1:size(init,1)
            if i==3 && get(handles.radiobInfectedHost,'Value')==1  
                INIT(2*nclus+1:3*nclus)=ydata(1,:);
            elseif i==8 && get(handles.radiobCAccumulated,'Value')==1 
                INIT(7*nclus+1:8*nclus)=ydata(1,:);
            end
        end    
        INITekf=INIT;
    end
    myEKF=extendedKalmanFilter(@(x)dengueODE9(x,nclus,Q, PARAM(1,:),PARAM(2,:),PARAM(3,:),PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), PARAM(10,:), PARAM(11,:)),@(x) MeasurementFcnDengue(x,caso,nclus),INITekf);
elseif find(sistema==1)==2
    q=get(handles.uitable23,'Data');
    param=get(handles.uitable21,'Data');
    init=get(handles.uitable22,'Data');    
    [PARAM,Q,INIT,SETEO1,SETEO2,SETEO3]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);
    MOM=E(:,1:nclus+1);
    %xlims=[datenum(MOM.TIME(end))-BackDays, datenum(MOM.TIME(end))];
    xlims=[datenum(initialdays(initialdaySelection,1))-BackDays, datenum(initialdays(initialdaySelection,1))];
    MOM.TIME=datenum(MOM.TIME);
    [~,ind1] = min(abs(xlims(1)-MOM.TIME));
    [~,ind2] = min(abs(xlims(2)-MOM.TIME));
    %%%%%%%%%%%%%%%%%%%%%%%    
    xdata=MOM.TIME(ind1:ind2,1);
    ydata=cell2mat(table2cell(MOM(ind1:ind2,2:end)));
    Xdata=[xdata; (xdata(end)+1:1:xdata(end)+ForeDays)'];
    
 %   if isempty(T)==1
 %       TEMP=[get(handles.uitable47,'Data'); get(handles.uitableWeatherPrediction,'Data')];
 %   else
 %       T.TIME=datenum(T.TIME);
 %       TEMP=[T; get(handles.uitableWeatherPrediction,'Data')];
 %   end
    if get(handles.checkbox27,'Value')==1
   % ResultadosFijarCoef=ODEs(7,sistema,nclus,BackDays,ForeDays,E,V,TEMP,A,q,param,init,Q,PARAM,INIT,1,handles);
    ResultadosFijarCoef=ODEs(7,sistema,nclus,BackDays,ForeDays,E,V,TEMP,A,q,param,init,Q,PARAM,INIT,1,handles,xdata,ydata,Xdata,SETEO1,SETEO2,SETEO3,nenv);    
    INITekf=ResultadosFijarCoef{4};
    TransferirParameters(ResultadosFijarCoef,nclus,handles)
    else
        for i=1:size(init,1)
            if i==3 && get(handles.radiobInfectedHost,'Value')==1  
                INIT(2*nclus+1:3*nclus)=ydata(1,:);
            elseif i==8 && get(handles.radiobCAccumulated,'Value')==1
                INIT(7*nclus+1:8*nclus)=ydata(1,:);
            elseif i==2  && get(handles.radiob124,'Value')==1
                INIT(nclus+1:2*nclus)=ydata(1,:);
            end
        end    
        INITekf=INIT;
    end 
    myEKF=extendedKalmanFilter(@(x)dengueODE11_Modified(x,nclus,TEMP,Q, PARAM(1,:),PARAM(2,:),PARAM(3,:),PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), PARAM(10,:), PARAM(11,:), PARAM(12,:), PARAM(13,:), PARAM(14,:), PARAM(15,:), PARAM(16,:), PARAM(17,:), PARAM(18,:), PARAM(19:18+nenv,:), PARAM(19+nenv:18+2*nenv,:), PARAM(19+2*nenv:18+3*nenv,:), PARAM(19+3*nenv:18+4*nenv,:), PARAM(19+4*nenv:18+5*nenv,:), PARAM(19+5*nenv:18+6*nenv,:),nenv),@(x) MeasurementFcnDengue(x,1,nclus),INITekf);
%x=dengueODE11(x,nclus, Temp, q, Nh,uh,kv,kh,gama,alpha,pv,ph,tau, mu1, mu2, mu3, mu4, mu5,mu6,mu7, mu8, mu9, k0, ep, Tp, Tl, Ti, Te)
elseif find(sistema==1)==3 
    param=get(handles.uitable18,'Data');
    init=get(handles.uitable19,'Data');  
    [PARAM,Q,INIT,SETEO1,SETEO2,SETEO3]=EvaluarMatrix(size(param,1),size(init,1),param,[],init,nclus); 
    MOM=V(:,1:nclus+1);
    %xlims=[datenum(MOM.TIME(end))-BackDays, datenum(MOM.TIME(end))];
    xlims=[datenum(initialdays(initialdaySelection,1))-BackDays, datenum(initialdays(initialdaySelection,1))];
    MOM.TIME=datenum(MOM.TIME);
    [~,ind1] = min(abs(xlims(1)-MOM.TIME));
    [~,ind2] = min(abs(xlims(2)-MOM.TIME));
    %%%%%%%%%%%%%%%%%%%%%%%    
    xdata=MOM.TIME(ind1:ind2,1);
    ydata=cell2mat(table2cell(MOM(ind1:ind2,2:end)));
    Xdata=[xdata; (xdata(end)+1:1:xdata(end)+ForeDays)'];
  
    if get(handles.checkbox27,'Value')==1 
    %ResultadosFijarCoef=ODEs(7,sistema,nclus,BackDays,ForeDays,E,V,T,A,[],param,init,Q,PARAM,INIT,1,handles);
    ResultadosFijarCoef=ODEs(7,sistema,nclus,BackDays,ForeDays,E,V,TEMP,A,[],param,init,Q,PARAM,INIT,1,handles,xdata,ydata,Xdata,SETEO1,SETEO2,SETEO3,nenv);    
    INITekf=ResultadosFijarCoef{4};
    TransferirParameters(ResultadosFijarCoef,nclus,handles)
    else
         for i=1:size(init,1)
            if i==1 && get(handles.radiob121,'Value')==1  
                INIT(1:nclus)=ydata(1,:);
            elseif i==2 && get(handles.radiob122,'Value')==1
                INIT(nclus+1:2*nclus)=ydata(1,:);
            elseif i==3 && get(handles.radiob123,'Value')==1
                INIT(2*nclus+1:3*nclus)=ydata(1,:);
            elseif i==5 && get(handles.radiob124,'Value')==1
                INIT(4*nclus+1:5*nclus)=ydata(1,:);        
            end
        end    
        INITekf=INIT;
    end
    myEKF=extendedKalmanFilter(@(x)dengueODE10_Modified(x,nclus,TEMP, PARAM(1,:),PARAM(2,:),PARAM(3,:),PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), PARAM(10:9+nenv,:), PARAM(10+nenv:9+2*nenv,:), PARAM(10+2*nenv:9+3*nenv,:), PARAM(10+3*nenv:9+4*nenv,:), PARAM(10+4*nenv:9+5*nenv,:), PARAM(10+5*nenv:9+6*nenv,:),nenv),@(x) MeasurementFcnDengue(x,1,nclus),INITekf);
end
Covariance=ValidarMatriz(Covariance);
myEKF.ProcessNoise=ProcesNoise;
myEKF.StateCovariance=Covariance;
myEKF.MeasurementNoise=MeasNoise;
%handles.myEKF=myEKF;
%guidata(hObject,handles);
setappdata(0,'myEKF',myEKF)
catch %error
   %if error.identifier=='MATLAB:guidata:InvalidInput'
   %    setappdata(0,'myEKF',myEKF)
   %else
   warndlg('There is an error in the configuration that is used for forecasting or the licence for EKF is not working','Configuration Problem','replace')
   %end
end

if exist('myEKF')
warndlg('The Filter is Ready To Be Used','Filter Ready','replace')
end



% --- Executes on button press in pushbutton133.
function pushbutton133_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton133 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit106_Callback(hObject, eventdata, handles)
% hObject    handle to edit106 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit106 as text
%        str2double(get(hObject,'String')) returns contents of edit106 as a double


% --- Executes during object creation, after setting all properties.
function edit106_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit106 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menu_file_save_all_Callback(hObject, eventdata, handles)
state.edit25=get(handles.edit25,'String');
state.table1=get(handles.table1,'Data');
state.uitable18=get(handles.uitable18,'Data');
state.uitable19=get(handles.uitable19,'Data');
state.uitable9=get(handles.uitable9,'Data');
state.uitable10=get(handles.uitable10,'Data');
state.uitable13=get(handles.uitable13,'Data');
state.uitable21=get(handles.uitable21,'Data');
state.uitable23=get(handles.uitable23,'Data');
state.uitable22=get(handles.uitable22,'Data');
state.radiob36=get(handles.radiob36,'Value');
state.radiob37=get(handles.radiob37,'Value');
state.radiob53=get(handles.radiob53,'Value');
%state.radiob47=get(handles.radiob47,'Value');
%state.radiob48=get(handles.radiob48,'Value');
%state.radiob52=get(handles.radiob52,'Value');
state.AA=getappdata(0,'AA');
state.A=getappdata(0,'A');
state.E=getappdata(0,'E');
state.V=getappdata(0,'V');
state.T=getappdata(0,'T');
state.F=getappdata(0,'F');
state.FN=getappdata(0,'FN');


save('state.mat',state)


% --------------------------------------------------------------------
function file_loadstates_Callback(hObject, eventdata, handles)
fileName='state.mat';
if exist(filename)
    load(filename)
set(handles.edit25,'String',state.edit25)
set(handles.table1,'Data',state.table1);
set(handles.uitable18,'Data',state.uitable18);
set(handles.uitable19,'Data',state.uitable19);
set(handles.uitable9,'Data',state.uitable9);
set(handles.uitable10,'Data',state.uitable10);
set(handles.uitable13,'Data',state.uitable13);
set(handles.uitable21,'Data',state.uitable21);
set(handles.uitable23,'Data',state.uitable23);
set(handles.uitable22,'Data',state.uitable22);
set(handles.radiob36,'Value',state.radiob36);
set(handles.radiob37,'Value',state.radiob37);
set(handles.radiob53,'Value',state.radiob53);
%set(handles.radiob47,'Value',state.radiob47);
%set(handles.radiob48,'Value',state.radiob48);
%set(handles.radiob52,'Value',state.radiob52);
setappdata(0,'AA',state.AA);
setappdata(0,'A',state.A);
setappdata(0,'E',state.E);
setappdata(0,'V',state.V);
setappdata(0,'T',state.T);
setappdata(0,'F',state.F);
setappdata(0,'FN',state.FN);
end


% --- Executes on button press in checkbox22.
function checkbox22_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox22


% --- Executes on button press in checkbox24.
function checkbox24_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox24


% --- Executes on button press in checkbox25.
function checkbox25_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox25



function edit108_Callback(hObject, eventdata, handles)
% hObject    handle to edit108 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit108 as text
%        str2double(get(hObject,'String')) returns contents of edit108 as a double


% --- Executes during object creation, after setting all properties.
function edit108_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit108 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton135.
function pushbutton135_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton135 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupm25.
function popupm25_Callback(hObject, eventdata, handles)
% hObject    handle to popupm25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupm25 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupm25


% --- Executes during object creation, after setting all properties.
function popupm25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupm25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton136.
function pushbutton136_Callback(hObject, eventdata, handles)


% --- Executes on button press in pushb137.
function pushb137_Callback(hObject, eventdata, handles)


% --- Executes on selection change in popupm26.
function popupm26_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popupm26_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushb138.
function pushb138_Callback(hObject, eventdata, handles)
%handles=guidata(gcbo);
stopCriteria=0;
while stopCriteria==0
NumParticles=str2double(get(handles.edit80,'String'));
ProcessNoise=str2double(get(handles.edit108,'String'));
nclus=str2double(get(handles.edit25,'String'));
nenv=str2double(get(handles.edit119,'String'));
resampMethod=get(handles.popupm26,'Value');
stateEstMethod=get(handles.popupm25,'Value');
covariance=str2double(get(handles.edit109,'String'));
sistema=[get(handles.radiob36,'Value') get(handles.radiob37,'Value') get(handles.radiob53,'Value')==1];

if resampMethod==1
    resampM='multinomial'; 
elseif resampMethod==2
    resampM='residual';
elseif resampMethod==3
    resampM='stratified';
elseif resampMethod==4
    resampM='systematic';
end

if stateEstMethod==1
    stateEstM='mean';
else
    stateEstM='maxweight';
end
%%%%%%%%%% esto es de crear el filtro con PF
ForeDays=get(handles.popupmForecastingDays,'Value');
BackDays=str2double(get(handles.editBackwardDays,'String'));
initialdaySelection=get(handles.popupm28,'Value');
initialdays=get(handles.popupm28,'String');
E=getappdata(0,'E');
V=getappdata(0,'V');
T=getappdata(0,'T');
A=getappdata(0,'A');
tempt=0;

if isempty(T)==1 || get(handles.radiob87,'Value')==1
    TEMP=get(handles.uitable42,'Data');
else
    TEMP=T(:,1:nclus+1);
    TEMP.TIME=datenum(TEMP.TIME);
    TEMP=table2array(TEMP);
end

if get(handles.checkbox22,'Value')==1
   datosT=get(handles.uitableWeatherPrediction,'Data');
    for i=1:size(datosT)
       if isempty(finde(find(TEMP(:,1)==datosT(i,1))))==1  
          TEMP=[TEMP; datosT];  
       end
    end
      TEMP=sortrows(TEMP);  
end

if get(handles.radiobInfectedHost,'Value')==1
    caso=1;
elseif get(handles.radiobCAccumulated,'Value')==1
    caso=2;
elseif get(handles.radiob124,'Value')==1 && get(handles.radiob37,'Value')==1 
    caso=3;
elseif get(handles.radiob124,'Value')==1 && get(handles.radiob53,'Value')==1
    caso=4;
elseif get(handles.radiob123,'Value')==1
    caso=5;
elseif get(handles.radiob122,'Value')==1
    caso=6;
elseif get(handles.radiob121,'Value')==1
    caso=7;
end

while tempt==0
if find(sistema==1)==1 
    q=get(handles.uitable13,'Data');
    param=get(handles.uitable9,'Data');
    init=get(handles.uitable10,'Data');
    [PARAM,Q,INIT,SETEO1,SETEO2,SETEO3]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);
    MOM=E(:,1:nclus+1);
    xlims=[datenum(initialdays(initialdaySelection,1))-BackDays, datenum(initialdays(initialdaySelection,1))];
    MOM.TIME=datenum(MOM.TIME);
    [~,ind1] = min(abs(xlims(1)-MOM.TIME));
    [~,ind2] = min(abs(xlims(2)-MOM.TIME));
    %%%%%%%%%%%%%%%%%%%%%%%    
    xdata=MOM.TIME(ind1:ind2,1);
    ydata=cell2mat(table2cell(MOM(ind1:ind2,2:end)));
    Xdata=[xdata; (xdata(end)+1:1:xdata(end)+ForeDays)'];
    if get(handles.checkbox26,'Value')==1
        ResultadosFijarCoef=ODEs(7,sistema,nclus,BackDays,ForeDays,E,V,TEMP,A,q,param,init,Q,PARAM,INIT,1,handles,xdata,ydata,Xdata,SETEO1,SETEO2,SETEO3,nenv);
        INITpf=ResultadosFijarCoef{4};
        TransferirParameters(ResultadosFijarCoef,nclus,handles);
    else
        for i=1:size(init,1)
            if i==3 && get(handles.radiobInfectedHost,'Value')==1  
                INIT(2*nclus+1:3*nclus)=ydata(1,:);
            elseif i==8 && get(handles.radiobCAccumulated,'Value')==1 
                INIT(7*nclus+1:8*nclus)=ydata(1,:);
            end
        end    
    INITpf=INIT;
    end    
    myPF=particleFilter(@(x)dengueODE12(x,nclus,Q, PARAM(1,:),PARAM(2,:),PARAM(3,:),PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), PARAM(10,:), PARAM(11,:),ProcessNoise),@vdpMeasurementLikelihoodFcnEduardo);
    
elseif find(sistema==1)==2
    q=get(handles.uitable23,'Data');
    param=get(handles.uitable21,'Data');
    init=get(handles.uitable22,'Data');    
    [PARAM,Q,INIT,SETEO1,SETEO2,SETEO3]=EvaluarMatrix(size(param,1),size(init,1),param,q,init,nclus);   
    MOM=E(:,1:nclus+1);
    xlims=[datenum(initialdays(initialdaySelection,1))-BackDays, datenum(initialdays(initialdaySelection,1))];
    MOM.TIME=datenum(MOM.TIME);
    [~,ind1] = min(abs(xlims(1)-MOM.TIME));
    [~,ind2] = min(abs(xlims(2)-MOM.TIME));
    %%%%%%%%%%%%%%%%%%%%%%%    
    xdata=MOM.TIME(ind1:ind2,1);
    ydata=cell2mat(table2cell(MOM(ind1:ind2,2:end)));
    Xdata=[xdata; (xdata(end)+1:1:xdata(end)+ForeDays)'];
      
    if get(handles.checkbox26,'Value')==1
    ResultadosFijarCoef=ODEs(7,sistema,nclus,BackDays,ForeDays,E,V,TEMP,A,q,param,init,Q,PARAM,INIT,1,handles,xdata,ydata,Xdata,SETEO1,SETEO2,SETEO3,nenv);
    INITpf=ResultadosFijarCoef{4};
    TransferirParameters(ResultadosFijarCoef,nclus,handles)
    else
       for i=1:size(init,1)
            if i==3 && get(handles.radiobInfectedHost,'Value')==1  
                INIT(2*nclus+1:3*nclus)=ydata(1,:);
            elseif i==8 && get(handles.radiobCAccumulated,'Value')==1
                INIT(7*nclus+1:8*nclus)=ydata(1,:);
            elseif i==2  && get(handles.radiob124,'Value')==1
                INIT(nclus+1:2*nclus)=ydata(1,:);
            end
        end    
        INITpf=INIT; 
    end
    myPF=particleFilter(@(x) dengueODE14_Modified(x,nclus,Q,TEMP,PARAM(1,:),PARAM(2,:),PARAM(3,:),PARAM(4,:),PARAM(5,:),PARAM(6,:),PARAM(7,:),PARAM(8,:),PARAM(9,:),PARAM(10,:),PARAM(11,:),PARAM(12,:),PARAM(13,:),PARAM(14,:),PARAM(15,:),PARAM(16,:),PARAM(17,:),PARAM(18,:),PARAM(19,:), PARAM(20,:), PARAM(21,:), PARAM(22,:), PARAM(23,:), PARAM(24,:),ProcessNoise,nenv),@vdpMeasurementLikelihoodFcnEduardo); 
    %myPF=particleFilter(@(x)dengueODE14(x,nclus,Q,TEMP,PARAM(1,:),PARAM(2,:),PARAM(3,:),PARAM(4,:),PARAM(5,:),PARAM(6,:),PARAM(7,:),PARAM(8,:),PARAM(9,:),PARAM(:,10),PARAM(11,:),PARAM(12,:),PARAM(13,:),PARAM(14,:),PARAM(15,:),PARAM(16,:),PARAM(17,:), PARAM(18,:), PARAM(19,:), PARAM(20,:), PARAM(21,:), PARAM(22,:), PARAM(23,:), PARAM(24,:),ProcessNoise),@vdpMeasurementLikelihoodFcn);
 
elseif find(sistema==1)==3 
    try
    MOM=V(:,1:nclus+1);
    catch
       warndlg('There is nothing to implement if the vector data have not been set','Warning','replace') 
    break
    end
    xlims=[datenum(initialdays(initialdaySelection,1))-BackDays, datenum(initialdays(initialdaySelection,1))];
    MOM.TIME=datenum(MOM.TIME);   
    [~,ind1] = min(abs(xlims(1)-MOM.TIME));
    [~,ind2] = min(abs(xlims(2)-MOM.TIME));  
    xdata=MOM.TIME(ind1:ind2,1);
    ydata=cell2mat(table2cell(MOM(ind1:ind2,2:end)));
    Xdata=[xdata; (xdata(end)+1:1:xdata(end)+ForeDays)'];  
       
       
    param=get(handles.uitable18,'Data');
    init=get(handles.uitable19,'Data');  
    [PARAM,Q,INIT,SETEO1,SETEO2,SETEO3]=EvaluarMatrix(size(param,1),size(init,1),param,[],init,nclus);
    if get(handles.checkbox26,'Value')==1
    ResultadosFijarCoef=ODEs(7,sistema,nclus,BackDays,ForeDays,E,V,TEMP,A,[],param,init,Q,PARAM,INIT,1,handles,xdata,ydata,Xdata,SETEO1,SETEO2,SETEO3,nenv);
    INITpf=ResultadosFijarCoef{4};
    TransferirParameters(ResultadosFijarCoef,nclus,handles)
    else
      for i=1:size(init,1)
            if i==1 && get(handles.radiob121,'Value')==1  
                INIT(1:nclus)=ydata(1,:);
            elseif i==2 && get(handles.radiob122,'Value')==1
                INIT(nclus+1:2*nclus)=ydata(1,:);
            elseif i==3 && get(handles.radiob123,'Value')==1
                INIT(2*nclus+1:3*nclus)=ydata(1,:);
            elseif i==5 && get(handles.radiob124,'Value')==1
                INIT(4*nclus+1:5*nclus)=ydata(1,:);        
            end
      end    
        INITpf=INIT;   
    
    end
    myPF=particleFilter(@(x)dengueODE13_Modified(x,nclus,TEMP, PARAM(1,:),PARAM(2,:),PARAM(3,:),PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), PARAM(10,:), PARAM(11,:), PARAM(12,:), PARAM(13,:), PARAM(14,:), PARAM(15,:),ProcessNoise,nenv),@vdpMeasurementLikelihoodFcnEduardo);
elseif find(sistema==1)==4 || find(sistema==1)==5 || find(sistema==1)==4
    warndlg('The Stochastic Processes are not programmed yet')
    break
end
initialize(myPF,NumParticles,INITpf,diag(INITpf)*covariance/100)
myPF.StateEstimationMethod=stateEstM;
myPF.ResamplingMethod=resampM;
tempt=1;
setappdata(0,'myPF',myPF)
warndlg('The filter is ready to be used','Particle Filter','replace')
end

try
guidata(hObject,handles)
catch error
   if error.identifier=='MATLAB:guidata:InvalidInput'
       setappdata(0,'myPF',myPF)
   else
   warndlg('There is an error in the configuration that is used for forecasting','PF Configuratoin Problem','relace')
   end
end
stopCriteria=1;
end

function edit109_Callback(hObject, eventdata, handles)

function edit109_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function radiob54_Callback(hObject, eventdata, handles)
set(handles.radiob121,'Value',1)

function radiob55_Callback(hObject, eventdata, handles)
set(handles.radiob122,'Value',1)

function radiob56_Callback(hObject, eventdata, handles)
set(handles.radiob123,'Value',1)

function radiob57_Callback(hObject, eventdata, handles)
set(handles.radiob124,'Value',1)

function radiob62_Callback(hObject, eventdata, handles)
set(handles.radiobInfectedHost,'Value',1)

function radiob121_Callback(hObject, eventdata, handles)
set(handles.radiob54,'Value',1)

function radiob122_Callback(hObject, eventdata, handles)
set(handles.radiob55,'Value',1)

function radiob123_Callback(hObject, eventdata, handles)
set(handles.radiob56,'Value',1)

function radiob124_Callback(hObject, eventdata, handles)
set(handles.radiob57,'Value',1)

function radiobInfectedHost_Callback(hObject, eventdata, handles)
set(handles.radiob62,'Value',1)


function radiobCAccumulated_Callback(hObject, eventdata, handles)
set(handles.radiob63,'Value',1)


function pushbutton140_Callback(hObject, eventdata, handles)
respuesta=questdlg('The data "SET" will be trimmed (if set already exist) inf function of the selected range (same will happen with the table data). Proceed?','Trim Data','Yes','No','Yes');
if strcmp(respuesta,'Yes')==1
    try
        xlims=get(handles.axes1,'Xlim');
        dataraw=get(handles.table1,'Data');
        [~,ind1] = min(abs(datenum(xlims(1))-datenum(dataraw(:,1))));
        [~,ind2] = min(abs(datenum(xlims(2))-datenum(dataraw(:,1))));
        E=getappdata(0,'E');
        V=getappdata(0,'V');
        T=getappdata(0,'T');
        A=getappdata(0,'A');
        AA=getappdata(0,'AA');        
        set(handles.edit29,'String',num2str(datenum(dataraw(1,1))))
        set(handles.edit30,'String',num2str(datenum(dataraw(end,1))))
        nume=seteoNombresStrings(handles);
        mom=get(handles.table1,'Data');
        mom=mom(ind1:ind2,:);
        set(handles.table1,'Data',mom);  
    catch
        warndlg('Make sure to load some data in the table and figure before triming')
    end
end

if isempty(A)==0
    try
            [~,ind1] = min(abs(datenum(xlims(1))-datenum(A.TIME)));
            [~,ind2] = min(abs(datenum(xlims(2))-datenum(A.TIME)));
            A=A(ind1:ind2,:); 
            setappdata(0,'A',A);
    catch
    end
end

try
            AA=getappdata(0,'AA');
           AA=AA(ind1:ind2,:);
           setappdata(0,'AA',AA);
catch
end
pushb9_Callback(@push9_Callback, eventdata, handles)

function pushb141_Callback(hObject, eventdata, handles)
cla(handles.axes1);
cla(handles.axes11);
cla(handles.axes16);
cla(handles.axes23);
cla(handles.axes24);
set(handles.table1, 'Data', cell(size(get(handles.table1,'Data'))));

function checkbox27_Callback(hObject, eventdata, handles)

function checkbox26_Callback(hObject, ~, handles)

function menu_clear_Callback(hObject, eventdata, handles)

function pushbutton145_Callback(hObject, eventdata, handles)

function popupm28_Callback(hObject, eventdata, handles)

function popupm28_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton146_Callback(hObject, eventdata, handles)
F=getappdata(0,'F');
if size(F,2)~=0
   F(end)=[];
  setappdata(0,'F',F) 
    pushbutton81_Callback(@pushbutton81_Callback, eventdata, handles)
end

function pushbutton148_Callback(hObject, eventdata, handles)
nclus=str2double(get(handles.edit25,'String'));
rep=get(handles.edit115,'String');
rep=ceil(str2double(rep));
for i=1:rep
    try
        F=getappdata(0,'F');
        if isempty(F)==1 || i==1
            pushbForecast_Callback(@pushbForecast_Callback,0, handles)
        elseif size(F,2)~=0
            OldDay=(F{1,end}{end,1});
            fechas=get(handles.popupm28,'String');
            try
                ind=find(fechas==OldDay);
            catch
                ind=[]; 
            end
            if isempty(ind)==0
                set(handles.popupm28,'Value',ind);
            else
                set(handles.popupm28,'Value',size(fechas,1));
            end
            try            
                if get(handles.radiobNoFiltering,'Value')==1
                    pushbForecast_Callback(@pushbForecast_Callback,eventdata, handles)
                    elseif get(handles.radiobEKF,'Value')==1
                        if get(handles.checkbox28,'Value')==0
                        pushbForecast_Callback(@pushbForecast_Callback,1, handles)
                        else
                        pushb132_Callback(hObject, eventdata, handles)
                        pushbForecast_Callback(@pushbForecast_Callback,0, handles)
                        end
                    elseif get(handles.radiobPF,'Value')==1  
                        if get(handles.checkbox29,'Value')==0
                        pushbForecast_Callback(@pushbForecast_Callback,1, handles)
                        else
                        pushb138_Callback(hObject, eventdata, handles)
                        pushbForecast_Callback(@pushbForecast_Callback,0, handles)
                        end
                end                   
                FN=getappdata(0,'F');
                datosF=F{1,end}{:,1};
                tablaF=F{1,end};
                datosFN=FN{1,end}{:,1};
                tablaFN=FN{1,end};
                indices=[];
                for i=1:size(datosF,1)
                    indices=[indices; find(datenum(datosFN)==datenum(datosF(i)))];
                end
                tablaFN(indices,:)=[];
                pushbutton146_Callback(@pushbutton146_Callback, eventdata, handles)
                pushbutton146_Callback(@pushbutton146_Callback, eventdata, handles)
                F=getappdata(0,'F');
                F{1,end+1}=[tablaF; tablaFN];
                setappdata(0,'F',F)
                pushbutton81_Callback(@pushbutton81_Callback, eventdata, handles)
                if get(handles.radiob53,'Value')==1
                    TIPO='V';
                else
                    TIPO='E';
                end
                MSE(handles,[tablaF; tablaFN],TIPO,nclus)
            catch error
                error
                warndlg('The type of setting used in the first saved forecasting do not fit do not fit the following forecasting','Configuration Problem','replace') 
            end
        end
    catch
        warndlg(strcat('There is problems related to the ',num2str(i), ' iteration, IF its the first iteration check your setting'),'Step Error','replace')
    end
end

function pushb149_Callback(hObject, eventdata, handles)

function pushbutton150_Callback(hObject, eventdata, handles)

function edit115_Callback(hObject, eventdata, handles)

function edit115_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit116_Callback(hObject, eventdata, handles)

function edit116_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit117_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit118_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function checkbox28_Callback(hObject, eventdata, handles)

function checkbox29_Callback(hObject, eventdata, handles)

function edit114_Callback(hObject, eventdata, handles)

function edit114_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit119_Callback(hObject, eventdata, handles)
set(handles.edit121,'String',get(handles.edit119,'String'))

Nenvironmental=str2double(get(handles.edit119,'String'));
B=get(handles.uitable21,'Data');
A=get(handles.uitable18,'Data');
if size(A,1)~=6*Nenvironmental+9 && get(handles.radiob36,'Value')~=1
    name={};
    for i=1:Nenvironmental
       name{end+1}=strcat('mu1_',num2str(i));
    end
    for i=1:Nenvironmental
       name{end+1}=strcat('mu2_',num2str(i));
    end
    for i=1:Nenvironmental
       name{end+1}=strcat('mu3_',num2str(i));
    end
    for i=1:Nenvironmental
       name{end+1}=strcat('mu4_',num2str(i));
    end
    for i=1:Nenvironmental
       name{end+1}=strcat('mu5_',num2str(i));
    end
    for i=1:Nenvironmental
       name{end+1}=strcat('mu6_',num2str(i));  
    end
    name=['ko','ep','Tp','Tl','Ti','Te','Pre01','Pre02','Pre03', name];
try    
    [row,col]=size(A);
    Amom=repmat(A(10:15,:),Nenvironmental,1);
    Afinal=[A(1:9,:); Amom];
    set(handles.uitable18,'Data',Afinal)
    set(handles.uitable18,'RowName',name)
    set(handles.uitable53,'RowName',name)
catch
end
end

if size(B,1)~=6*Nenvironmental+18 && get(handles.radiob36,'Value')~=1
      name={};
    for i=1:Nenvironmental
       name{end+1}=strcat('mu1_',num2str(i));
    end
    for i=1:Nenvironmental
       name{end+1}=strcat('mu2_',num2str(i));
    end
    for i=1:Nenvironmental
       name{end+1}=strcat('mu3_',num2str(i));
    end
    for i=1:Nenvironmental
       name{end+1}=strcat('mu4_',num2str(i));
    end
    for i=1:Nenvironmental
       name{end+1}=strcat('mu5_',num2str(i));
    end
    for i=1:Nenvironmental
       name{end+1}=strcat('mu6_',num2str(i)); 
    end
    name=['Nh','Uh','kv','kh','Gama','Alpha','Pv','Ph','Tau','ko','ep','Tp','Tl','Ti','Te','Pre01','Pre02','Pre03',name];   
    [row,col]=size(B);
    Bmom=repmat(B(19:24,:),Nenvironmental,1);
    Bfinal=[B(1:18,:); Bmom];
    set(handles.uitable21,'Data',Bfinal)
    set(handles.uitable21,'RowName',name)  
    set(handles.uitable52,'RowName',name) 
end

edit25_Callback(@edit25_Callback,eventdata,handles)
    
function edit119_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit120_Callback(hObject, eventdata, handles)

function edit121_Callback(hObject, eventdata, handles)
set(handles.edit119,'String',get(handles.edit121,'String'))
edit119_Callback(@edit119_Callback,eventdata,handles)

function edit121_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit120_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit122_Callback(hObject, eventdata, handles)

function edit122_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit123_Callback(hObject, eventdata, handles)

function edit123_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton155_Callback(hObject, eventdata, handles)

function pushbutton156_Callback(hObject, eventdata, handles)

function pushbutton157_Callback(hObject, eventdata, handles)
conn=getappdata(0,'conn');

if isopen(conn)==1
    try
        tablename=get(handles.popupm31,'String');
        selection=get(handles.popupm31,'Value');
        catalogs=get(handles.popupm29,'String');
   catalog=catalogs{get(handles.popupm29,'Value')};
        TABLA=tail(sqlread(conn,tablename{selection},'Catalog',catalog));
        if isempty(TABLA)==0
        set(handles.uitable114,'Data',TABLA)
        else
            warndlg('The Table is Empty','No Data to Show','replace')
        end
    catch
    end   
end

function pushb159_Callback(hObject, eventdata, handles)
conn=getappdata(0,'conn');
userdata=get(hObject,'UserData');
dbname=get(handles.edit125,'String');
username=get(handles.edit126,'String');

if  isempty(conn)==0 && userdata==1 && strcmp(conn.UserName,username)==1 && strcmp(conn.DataSource,dbname)==1
            close(conn)  
    setappdata(0,'conn',[])
       set(handles.uipanel79,'visible','off')
        set(handles.uipanel80,'visible','off')
        set(handles.uipanel81,'visible','off')
    set(hObject,'UserData',0)
    set(handles.pushb159,'BackgroundColor',[1,0,0])
else
    try 
        password=get(handles.edit127,'String');
        server=get(handles.edit124,'String');
        if get(handles.listbox28,'value')==1
            vendor='MySQL';
            conn = database(dbname,username,password,'Vendor',vendor,'Server',server);
            if findstr(conn.Message,'No suitable driver found')==1
            [filename,path]=uigetfile('*.jar','Specify The Path to the Java Loader (Some Versios Can not Necesarily Work)');
            javaaddpath(strcat(path,filename))
            conn = database(dbname,username,password,'Vendor',vendor,'Server',server);
            end            
        elseif get(handles.listbox28,'value')==2 
        end
        setappdata(0,'conn',conn)
        set(hObject,'UserData',1)
        set(handles.popupm29,'String',conn.Catalogs(1:end-1)) %the last catalog (check, i always an information _schema)
        tablas=tables(conn,conn.Catalogs{1});
        set(handles.popupm31,'String',tablas(:,1))
        
        set(handles.uipanel79,'visible','on')
        set(handles.uipanel80,'visible','on')
        set(handles.uipanel81,'visible','on')
        set(handles.pushb159,'BackgroundColor',[0,1,0])
        
catch
    opts=struct('WindowStyle','replace','Interpreter','tex');
   warndlg('There is an error in the configuration set for connection or in the database make sure you have the required driver for JAVA communication (mysql-connector-java-5.1.47.jar)',opts) 
end                   
end
            
function edit125_Callback(hObject, eventdata, handles)

function edit125_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox28_Callback(hObject, eventdata, handles)

function listbox28_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit124_Callback(hObject, eventdata, handles)

function edit124_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function radiobutton157_Callback(hObject, eventdata, handles)
set(handles.edit124,'String','localhost')

function edit126_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit127_Callback(hObject, eventdata, handles)

function edit127_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function radiobutton156_Callback(hObject, eventdata, handles)
set(handles.edit124,'String','143.239.81.204')

function pushbutton161_Callback(hObject, eventdata, handles)
try
names=get(handles.uitable115,'ColumnName');
Info=get(handles.uitable115,'Data');
sistema=[get(handles.radiob36,'Value') get(handles.radiob37,'Value') get(handles.radiob53,'Value')==1];
nclus=str2double(get(handles.edit25,'String'));
locations=string(get(handles.popupm34,'String'));
location=locations(get(handles.popupm34,'Value'));

if isempty(find(contains(names,'LOCATION')))==0 && isempty(find(contains(names,'TIME')))==0
    if get(handles.radiob158,'Value')==1
        sim1=getappdata(0,'SimResults');
        sim2=getappdata(0,'SimResults2');
        sim3=getappdata(0,'SimResults3');
        dates=cellstr(datestr(sim3(:,1),'yyyy-mm-dd'));
    elseif get(handles.radiob159,'Value')==1     
        Data=get(handles.uitable43,'Data');
        if sistema(1)==1 || sistema(2)==1
        Data=Data(:,2*nclus+1:3*nclus);           
        elseif sistema==3 || sistema ==6
        Data=Data(:,2*nclus+1:3*nclus);    
        end
        dates=cellstr(datestr(Data(:,1),'yyyy-mm-dd'));
        data=num2cell(Data(:,1:end));
        if strcmp(location,'N.A.')==1
        warndlg('N.A canot be used as localitation','Cant use N.A. for this process',replace)
        else
        set(handles.uitable115,'Data', [cellstr(repmat(location,[numel(dates),1])) dates data])
        end
    elseif get(handles.radiob160,'Value')==1 %from load panel to table
        Data=get(handles.table1,'Data');
        dates=cellstr(datestr(Data(:,1),'yyyy-mm-dd'));
        data=num2cell(Data(:,2:end));    
        if strcmp(location,'N.A.')==1
        set(handles.uitable115,'Data', [dates data])
        else
        set(handles.uitable115,'Data', [cellstr(repmat(location,[numel(dates),1])) dates data])
        end
    elseif get(handles.radiob162,'Value')==1
        colinfo1=find(contains(names,'TIME'));
        colinfo2=find(contains(names,'VECT'));
        colinfo3=find(contains(names,'LOCATION'));      
        if strcmp(location,'N.A.')==0
        rows=find(contains(Info(:,colinfo3),location));
        else
        rows=[1:size(Info,1)];
        end
        info=[Info(rows,colinfo1) Info(rows,colinfo2)]';
        info=cell2mat(info);
        V=getappdata(0,'V');
        if isempty(V)==1 && isempty(info)==0
        tableout=array2table(info,'VariableNames',{'TIME','VECT1'});
        tableout.TIME=datetime(datevec(tableout.TIME));
        setappdata(0,'V',tableout);
        elseif isempty(info)==0
            answer=questdlg('There is information in the memory for vector. Attach the new data and synchronize (otherwise will be replaced make sure that the number of nodes is the same)','Attach Data?','Yes','No','Yes');
            if strcmp(answer,'Yes')==1
            columnes=size(V,2);
            V.TIME=datetime(datevec(V.TIME));   
            V=table2timetable(V);
            tableoutm=array2table(info,'VariableNames',{'TIME',strcat('VECT',num2str(columnes))});
            tableoutm.TIME=datetime(datevec(tableoutm.TIME));
            tableoutm=table2timetable(tableoutm);
            methods=get(handles.popupm1,'String');
            method=methods(get(handles.popupm1,'Value'));
            tableout=synchronize(V,tableoutm,'regular',method{1},'TimeStep',days(1));
            setappdata(0,'AA',tableout)
            tableout=timetable2table(tableout);
            setappdata(0,'V',tableout);
            else
            tableout=array2table(info,'VariableNames',{'TIME','VECT1'});
            tableout.TIME=datetime(datevec(tableout.TIME));
            setappdata(0,'V',tableout);    
            end
            elseif isempty(info)==1 || size(info,2)==1
            warndlg('The matrix should contain a column with the VECT name on it','No Information','replace')
        end 
    elseif get(handles.radiob163,'Value')==1
        colinfo1=find(contains(names,'TIME')); 
        colinfo2=find(contains(names,'INFECT_TOTAL'));
        colinfo3=find(contains(names,'LOCATION'));
        if strcmp(location,'N.A.')==0
        rows=find(contains(Info(:,colinfo3),location));
        else
        rows=[1:size(Info,1)];
        end
        info=[Info{rows,colinfo1}; Info{rows,colinfo2}]';      
        E=getappdata(0,'E');
        if isempty(E)==1 && isempty(info)==0
            tableout=array2table(info,'VariableNames',{'TIME','InfectInfo1'});
            tableout.TIME=datetime(datevec(tableout.TIME));
            setappdata(0,'E',tableout);
        elseif isempty(info)==0
            answer=questdlg('There is information in the memory for infection. Attach the new data and synchronize (otherwise will be replaced make sure that the number of nodes is the same)','Attach Data?','Yes','No','Yes');
            if strcmp(answer,'Yes')==1
            columnes=size(E,2);
            E.TIME=datetime(datevec(E.TIME));   
            E=table2timetable(E);
            tableoutm=array2table(info,'VariableNames',{'TIME',strcat('InfectInfo',num2str(columnes))});
            tableoutm.TIME=datetime(datevec(tableoutm.TIME));
            tableoutm=table2timetable(tableoutm);
            methods=get(handles.popupm1,'String');
            method=methods(get(handles.popupm1,'Value'));
            tableout=synchronize(E,tableoutm,'regular',method{1},'TimeStep',days(1));
            setappdata(0,'AA',tableout)
            tableout=timetable2table(tableout);
            setappdata(0,'E',tableout);
            set(handles.edit25,'String',num2str(columnes))
            edit25_Callback(@edit25_Callback,1,handles)
            else
            tableout=array2table(info,'VariableNames',{'TIME','InfectInfo1'});
            tableout.TIME=datetime(datevec(tableout.TIME));
            setappdata(0,'E',tableout);    
            end
        end  
    elseif get(handles.radiob164,'Value')==1
        colinfo1=find(contains(names,'TIME')); 
        colinfo3=find(contains(names,'LOCATION'));
        colinfo2=find(contains(names,'ENV1'));
        colinfo4=find(contains(names,'ENV2'));
        colinfo5=find(contains(names,'ENV3'));
        if strcmp(location,'N.A.')==0
        rows=find(contains(Info(:,colinfo3),location));
        else
        rows=[1:size(Info,1)];
        end
        info=[Info{rows,colinfo1}; Info{rows,colinfo2}; Info{rows,colinfo4}; Info{rows,colinfo5}]';
        for i=1:size(info,2)
            if sum(any(info(:,i)<0))==1
                info(:,i)=[];
            end    
        end
        T=getappdata(0,'T');
        if isempty(T)==1 && isempty(info)==0
        set(handles.edit119,'String',num2str(size(info,2)-1))
        edit119_Callback(@edit119_Callback,1,handles)
        stringtocolocate={'TIME'};
        for i=2:size(info,2)
            stringtocolocate{i}=strcat('EnvVar',num2str(i-1),'Clus1');
        end
        tableout=array2table(info,'VariableNames',stringtocolocate);
        tableout.TIME=datetime(datevec(tableout.TIME));
        setappdata(0,'T',tableout);
        elseif isempty(info)==0
            answer=questdlg('There is information in the memory for vector. Replaced the information (Use table modification if you want to incorporate them)?.','Replace Information?','Yes','No','Yes');
        if strcmp(answer,'Yes')==1
            stringtocolocate={'TIME'};
        for i=1:size(info,2)
            stringtocolocate={stringtocolocate, strcat('EnvVar',num2str(i),'Clus1')};
        end
        tableout=array2table(info,'VariableNames',stringtocolocate);
        tableout.TIME=datetime(datevec(tableout.TIME));
        setappdata(0,'T',tableout);    
        end 
        end
    elseif get(handles.radiob165,'Value')==1
        colinfo1=find(contains(names,'TIME')); 
        colinfo2=find(contains(names,'INFECT_TOTAL'));
        colinfo3=find(contains(names,'LOCATION'));
        colinfo4=find(contains(names,'ENV1'));
        colinfo5=find(contains(names,'ENV2'));
        colinfo6=find(contains(names,'ENV3'));
        colinfo7=find(contains(names,'VECT'));       
        if strcmp(location,'N.A.')==0
            rows=find(contains(Info(:,colinfo3),location));
        else
            rows=[1:size(Info,1)];
        end
        info2=get(handles.table1,'Data');
        nclus=str2num(get(handles.edit25,'String'));
        names2=get(handles.table1,'ColumnName');
        try
            if get(handles.radiob49,'Value')==1 
                info1=[Info{rows,colinfo1}; Info{rows,colinfo2}]';
                if sum(info2(:,1))==0
                set(handles.edit25,'String','1')
                set(handles.radiob3,'Value',1)
                edit25_Callback(@edit25_Callback,1,handles); 
                set(handles.table1,'data',info1)         
                else
                    answer=questdlg('There is information in the table attach the data as new cluster (No will replace it)?.','Replace Information?','Yes','No','Yes');
                    if strcmp(answer,'Yes')==1
                    nclus=nclus+1;
                    set(handles.edit25,'String',num2str(nclus));
                    edit25_Callback(@edit25_Callback,1,handles);  
                    names1=get(handles.table1,'ColumnName');
                    for i=1:numel(names2)
                        if contains(names1,names2(i))
                            index=find(contains(names1,names2(i)));
                            names1(index)=[];
                        end
                    end                                     
                    tableoutm1=array2table(info1,'VariableNames',{'TIME',names1});
                    tableoutm1.TIME=datetime(datevec(tableoutm1.TIME));
                    tableoutm1=table2timetable(tableoutm1);
                    tableoutm2=array2table(info2,'VariableNames',names2);
                    tableoutm2.TIME=datetime(datevec(tableoutm2.TIME));
                    tableoutm2=table2timetable(tableoutm2);
                    methods=get(handles.popupm1,'String');
                    method=methods(get(handles.popupm1,'Value'));
                    tableout=synchronize(tableoutm1,tableoutm2,'regular',method{1},'TimeStep',days(1));
                    setappdata(0,'AA',tableout)
                    tableout=timetable2table(tableout);
                    tableout=table2array(tableout);
                    set(handles.table1,'Data',tableout)                  
                    else
                    set(handles.edit25,'String','1')
                    edit25_Callback(@edit25_Callback,1,handles); 
                    set(handles.table1,'data')
                    end
                end
            elseif get(handles.radiob50,'Value')==1
                info1=[Info{rows,colinfo1}; Info{rows,colinfo4}; Info{rows,colinfo5}; Info{rows,colinfo6}]';               
            if sum(info2(:,1))==0
                set(handles.edit121,'String','3')
                set(handles.edit25,'String','1')
                edit25_Callback(@edit25_Callback,1,handles); 
                set(handles.table1,'data',info1)
                set(handles.edit121,'String',num2str(size(info1,2)-1))
                edit121_Callback(@edit121_Callback,1,handles);
            else
                answer=questdlg('There is information in the table attach the data as new cluster (No will replace it)?.','Replace Information?','Yes','No','Yes');
                if strcmp(answer,'Yes')==1
                    nclus=nclus+1;
                    set(handles.edit25,'String',num2str(nclus))
                    edit25_Callback(@edit25_Callback,1,handles);  
                    names1=get(handles.table1,'ColumnName');
                    for i=1:numel(names2) 
                        if sum(contains(names1,names2(i)))==1 && strcmp(names2(i),'TIME')==0
                            index=find(contains(names1,names2(i)));
                            names1(index)=[];
                        end
                    end                                     
                    tableoutm1=array2table(info1,'VariableNames',names1);
                    tableoutm1.TIME=datetime(datevec(tableoutm1.TIME));
                    tableoutm1=table2timetable(tableoutm1);
                    tableoutm2=array2table(info2,'VariableNames',names2);
                    tableoutm2.TIME=datetime(datevec(tableoutm2.TIME));
                    tableoutm2=table2timetable(tableoutm2);
                    methods=get(handles.popupm1,'String');
                    method=methods(get(handles.popupm1,'Value'));
                    tableout=synchronize(tableoutm2,tableoutm1,'regular',method{1},'TimeStep',days(1));
                    setappdata(0,'AA',tableout)
                    tableout=timetable2table(tableout);
                    tableout.TIME=datenum(tableout.TIME);
                    tableout=table2array(tableout);
                    set(handles.table1,'Data',tableout)                  
                else
                    set(handles.edit25,'String','1')
                    edit25_Callback(@edit25_Callback,1,handles); 
                    set(handles.table1,'data',info1)
                    set(handles.edit121,'String',num2str(size(info1,2)-1))
                    edit121_Callback(@edit121_Callback,1,handles);
                end
            end 
        elseif get(handles.radiob51,'Value')==1
            set(handles.table1,'data',Info)   
        elseif get(hndles.radiob67,'Value')==1
             info1=[Info{rows,colinfo1}; Info{rows,colinfo7}];
             info1=cell2mat(info1);   
             set(handles.edit121,'String','1')
             edit25_Callback(@edit25_Callback,1,handles); 
             set(handles.table1,'data',info1)     
            end
    catch
       warndlg('The load configuration do not fit the requirement. Make sure to handle correctly the number of cluster an type of data already in table') 
    end
elseif get(handles.radiobmap,'Value')==1
    oldinfo=getappdata(0,'geoinfo');   
    colinfo1=find(contains(names,'TIME')); 
    colinfo2=find(contains(names,'LATITUDE'));
    colinfo3=find(contains(names,'LONGITUDE'));
    colinfo4=find(contains(names,'INFECT_TOTAL'));
    if isempty(oldinfo)==1
    Info=[Info(:,colinfo1) Info(:,colinfo2) Info(:,colinfo3) Info(:,colinfo4)];
    Info=cell2mat(Info);  
    else
    answer=questdlg('There is information in the memory for georeferencing map. Attach the new data (otherwise will be replaced)','Attach Data?','Yes','No','Yes');
        if strcmp(answer,'Yes')==1
            Infom=cell2mat([Info(:,colinfo1) Info(:,colinfo2) Info(:,colinfo3) Info(:,colinfo4)]);
            Info=[oldinfo; Infom];
        elseif strcmp(answer,'No')==1           
            Info=cell2mat([Info(:,colinfo1) Info(:,colinfo2) Info(:,colinfo3) Info(:,colinfo4)]);
        end
    end
    setappdata(0,'geoinfo',Info);
    Infot=datestr(datevec(sort(unique(Info(:,1)))));
    set(handles.listbox32,'String',Infot)
 end
else
    warndlg('The program do not interact with tables without a TIME tag','Table setup not usefull','replace') 
end
catch
   warndlg('The tables required as minimum the TIME tag as initial column. Check all your configuration and that the column names correspond to the reserved names and that you are selecting ONE SPECIFIC Location at a time. Furthermore, the syncrhonization is not performed for data that have repated days in the table (upload the data per location once at a time)','Configuratino Problem','replace')   
end

function pushb162_Callback(hObject, eventdata, handles)
try
values=char(get(handles.edit130,'string'));
tablein=get(handles.uitable115,'Data');
puntos=strfind(values,',');
if numel(puntos)+1~=size(tablein,2)
    warndlg('The number of values to incorporate do not match the number of columns in table, if you want to incorporate not values, leave the space in blank separated by colons','missing data','replace')
else
   try 
    primero=1;
    for i=1:size(tablein,2)-1
    textin{i}=values(primero:puntos(i)-1);
    if isempty(str2num(textin{i}))==0
        try
            textin{i}=num2str(datenum(textin{i}))
        catch
        end
        textin{i}=str2num(textin{i})
    end
    primero=puntos(i)+1;
    end
    textin{end+1}=values(primero:end);
    if isempty(str2num(textin{end}))==0
        textin{end}=str2num(textin{end})
    end
    nombres=get(handles.uitable114,'ColumnName');
    entradas=find(contains(nombres,'TIME'));
    for i=2:numel(nombres) 
        varname=nombres{i}
    end    
    textin=[tablein; textin];  
    set(handles.uitable115,'Data',textin)
   catch     
       
   end
end
catch
    warndlg('Is not allowed to create a table with only one columns','Not enough input information','replace')
end

function pushbutton163_Callback(hObject, eventdata, handles)
names=char(get(handles.edit130,'string'));
tablein=get(handles.uitable115,'Data');
puntos=strfind(names,',');
if numel(puntos)+1~=size(tablein,2)
    warndlg('The number of names do not match the number of columns in table')
else
   try 
    primero=1;
    for i=1:size(tablein,2)-1
    textin{i}=names(primero:puntos(i)-1);
    primero=puntos(i)+1;
    end
    textin{end+1}=names(primero:end);
    set(handles.uitable115,'ColumnName',textin)
   catch       
   end
end

function pushbutton165_Callback(hObject, eventdata, handles)
conn=getappdata(0,'conn');
try
    try
        out=fetch(conn,char(get(handles.edit130,'String')));
    catch
        out=exec(conn,char(get(handles.edit130,'String')));
        tablas=tables(conn,conn.Catalogs{get(handles.popupm29,'Value')});
        set(handles.popupm31,'String',tablas(:,1))
        if isempty(out.Message)==1 
            set(handles.text127,'ForegroundColor',[0,1,0])
            set(handles.text127,'String','Success')
        else
            set(handles.text127,'ForegroundColor',[1,0,0])
            set(handles.text127,'String',out.Message)
        end   
    end
    
    if isempty(out)==0 && istable(out)==1
       set(handles.text127,'ForegroundColor',[1,0,0])
       set(handles.text127,'String','Success')
       try
       set(handles.uitable115,'ColumnName',out.Properties.VariableNames)
       set(handles.uitable115,'Data',table2cell(out)) 
       catch
       end
    elseif isempty(out)==0 && iscell(out)==1
        set(handles.text127,'ForegroundColor',[1,0,0])
        set(handles.text127,'String','Success')
       try
       set(handles.uitable115,'ColumnName',out.Properties.VariableNames)
       set(handles.uitable115,'Data',table2cell(out)) 
       catch
       end
    end   
catch
   warndlg('There is a problem with the query or the connection','Query Problem','replace') 
end

function pushbutton166_Callback(hObject, eventdata, handles)
tablein=get(handles.uitable115,'Data');
names=char(get(handles.edit130,'String'));
puntos=strfind(names,',');
if numel(puntos)+1~=size(tablein,2)
    warndlg('The number of data to enter do not match the number of columns in table')
else
   try 
    primero=1;
    for i=1:size(tablein,2)-1
    textin{i}=names(primero:puntos(i)-1);
    primero=puntos(i)+1;
    end
    textin{end+1}=names(primero:end); 
    tableout=[tablein; textin];  
    set(handles.uitable115,'Data',tableout)
   catch       
   end
end

function pushb170_Callback(hObject, eventdata, handles)
conn=getappdata(0,'conn');
INFORMATION=str2num(get(handles.edit130,'String'));
try 
catch
   warndlg('There is a problem with the quiery') 
end

function pushbutton168_Callback(hObject, eventdata, handles)
conn=getappdata(0,'conn');
try
if isempty(conn.Message)==1
   tablesnames=get(handles.popupm31,'String');
   tablename=tablesnames{get(handles.popupm31,'Value')};
   catalogs=get(handles.popupm29,'String');
   catalog=catalogs{get(handles.popupm29,'Value')};
   info=sqlread(conn,tablename,'Catalog',catalog,'MaxRows',8);
   columnames=info.Properties.VariableNames;
   info=table2cell(info);
   set(handles.uitable114,'Data',info);
   set(handles.uitable114,'ColumnName',columnames);
   times=strfind(columnames,'TIME');
   initial=table2cell(fetch(conn,char(strcat('SELECT MIN(TIME) FROM',{' '},catalog,'.',tablename))));
   final=table2cell(fetch(conn,char(strcat('SELECT MAX(TIME) FROM',{' '},catalog,'.',tablename))));   
   if sum(cell2mat(strfind(columnames,'LOCATION'))==1) && sum(cell2mat(strfind(columnames,'TIME'))==1)    
       locations=table2cell(fetch(conn,char(strcat('SELECT DISTINCT LOCATION FROM',{' '},catalog,'.',tablename, {' '},'ORDER BY LOCATION ASC'))));
       locations=['Unknown';'N.A.';locations];
       set(handles.popupm34,'string',locations)  
   end
   if isnumeric(initial{1})==1
   set(handles.edit132,'String',datestr(datevec(initial{1})))
   set(handles.edit133,'String',datestr(datevec(final{1})))
   end   
end
catch
end

function pushb169_Callback(hObject, eventdata, handles)
conn=getappdata(0,'conn');

function pushbutton172_Callback(hObject, eventdata, handles)
    conn=getappdata(0,'conn');
    Tablas=get(handles.popupm31,'String');
    tableseleccion=Tablas(get(handles.popupm31,'Value'));
    names=get(handles.uitable115,'ColumnName');
    data=array2table(get(handles.uitable115,'Data'),'VariableNames',names'); 
    if isempty(get(handles.edit131,'String'))==1 && isempty(conn)==0
        try
        sqlwrite(conn,tableseleccion{1},data);
        set(handles.text127,'ForegroundColor',[0, 1, 0])
        set(handles.text127,'String','Success')
        
        catch ME
        set(handles.text127,'ForegroundColor',[1, 0, 0])    
        set(handles.text127,'String',ME.message)   
        end
    elseif  isempty(conn)==0
        name=get(handles.edit131,'String');
        try
        sqlwrite(conn,name,data);
        set(handles.text127,'ForegroundColor',[0, 1, 0]) 
        set(handles.text127,'String','Success')
        catch ME
        set(handles.text127,'ForegroundColor',[1, 0, 0])      
        set(handles.text127,'String',ME.message)   
        end
 
    end
    
function popupm34_Callback(hObject, eventdata, handles)
    try
conn=getappdata(0,'conn');
info=get(handles.popupm34,'String');
eleccion=get(handles.popupm34,'Value');
catalogs=get(handles.popupm29,'String');
catalog=catalogs{get(handles.popupm29,'Value')};
if isempty(conn.Message)==1    
    tablesnames=get(handles.popupm31,'String');
   tablename=tablesnames{get(handles.popupm31,'Value')};
    ini1=table2cell(fetch(conn,char(strcat('SELECT MIN(TIME), LOCATION AS TIME FROM',{' '}, catalog, '.', tablename,{' '},'GROUP BY LOCATION ORDER BY TIME ASC'))));
    ini2=table2cell(fetch(conn,char(strcat('SELECT MAX(TIME), LOCATION AS TIME FROM',{' '}, catalog, '.', tablename,{' '},'GROUP BY LOCATION ORDER BY TIME ASC'))));       
       if eleccion~=2 && isempty(ini1)==0
           try
            rowmin=find(contains(ini1(:,2),info{eleccion,1}));
            rowmax=find(contains(ini2(:,2),info{eleccion,1}));
            initialm=ini1(rowmin,1);
            finalm=ini2(rowmax,1);
            initial=initialm{1};
            final=finalm{1};
           catch
            initialm=table2cell(fetch(conn,char(strcat('SELECT MIN(TIME) FROM',{' '}, catalog, '.',tablename))));
            finalm=table2cell(fetch(conn,char(strcat('SELECT MAX(TIME) FROM',{' '}, catalog, '.',tablename)))); 
            initial=initialm{1};
            final=finalm{1};
           end
       elseif eleccion==2
            initialm=table2cell(fetch(conn,char(strcat('SELECT MIN(TIME) FROM',{' '}, catalog, '.',tablename))));
            finalm=table2cell(fetch(conn,char(strcat('SELECT MAX(TIME) FROM',{' '}, catalog, '.',tablename)))); 
            initial=initialm{1};
            final=finalm{1};
       end    
       set(handles.edit132,'String',datestr(datevec(initial)))
       set(handles.edit133,'String',datestr(datevec(final)))
end
    catch
    end

function popupm34_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu35_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushb174_Callback(hObject, eventdata, handles)
conn=getappdata(0,'conn');
tablain=get(handles.popupm31,'String');
catalogs=get(handles.popupm29,'String');
catalog=catalogs{get(handles.popupm29,'Value')};
textin=strcat('DESCRIBE',{' '},catalog,'.',tablain(get(handles.popupm31,'value')));
try
   out=fetch(conn,textin{1});   
    if isempty(out)==0 && istable(out)==1
       set(handles.text127,'ForegroundColor',[0,1,0])
       set(handles.text127,'String','Success')
       try
       set(handles.uitable115,'ColumnName',out.Properties.VariableNames)
       set(handles.uitable115,'Data',table2cell(out)) 
       catch
       end
    elseif isempty(out)==0 && iscell(out)==1
        set(handles.text127,'ForegroundColor',[0,1,0])
        set(handles.text127,'String','Success')
       try
       set(handles.uitable115,'ColumnName',out.Properties.VariableNames)
       set(handles.uitable115,'Data',table2cell(out)) 
       catch
       end
    end
catch
   warndlg('There is a problem with the query or the connection','Query Problem','replace') 
end

function pushbutton175_Callback(hObject, eventdata, handles)
    try
     tablesnames=get(handles.popupm31,'String');
     tablename=tablesnames{get(handles.popupm31,'Value')};
     catalogs=get(handles.popupm29,'String');
   catalog=catalogs{get(handles.popupm29,'Value')};
     locations=get(handles.popupm34,'String');
     location=locations{get(handles.popupm34,'Value')};
     initial=num2str(datenum(datetime(get(handles.edit132,'String'))));
     final=num2str(datenum(datetime(get(handles.edit133,'String'))));
        conn=getappdata(0,'conn');
        if isempty(conn.Message)==1
            if ischar(initial)==0 || ischar(final)==0 || strcmp(initial,'NaN')==1 || strcmp(final,'NaN')==1         
            info=sqlread(conn,tablename,'Catalog',catalog);
            elseif strcmp(location,'N.A.')==1 
            info=fetch(conn,char(strcat('SELECT * FROM',{' '}, catalog, '.',tablename,{' '},'WHERE TIME BETWEEN',{' '},initial,{' '},'AND',{' '},final)));      
            else
            info=fetch(conn,char(strcat('SELECT * FROM',{' '}, catalog, '.',tablename,{' '},'WHERE TIME >=',{' '},initial,{' '},'AND TIME <=',{' '},final,{' '},'AND',{' '},'LOCATION = ''',location,'''')));      
            end
        set(handles.uitable115,'Data',table2cell(info));
        set(handles.uitable115,'ColumnName',info.Properties.VariableNames);
        else
        set(handles.text127,'String',conn.Message)
        end    
    catch         
    warndlg('Please make sure to spcify the locatio, inital and end dates correctly based on the table information','Request Error','replace')
    end

function pushb177_Callback(hObject, eventdata, handles)
try
fechas=get(handles.listbox32,'String');
fecha=datenum(fechas(get(handles.listbox32,'Value'),:));
geoinfo=getappdata(0,'geoinfo');
try
    geoinfo=cell2mat(geoinfo);
catch
end
base1=str2double(get(handles.edit138,'String'));
base2=str2double(get(handles.edit139,'String'));
base3=str2double(get(handles.edit140,'String'));
axes(handles.axes25)
hold on
info1=find(geoinfo(:,1)==fecha & geoinfo(:,4)>=base1 & geoinfo(:,4)<base2);
info2=find(geoinfo(:,1)==fecha & geoinfo(:,4)>=base2 & geoinfo(:,4)<base3);
info3=find(geoinfo(:,1)==fecha & geoinfo(:,4)>=base3);
plot(geoinfo(info1,3),geoinfo(info1,2),'Marker','o','LineStyle','none','Color','green')
plot(geoinfo(info2,3),geoinfo(info2,2),'Marker','o','LineStyle','none','Color','yellow')
plot(geoinfo(info3,3),geoinfo(info3,2),'Marker','o','LineStyle','none','Color','red')
hold off
catch
   warndlg('there is a probelm with the information set or the date specified','Cannot Process','replace') 
end

function pushb178_Callback(hObject, eventdata, handles)
bd = load('borderdata.mat');
lat = bd.lat(1:246); 
lon = bd.lon(1:246);
axes(handles.axes25)
cla
plot(cell2nancat(lon),cell2nancat(lat),'Parent',handles.axes25,'Color',[0.1 0.1 0.1])
set(handles.axes25,'XLim',[-180 180])
set(handles.axes25,'YLim',[-90 90])

function pushb179_Callback(hObject, eventdata, handles)
tablein=get(handles.uitable115,'Data');
   try 
   row=str2double(get(handles.edit141,'String'));   
   tablein(row,:)=[];
   set(handles.uitable115,'Data',tablein)
   catch       
   end 
   
function pushbutton180_Callback(hObject, eventdata, handles)
tablein=get(handles.uitable115,'Data');
   try 
   col=str2double(get(handles.edit141,'String')); 
   coln=get(handles.uitable115,'ColumnName');
   tablein(:,col)=[];
   coln(col)=[];
   set(handles.uitable115,'Data',tablein)
   set(handles.uitable115,'ColumnName',coln)
   catch       
   end

function edit141_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit145_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit146_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit147_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit148_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function uibuttong15_CreateFcn(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function uipanel1_CreateFcn(hObject, eventdata, handles)

function listbox20_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit16_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox21_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox22_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit138_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit139_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit140_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit132_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit133_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit134_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit135_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit136_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupm32_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit130_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit131_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu33_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupm29_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupm31_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit128_Callback(hObject, eventdata, handles)

function edit128_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit129_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupm30_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Auxiliary buttons, menus, text, etc. thata are used to deploy data but do not perform any task
function edit129_Callback(hObject, eventdata, handles)
function popupm29_Callback(hObject, eventdata, handles)
function popupmenu1_Callback(hObject, eventdata, handles)
function popupm31_Callback(hObject, eventdata, handles)
function popupmenu33_Callback(hObject, eventdata, handles)
function popupm32_Callback(hObject, eventdata, handles)
function edit131_Callback(hObject, eventdata, handles)
function edit130_Callback(hObject, eventdata, handles)
function pushb6_Callback(hObject, eventdata, handles)
function pushbutton139_Callback(hObject, eventdata, handles)
function popupm30_Callback(hObject, eventdata, handles)
function uibuttong15_Callback(hObject, eventdata, handles)
function edit147_Callback(hObject, eventdata, handles)
function edit1_Callback(hObject, eventdata, handles)
function edit148_Callback(hObject, eventdata, handles)
function edit146_Callback(hObject, eventdata, handles)
function pushbutton182_Callback(hObject, eventdata, handles)
function pushbutton183_Callback(hObject, eventdata, handles)
function pushbutton23_Callback(hObject, eventdata, handles)
function pushbutton24_Callback(hObject, eventdata, handles)
function listbox22_Callback(hObject, eventdata, handles)
function listbox21_Callback(hObject, eventdata, handles)
function pushbutton22_Callback(hObject, eventdata, handles)
function edit16_Callback(hObject, eventdata, handles)
function edit15_Callback(hObject, eventdata, handles)
function pushbutton21_Callback(hObject, eventdata, handles)
function listbox20_Callback(hObject, eventdata, handles)
function edit145_Callback(hObject, eventdata, handles)
function edit3_Callback(hObject, eventdata, handles)
function edit141_Callback(hObject, eventdata, handles)
function edit139_Callback(hObject, eventdata, handles)
function edit140_Callback(hObject, eventdata, handles)
function edit138_Callback(hObject, eventdata, handles)
function pushbutton176_Callback(hObject, eventdata, handles)
function edit136_Callback(hObject, eventdata, handles)
function edit135_Callback(hObject, eventdata, handles)
function edit134_Callback(hObject, eventdata, handles)
function edit133_Callback(hObject, eventdata, handles)
function edit132_Callback(hObject, eventdata, handles)
function popupmenu35_Callback(hObject, eventdata, handles)
function edit118_Callback(hObject, eventdata, handles)
function pushbutton151_Callback(hObject, eventdata, handles)
function pushbutton152_Callback(hObject, eventdata, handles)
function pushbutton153_Callback(hObject, eventdata, handles)
function edit117_Callback(hObject, eventdata, handles)
function listbox32_Callback(hObject, eventdata, handles)
function pushbutton41_Callback(hObject, eventdata, handles)
function togglebutton20_Callback(hObject, eventdata, handles)    
function togglebutton21_Callback(hObject, eventdata, handles)   
function togglebutton22_Callback(hObject, eventdata, handles)  
function togglebutton23_Callback(hObject, eventdata, handles)
function togglebutton24_Callback(hObject, eventdata, handles)
function togglebutton25_Callback(hObject, eventdata, handles)
function edit126_Callback(hObject, eventdata, handles)     
    
function listbox32_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton185_Callback(hObject, eventdata, handles)
try
winopen('Manual.docx')
catch
warndlg('Make sure to have Microsoft Words Installed to read the document')   
end
