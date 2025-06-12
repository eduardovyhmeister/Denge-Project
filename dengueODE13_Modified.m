%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.


function x =dengueODE13_Modified(x, nclus, Temperature, k0, ep, Tp,Tl,Ti,Te,Pre01,Pre02,Pre03, mu1, mu2, mu3, mu4, mu5,mu6,pNoise,nenv)
tspan=getappdata(0,'TSPAN');
for i=1:size(x,2)
input=x(:,i);
[t,y3]=ode23tb(@(t,input) laODE(t,input,nclus,Temperature,k0, ep, Tp,Tl,Ti,Te,Pre01,Pre02,Pre03, mu1, mu2, mu3, mu4, mu5,mu6,nenv),tspan,input);
output(:,i)=y3(end,:)'+y3(end,:)'.*(pNoise*randn(size(y3(end,:)')));
end
x=output;
end
% definition of dependent variables
function vectorode=laODE(tt, x, nclus, temp, k0, ep, Tp,Tl,Ti,Te,Pre01,Pre02,Pre03, mu1, mu2, mu3, mu4, mu5,mu6,nenv)

%for j=1:nclus
%Temperature(j)=interp1(temp(:,1),temp(:,j+1),tt);
%end

envVar=zeros(nenv,nclus);
for i=1:nclus
        for j=1:nenv
            envVar(j,i)=interp1(temp(:,1),temp(:,(i-1)*nenv+j+1),tt);
        end
end
% definition of dependent variables
E=zeros(nclus,1); L=E; P=E; Svi=E; Sva=E; 
deltaE=E; deltaL=E; deltaP=E; deltaAg=E; betaAg=E;





for i=1:nclus
    E(i)=x(i);   %eggs
    L(i)=x(nclus+i); %larva
    P(i)=x(2*nclus+i); %pupa
    Svi(i)=x(3*nclus+i); %Immature adults
    Sva(i)=x(4*nclus+i); %Adults Gestating and reproducing
end
%% ecuaciones algebraicas y parametros
% In this model only 5 stages will be considered ... so is something
% between the works of Erickson and the work of Beck - hohnson. The final
% important density for 

%Parameters
%Te=1;  % EGG HATCH DEVELOPMENT TIME
%Tl=1;  % Larva development time
%k0=2E-4; % Carrying capacity term that represent reduction of larvae by competition factors with other mosquitoes 
%Tp=1; %Pupae development time
%Ti=1; %Inmature development time
%ep=30; %eggs per oviposition
%Equations
%for i=1:nclus
%deltaE(i)=mu6(i)*exp(((Temperature(i)-mu4(i))/mu5(i))^2); %mortality rate in function of temperature
%deltaL(i)=mu6(i)*exp(((Temperature(i)-mu4(i))/mu5(i))^2); %mortality rate in funciton of temperature
%deltaP(i)=mu6(i)*exp(((Temperature(i)-mu4(i))/mu5(i))^2); %mortality rate in function of temperature
%deltaAg(i)=mu3(i)*exp(((Temperature(i)-mu1(i))/mu2(i))^4); %mortality rate ..... .this is left to the order 4 since as the temperature get high the mortalitiy should overlap the growing rate
%betaAg(i)=mu9(i)*exp(((Temperature(i)-mu7(i))/mu8(i))^2);  %reproduction rate ..... this order should be lower than the previouys once in order to allow that as the temperature get higher the dying rate overlaps this one
%end

for i=1:nclus
deltaE(i)=Pre02(i); %mortality rate in function of temperature
deltaL(i)=Pre02(i); %mortality rate in funciton of temperature
deltaP(i)=Pre02(i); %mortality rate in function of temperature
deltaAg(i)=Pre01(i); %mortality rate ..... .this is left to the order 4 since as the temperature get high the mortalitiy should overlap the growing rate
betaAg(i)=Pre03(i);  %reproduction rate ..... this order should be lower than the previouys once in order to allow that as the temperature get higher the dying rate overlaps this one
    for j=1:nenv
        deltaE(i)=deltaE(i)*exp(((envVar(j,i)-mu1(j,i))/mu2(j,i))^2); 
        deltaL(i)=deltaL(i)*exp(((envVar(j,i)-mu1(j,i))/mu2(j,i))^2);
        deltaP(i)=deltaP(i)*exp(((envVar(j,i)-mu1(j,i))/mu2(j,i))^2);
        deltaAg(i)=deltaAg(i)*exp(((envVar(j,i)-mu3(j,i))/mu4(j,i))^4);
        betaAg(i)=betaAg(i)*exp(-((envVar(j,i)-mu5(i))/mu6(i))^2);
    end
end





%ODES
for i=1:nclus
dEdt(i)=ep(i)*betaAg(i)*Sva(i)-deltaE(i)*E(i)-Te*E(i);     %Egg reproduction stage incomming from reproduction stage (numer of eggs per ofiposition*temperature dependent kinetic parameter*the concentration of females - mortality temperature dependent - development to next stage.
dLdt(i)=Te(i)*E(i)-deltaL(i)*L(i)-Tl(i)*L(i)-k0(i)*L(i)^2;     %Larvae reproduction stage incoming from egg - mortality T dependent - next stage - competition within mosquitoes species.
dPdt(i)=Tl(i)*L(i)-deltaP(i)*P(i)-Tp(i)*P(i);           %Pupae reproduction stage incoming from larvae - mortality T dependent - next stage
dSvidt(i)=Tp(i)*P(i)-deltaAg(i)*Svi(i)-Ti(i)*Svi(i);               %Vector population incoming from pupae - mortality T dependent - next stage adult mosquitoe
dSvadt(i)=Ti(i)*Svi(i)-deltaAg(i)*Sva(i);                                     %VECTOR I Equation (20), (21)
end
vectorode=[dEdt dLdt dPdt dSvidt dSvadt]';
end
