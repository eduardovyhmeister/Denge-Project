function [A]=InfoCall(~)
close all
clc
clear all
global param
%% first we call a few parameters from the user
question1='0'; FileText=''; FileText2='';
while question1=='0'
    question1=input('What do you want to do?: \n (1) Create a new database and predict parameters \n (2) incorporate new data and forecast \n (3) forecast \n','s') ; 
    if question1=='1'|| question1=='2'|| question1=='3'
        disp(strcat('you have chosent the option: ', question1))
        pause(2)
    else
        disp('Not a valid input, please try again')
        question1='0';
    end
end

if question1=='1'
    ClusterNum=0; 
    while ClusterNum==0 || rem(ClusterNum,1)~=0
        try
            ClusterNum=str2num(input('How many clusters (regions) would you like to handle?: ','s'));
            if ClusterNum==0 || rem(ClusterNum,1)~=0 
                disp('Not a valid value, it must be an integer or a please repeate again')
            end
        catch ME
            disp('Can not be a text please try again´')
            ClusterNum=0;
        end 
    end

end
file1=uigetfile

if question1=='1' || question1=='2'
    while FileText=='' && FileText2==''
        
        FileText=input('What is the name of the database will be used for epidemiological information (must be an xlsx or csv file extension)? \n (This database should include timestamps)): ','s');
        FileText2=input('What is the name of the database will be usead for weather information (must be an xlsx or csv file extension)? \n (This database should include timestamps): ', 's'); 
                
        %EpiData=xlsread(
        
        if FileText=='' || FileText2==''
            disp('Not a valid input, please try again')
        end
    end
end




