%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.

function x=dengueODE9(x,nclus,q, Nh, Nv,uv,uh,kv,kh,gama,alpha,pv,ph,tau)
%this example involve the use a span of 1 Day in the ode.... if other span
%is used, it has to be modified the span in he next term. 
%tspan=[0 1]
%y1=ode1(@(t,x) laODE(t,x,nclus,q, Nh, Nv,uv,uh,kv,kh,gama,alpha,pv,ph,tau),tspan,x)
%y1=y1(end,:)
%y2=ode2(@(t,x) laODE(t,x,nclus,q, Nh, Nv,uv,uh,kv,kh,gama,alpha,pv,ph,tau),tspan,x)
%y2=y2(end,:)
tspan=getappdata(0,'TSPAN');
[t,y3]=ode23tb(@(t,x) laODE(t,x,nclus,q,uv,uh,kv,kh,gama,alpha,pv,ph,tau),tspan,x);
x=y3(end,:)';
end
%ODEs(1,[0 500],2,[2319655 527091],[4.36E6 4.36E6*0.1],[1 0;0.3 0.7],[1/30 1/30],[1/(75*365) 1/(75*365)], [1/8 1/8], [1/4 1/4], [1/6 1/6], [0.4517 0.4517], [0.2378 0.2378], [0.2199 0.2199], [0.0262 0.0262], [0.999647810000000*2319655;0.999964781000000*527091;0.999495620000000*4.36E6;0.999979139306116*4.36E6*0.1;0.000143120000000000*2319655;1.43120000000000E-05*527091;0.000286240000000000*4.36E6;1.18386236911653e-05*4.36E6*0.1;0.000109070000000000*2319655;1.09070000000000e-05*527091;0.000218140000000000*4.36E6;9.02207019281301e-06*4.36E6*0.1;0.000100000000000000*2319655;1.00000000000000E-05*527091;0;0], 0)

%dengueODE9([0.999647810000000*2319655 0.999964781000000*527091 0.999495620000000*4.36E6 0.999979139306116*4.36E6*0.1 0.000143120000000000*2319655 1.43120000000000E-05*527091 0.000286240000000000*4.36E6 1.18386236911653e-05*4.36E6*0.1 0.000109070000000000*2319655 1.09070000000000e-05*527091 0.000218140000000000*4.36E6 9.02207019281301e-06*4.36E6*0.1 0.000100000000000000*2319655 1.00000000000000E-05*527091 0 0],2,[1 0;0.3 0.7],[2319655 527091],[4.36E6 4.36E6*0.1],[1/30 1/30],[1/(75*365) 1/(75*365)], [1/8 1/8], [1/4 1/4], [1/6 1/6], [0.4517 0.4517], [0.2378 0.2378], [0.2199 0.2199], [0.0262 0.0262])
     
function vectorode=laODE(t,x,nclus,q,uv,uh,kv,kh,gama,alpha,pv,ph,tau)
% definition of dependent variables
for i=1:nclus
    Sh(i)=x(i);
    Sv(i)=x(nclus+i);
    Ih(i)=x(2*nclus+i);
    Iv(i)=x(3*nclus+i);
    Eh(i)=x(4*nclus+i);
    Ev(i)=x(5*nclus+i);
    Rh(i)=x(6*nclus+i);
    Ch(i)=x(7*nclus+i);
end
%% ecuaciones algebraicas y parametros
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

for i=1:nclus %columna
   for j=1:nclus %fila
       sumavector(i)=P(j,i)*Ih(j)/Nh(j)+sumavector(i); %suma sobre las filas para S y E vector
       sumahost(i)=q(i,j)*Iv(j)*betah(j)/Nv(j)+sumahost(i); %suma sobre las columnas para S y E vector
   end
end
    
for i=1:nclus
dShdt(i)=uh(i)*Nh(i)-Sh(i)*sumahost(i)-uh(i)*Sh(i)+tau(i)*Rh(i);    %ok
dSvdt(i)=uv(i)*Nv(i)-betav(i)*Sv(i)*sumavector(i)-uv(i)*Sv(i);      %ok
dIhdt(i)=kh(i)*Eh(i)-(gama(i)+uh(i))*Ih(i);                         %HOST I Equation (22), (23)
dIvdt(i)=kv(i)*Ev(i)-uv(i)*Iv(i);                                   %VECTOR I Equation (20), (21)
dEhdt(i)=Sh(i)*sumahost(i)-(uh(i)+kh(i))*Eh(i);                     %HOST E Equation (18), (19)
dEvdt(i)=betav(i)*Sv(i)*sumavector(i)-(uv(i)+kv(i))*Ev(i);          %VECTOR E Equation (16), (17)
dRhdt(i)=gama(i)*Ih(i)-(uh(i)+tau(i))*Rh(i);                        %HOST R Equation (24), (25)
dChdt(i)=kh(i)*Eh(i); 
end

vectorode=[dShdt dSvdt dIhdt dIvdt dEhdt dEvdt dRhdt dChdt]';
end
