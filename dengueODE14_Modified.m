%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.

function x=dengueODE14_Modified(x,nclus,Q,Temp,Nh,uh,kv,kh,gama,alpha,pv,ph,tau, k0, ep, Tp, Tl, Ti, Te,Pre01,Pre02,Pre03, mu1, mu2, mu3, mu4, mu5,mu6,pNoise,nenv)
% definition of dependent variables
tspan=getappdata(0,'TSPAN');
for i=1:size(x,2)
input=x(:,i);
[t,y3]=ode23tb(@(t,input) laODE(t,input,nclus,Temp,Nh,Q,uh,kv,kh,gama,alpha,pv,ph,tau, k0, ep, Tp, Tl, Ti, Te,Pre01,Pre02,Pre03, mu1, mu2, mu3, mu4, mu5,mu6,nenv),tspan,input);
output(:,i)=y3(end,:)'+y3(end,:)'.*(pNoise*randn(size(y3(end,:)')));
end
x=output;
end

%Nh was eliminated from the data transfer..... 
function vectorode=laODE(tt,x,nclus,Temp,Q,uh,kv,kh,gama,alpha,pv,ph,tau, k0, ep, Tp, Tl, Ti, Te,Pre01,Pre02,Pre03, mu1, mu2, mu3, mu4, mu5,mu6,nenv)
%for j=1:nclus
%Temperature(j)=interp1(Temp(:,1),Temp(:,j+1),tt);
%end

envVar=zeros(nenv,nclus);
for i=1:nclus
        for j=1:nenv
            envVar(j,i)=interp1(Temp(:,1),Temp(:,(i-1)*nenv+j+1),tt);
        end
end





for i=1:nclus
    Sh(i)=x(i); % Host susceptible
    Sva(i)=x(nclus+i); %vector susceptible adults
    Ih(i)=x(2*nclus+i); %Infected host
    Iv(i)=x(3*nclus+i); %Infected vector
    Eh(i)=x(4*nclus+i); %Expectant host
    Ev(i)=x(5*nclus+i);  %Expectant vector
    Rh(i)=x(6*nclus+i);   %Recovered host
    Ch(i)=x(7*nclus+i); %Accumulated host
    E(i)=x(8*nclus+i); %eggs vector 
    L(i)=x(9*nclus+i); %larva vector
    P(i)=x(10*nclus+i); %pupa vector
    Svi(i)=x(11*nclus+i); %Immature adults    
end
    
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
        div(i)=div(i)+Q(j,i)*Nh(j);
    end
end

for i=1:nclus  %i filas
    for j=1:nclus %j columnas
        P(i,j)=Q(i,j)*Nh(i)/div(j); %Equations (5), (6), (7), (8)
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
       sumahost(i)=Q(i,j)*Iv(j)*betah(j)/Nv(j)+sumahost(i); %suma sobre las columnas para S y E vector
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
dEdt(i)=ep(i)*betaAg(i)*(Sva(i)+Ev(i)+Iv(i))-deltaE(i)*E(i)-Te(i)*E(i);                     % ODE for Eggs
end
vectorode=[dShdt dSvadt dIhdt dIvdt dEhdt dEvdt dRhdt dChdt dEdt dLdt dPdt dSvidt]';
end
