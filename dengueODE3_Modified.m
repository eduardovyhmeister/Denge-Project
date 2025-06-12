%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.

function vectorode =dengueODE3_Modified(tt, vectorvariablesdep, timestamp, nclus, environmental, k0, ep, Tp,Tl,Ti,Te,pre01,pre02,pre03,mu1,mu2,mu3,mu4,mu5,mu6,nenv)
%nenv=1; %%this represent ho many environmntal variables are analyzed.... we will try with temperaturefirst only
envVar=zeros(nenv,nclus);
for i=1:nclus
        for j=1:nenv
            envVar(j,i)=interp1(environmental(:,1),environmental(:,(i-1)*nenv+j+1),tt);
        end
end
% definition of dependent variables
E=zeros(nclus,1); L=E; P=E; Svi=E; Sva=E; 
deltaE=E; deltaL=E; deltaP=E; deltaAg=E; betaAg=E;



for i=1:nclus
    E(i)=vectorvariablesdep(i);   %eggs
    L(i)=vectorvariablesdep(nclus+i); %larva
    P(i)=vectorvariablesdep(2*nclus+i); %pupa
    Svi(i)=vectorvariablesdep(3*nclus+i); %Immature adults
    Sva(i)=vectorvariablesdep(4*nclus+i); %Adults Gestating and reproducing
end


%% ecuaciones algebraicas y parametros
% In this model only 5 stages will be considered ... so is something
% between the works of Erickson and the work of Beck - hohnson. The final
% important density for 
for i=1:nclus
deltaE(i)=pre02(i); %mortality rate in function of temperature
deltaL(i)=pre02(i); %mortality rate in funciton of temperature
deltaP(i)=pre02(i); %mortality rate in function of temperature
deltaAg(i)=pre01(i); %mortality rate ..... .this is left to the order 4 since as the temperature get high the mortalitiy should overlap the growing rate
betaAg(i)=pre03(i);  %reproduction rate ..... this order should be lower than the previouys once in order to allow that as the temperature get higher the dying rate overlaps this one
    for j=1:nenv
        deltaE(i)=deltaE(i)*exp(((envVar(j,i)-mu1(j,i))/mu2(j,i))^2); 
        deltaL(i)=deltaL(i)*exp(((envVar(j,i)-mu1(j,i))/mu2(j,i))^2);
        deltaP(i)=deltaP(i)*exp(((envVar(j,i)-mu1(j,i))/mu2(j,i))^2);
        deltaAg(i)=deltaAg(i)*exp(((envVar(j,i)-mu3(j,i))/mu4(j,i))^4);
        betaAg(i)=betaAg(i)*exp(-((envVar(j,i)-mu5(j,i))/mu6(j,i))^2);
    end
end

%for i=1:nclus
%deltaE(i)=pre02(i)*exp(((envVar(i)-mu4(i))/mu5(i))^2); %mortality rate in function of temperature
%deltaL(i)=pre02(i)*exp(((envVar(i)-mu4(i))/mu5(i))^2); %mortality rate in funciton of temperature
%deltaP(i)=pre02(i)*exp(((envVar(i)-mu4(i))/mu5(i))^2); %mortality rate in function of temperature
%deltaAg(i)=pre01(i)*exp(((envVar(i)-mu1(i))/mu2(i))^4); %mortality rate ..... .this is left to the order 4 since as the temperature get high the mortalitiy should overlap the growing rate
%betaAg(i)=pre03(i)*exp(-((envVar(i)-mu7(i))/mu8(i))^2);  %reproduction rate ..... this order should be lower than the previouys once in order to allow that as the temperature get higher the dying rate overlaps this one
%end

%ODES
for i=1:nclus
dEdt(i)=ep(i)*betaAg(i)*Sva(i)-deltaE(i)*E(i)-Te(i)*E(i);     %Egg reproduction stage incomming from reproduction stage (numer of eggs per ofiposition*temperature dependent kinetic parameter*the concentration of females - mortality temperature dependent - development to next stage.
dLdt(i)=Te(i)*E(i)-deltaL(i)*L(i)-Tl(i)*L(i)-k0(i)*L(i)^2;    %Larvae reproduction stage incoming from egg - mortality T dependent - next stage - competition within mosquitoes species.
dPdt(i)=Tl(i)*L(i)-deltaP(i)*P(i)-Tp(i)*P(i);                 %Pupae reproduction stage incoming from larvae - mortality T dependent - next stage
dSvidt(i)=Tp(i)*P(i)-deltaAg(i)*Svi(i)-Ti(i)*Svi(i);          %Vector population incoming from pupae - mortality T dependent - next stage adult mosquitoe
dSvadt(i)=Ti(i)*Svi(i)-deltaAg(i)*Sva(i);                     %VECTOR I Equation (20), (21)
end
vectorode=[dEdt dLdt dPdt dSvidt dSvadt]';
end
