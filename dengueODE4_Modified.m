%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.


function vectorode =dengueODE4_Modified(tt,vectorvariablesdep,timestamp, nclus, environmental, q, Nh,uh,kv,kh,gama,alpha,pv,ph,tau, k0, ep, Tp, Tl, Ti, Te,pre01,pre02,pre03,mu1,mu2,mu3,mu4,mu5,mu6,nenv)
% definition of dependent variables
%this represent ho many environmntal variables are analyzed.... we will try with temperaturefirst only

envVar=zeros(nenv,nclus);
for i=1:nclus
        for j=1:nenv
            envVar(j,i)=interp1(environmental(:,1),environmental(:,(i-1)*nenv+j+1),tt);
        end
end

% definition of dependent variables
E=zeros(nclus,1); L=E; P=E; Svi=E; Sva=E; Sh=E; Ih=E; Iv=E; Eh=E; Ev=E; Rh=E; Ch=E;
deltaE=E; deltaL=E; deltaP=E; deltaAg=E; betaAg=E;

for i=1:nclus
    Sh(i)=vectorvariablesdep(i); % Host susceptible
    Sva(i)=vectorvariablesdep(nclus+i); %vector susceptible adults
    Ih(i)=vectorvariablesdep(2*nclus+i); %Infected host
    Iv(i)=vectorvariablesdep(3*nclus+i); %Infected vector
    Eh(i)=vectorvariablesdep(4*nclus+i); %Expectant host
    Ev(i)=vectorvariablesdep(5*nclus+i);  %Expectant vector
    Rh(i)=vectorvariablesdep(6*nclus+i);   %Recovered host
    Ch(i)=vectorvariablesdep(7*nclus+i); %Accumulated host
    E(i)=vectorvariablesdep(8*nclus+i); %eggs vector 
    L(i)=vectorvariablesdep(9*nclus+i); %larva vector
    P(i)=vectorvariablesdep(10*nclus+i); %pupa vector
    Svi(i)=vectorvariablesdep(11*nclus+i); %Immature adults    
end
%% ecuaciones algebraicas y parametros
%some parametes are:
%uv = per capita vector birth/death rate (SEIR-LSEI separate them)
%uh = per capita human birth/death rate 1/(75*365) ... (days-1) *WHO(2014)
%kv = vector conversion rate from latent to infections (days -1) *WHO(2009)
%kh = vector conversion rate from latent to infections (days -1) *WHO(2009)
%gama = Human recovery rate from infeciton (days -1) *WHO(2009)
%alpha = # of blood meals taken by one female mosquito in average / day
    %alsoknown as mosquito biting rate and is connected trhoug betav y beta
    %h by the following equations ... betav=alpha*pv and
    %betah=alpha*ph*Nv/Nh. 
%tau = rate of recirculation to the dengue process given byan assumption
    %that cross immunity is completely ignored and all infected human hosts
    %become suscpetible immediately ager recoverly. and using the tau,
    %multi-strain modeling is avoided !!!!!!!!!!!!

%Parameters
%Te=1;  % EGG HATCH DEVELOPMENT TIME
%Tl=1;  % Larva development time
%k0=2E-4; % Carrying capacity term that represent reduction of larvae by competition factors with other mosquitoes 
%Tp=1; %Pupae development time
%Ti=1; %Inmature development time
%ep=30; %eggs per oviposition
    
%Equations
div=zeros(nclus,1);
sumavector=zeros(nclus,1);
sumahost=zeros(nclus,1);

for i=1:nclus
Nh(i)=Sh(i)+Ih(i)+Rh(i)+Eh(i);  %Equations (1), (2)
Nv(i)=Sva(i)+Iv(i)+Ev(i);        %Equations (3), (4)
end

for i=1:nclus %columnas
    for j=1:nclus %filas
        div(i)=div(i)+q(j,i)*Nh(j);
    end
end

for i=1:nclus  %i filas
    for j=1:nclus %j columnas
        P(i,j)=q(i,j)*Nh(i)/div(j); %Equations (5), (6), (7), (8)
    end
end

betav=zeros(nclus,1);            %Equation (9)
betah=zeros(nclus,1);

for i=1:nclus
betav(i)=alpha(i)*pv(i);    
betah(i)=alpha(i)*ph(i)*Nv(i)/div(i);    %Equation (10), (11)
end

%ahora que tengo los P(i,j) sumo los componentes totales por participacion
%sumavector=zeros(1,nclus);
%sumahost=zeros(1,nclus);
%suma vertical

for i=1:nclus %columna
   for j=1:nclus %fila
       sumavector(i)=P(j,i)*Ih(j)/Nh(j)+sumavector(i); %suma sobre las filas para S y E vector
       sumahost(i)=q(i,j)*Iv(j)*betah(j)/Nv(j)+sumahost(i); %suma sobre las columnas para S y E vector
   end
end

%equations for vector considerations 

%for i=1:nclus
%deltaE(i)=mu6(i)*exp(((Temperature(i)-mu4(i))/mu5(i))^2);    %mortality rate in function of temperature
%deltaL(i)=mu6(i)*exp(((Temperature(i)-mu4(i))/mu5(i))^2);    %mortality rate in funciton of temperature
%deltaP(i)=mu6(i)*exp(((Temperature(i)-mu4(i))/mu5(i))^2);    %mortality rate in function of temperature
%deltaAg(i)=mu3(i)*exp(((Temperature(i)-mu1(i))/mu2(i))^2);   %mortality rate ..... .this is left to the order 2 since as the temperature get high the mortalitiy should overlap the growing rate
%betaAg(i)=mu9(i)*exp(-((Temperature(i)-mu7(i))/mu8(i))^2);       %reproduction rate ..... this order should be lower than the previouys once in order to allow that as the temperature get higher the dying rate overlaps this one
%end



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



for i=1:nclus
dSvadt(i)=Ti(i)*Svi(i)-betav(i)*Sva(i)*sumavector(i)-deltaAg(i)*Sva(i);       % ODE for adults vector ok
dShdt(i)=uh(i)*Nh(i)-Sh(i)*sumahost(i)-uh(i)*Sh(i)+tau(i)*Rh(i);                 % ODE for host
dEvdt(i)=betav(i)*Sva(i)*sumavector(i)-(deltaAg(i)+kv(i))*Ev(i);           % Expectant vector
dEhdt(i)=Sh(i)*sumahost(i)-(uh(i)+kh(i))*Eh(i);                            % Host Expectant
dIvdt(i)=kv(i)*Ev(i)-deltaAg(i)*Iv(i);                                  % Infected vector
dIhdt(i)=kh(i)*Eh(i)-(gama(i)+uh(i))*Ih(i);                                % Infected host 
dRhdt(i)=gama(i)*Ih(i)-(uh(i)+tau(i))*Rh(i);                                  % Recovered host 
dChdt(i)=kh(i)*Eh(i);                                                   % Accumulated infected
dSvidt(i)=Tp(i)*P(i)-deltaAg(i)*Svi(i)-Ti(i)*Svi(i);                          % ODE for inmature vector
dPdt(i)=Tl(i)*L(i)-deltaP(i)*P(i)-Tp(i)*P(i);                                 % ODE for pupae
dLdt(i)=Te(i)*E(i)-deltaL(i)*L(i)-Tl(i)*L(i)-k0(i)*L(i)^2;                       % ODE for Larvae
dEdt(i)=ep(i)*betaAg(i)*(Sva(i)+Iv(i)+Ev(i))-deltaE(i)*E(i)-Te(i)*E(i);                     % ODE for Eggs
end

vectorode=[dShdt dSvadt dIhdt dIvdt dEhdt dEvdt dRhdt dChdt dEdt dLdt dPdt dSvidt]';
end
