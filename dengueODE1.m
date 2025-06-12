%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.


function vectorode=dengueODE1(tt, vectorvariablesdep,nclus,q, Nh, Nv,uv,uh,kv,kh,gama,alpha,pv,ph,tau)
% definition of dependent variables
for i=1:nclus
    Sh(i)=vectorvariablesdep(i);
    Sv(i)=vectorvariablesdep(nclus+i);
    Ih(i)=vectorvariablesdep(2*nclus+i);
    Iv(i)=vectorvariablesdep(3*nclus+i);
    Eh(i)=vectorvariablesdep(4*nclus+i);
    Ev(i)=vectorvariablesdep(5*nclus+i);
    Rh(i)=vectorvariablesdep(6*nclus+i);
    Ch(i)=vectorvariablesdep(7*nclus+i);
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

%Equations
div=zeros(nclus,1);
sumavector=zeros(nclus,1);
sumahost=zeros(nclus,1);

for i=1:nclus
Nh(i)=Sh(i)+Ih(i)+Rh(i)+Eh(i);  %Equations (1), (2)
Nv(i)=Sv(i)+Iv(i)+Ev(i);        %Equations (3), (4)
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
    
    betav=zeros(nclus,1);
    betah=zeros(nclus,1);

for i=1:nclus
betav(i)=alpha(i)*pv(i);                 %Equation (9)
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
    
for i=1:nclus
    
%dSvdt(i)=uv(i)-betav*Sv(i)*sumavector(i)-uv(i)*Sv(i));             %VECTOR S Equation (12), (13)
%dShdt(i)=uh-Sh(i)*sumahost(i)-uh*Sh(i)+tau*Rh(i);                  %HhOST S Equation (14), (15)
%dEvdt(i)=betav*Sv(i)*sumavector(i)-(uv(i)+kv(i))*Ev(i);            %VECTOR E Equation (16), (17)
%dEhdt(i)=Sh(i)*sumahost(i)-(uh+kh(i))*Eh(i);                       %HOST E Equation (18), (19)
%dIvdt(i)=kv(i)*Ev(i)-uv(i)*Iv(i);                                  %VECTOR I Equation (20), (21)
%dIhdt(i)=kh(i)*Eh(i)-(gama(i)+uh)*Ih(i);                           %HOST I Equation (22), (23)
%dRhdt(i)=gama(i)*Ih(i)-(uh+tau)*Rh(i);                             %HOST R Equation (24), (25)
%dChdt(i)=kh(i)*Eh(i);                                              %Cumulative (26), (27)

dSvdt(i)=uv(i)*Nv(i)-betav(i)*Sv(i)*sumavector(i)-uv(i)*Sv(i);      %ok
dShdt(i)=uh(i)*Nh(i)-Sh(i)*sumahost(i)-uh(i)*Sh(i)+tau(i)*Rh(i);    %ok
dEvdt(i)=betav(i)*Sv(i)*sumavector(i)-(uv(i)+kv(i))*Ev(i);          %VECTOR E Equation (16), (17)
dEhdt(i)=Sh(i)*sumahost(i)-(uh(i)+kh(i))*Eh(i);                     %HOST E Equation (18), (19)
dIvdt(i)=kv(i)*Ev(i)-uv(i)*Iv(i);                                   %VECTOR I Equation (20), (21)
dIhdt(i)=kh(i)*Eh(i)-(gama(i)+uh(i))*Ih(i);                         %HOST I Equation (22), (23)
dRhdt(i)=gama(i)*Ih(i)-(uh(i)+tau(i))*Rh(i);                        %HOST R Equation (24), (25)
dChdt(i)=kh(i)*Eh(i);    

end
vectorode=[dShdt dSvdt dIhdt dIvdt dEhdt dEvdt dRhdt dChdt]';
end
