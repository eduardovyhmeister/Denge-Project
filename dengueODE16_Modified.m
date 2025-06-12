%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.


function ObjFun =dengueODE16_Modified(x, xdata, nclus, ~, Temperature, ~, fixedparam, parameters,selectorvar,tamanos,ydata,nenv)
timerange=xdata;
var=zeros(1,numel(parameters)-nclus*nclus-12*nclus);
var2=zeros(1,nclus*nclus);
var3=zeros(1,nclus*12);
count=1;
  for i=1:tamanos(1)
     if fixedparam(i)==1 %si esta fijo, obtengo el parametro de los entregado por el sistema
        var(i)=parameters(1,i);
     else
        var(i)=x(count);
        count=count+1;
     end
  end      
  
 for i=1:tamanos(2)
    if fixedparam(tamanos(1)+i)==1
        var2(i)=parameters(1,tamanos(1)+i);
    else
        var2(i)=x(count);
        count=count+1;
    end
 end
 
  for i=1:tamanos(3)
      if fixedparam(tamanos(1)+tamanos(2)+i)==1
        var3(i)=parameters(1,tamanos(1)+tamanos(2)+i);     
      else
          var3(i)=x(count);
          count=count+1;
      end
  end
  var2=reshape(var2,sqrt(tamanos(2)),sqrt(tamanos(2)));    
  
        Nh=var(1:nclus);  %Nv es predecido por el modelo
        uh=var(nclus+1:2*nclus); %uv es predecido por el modelo
        kv=var(2*nclus+1:3*nclus);
        kh=var(3*nclus+1:4*nclus);
        gama=var(4*nclus+1:5*nclus);
        alpha=var(5*nclus+1:6*nclus);
        pv=var(6*nclus+1:7*nclus);
        ph=var(7*nclus+1:8*nclus);
        tau=var(8*nclus+1:9*nclus);
        k0=var(9*nclus+1:10*nclus);
        ep=var(10*nclus+1:11*nclus);
        Tp=var(11*nclus+1:12*nclus);
        Tl=var(12*nclus+1:13*nclus);
        Ti=var(13*nclus+1:14*nclus);
        Te=var(14*nclus+1:15*nclus);
        Pre01=var(15*nclus+1:16*nclus);
        Pre02=var(16*nclus+1:17*nclus);
        Pre03=var(17*nclus+1:18*nclus);
        mu1=[];
        mu2=[];
        mu3=[];
        mu4=[];
        mu5=[];
        mu6=[];
        for i=1:nenv
        mu1=[mu1; var(18*nclus+1+(i-1)*nclus:19*nclus+(i-1)*nclus)];
        mu2=[mu2; var(18*nclus+1+nclus*nenv+(i-1)*nclus:19*nclus+(i-1)*nclus+nclus*nenv)];
        mu3=[mu3; var(18*nclus+1+2*nclus*nenv+(i-1)*nclus:19*nclus+(i-1)*nclus+2*nclus*nenv)];
        mu4=[mu4; var(18*nclus+1+3*nclus*nenv+(i-1)*nclus:19*nclus+(i-1)*nclus+3*nclus*nenv)];
        mu5=[mu5; var(18*nclus+1+4*nclus*nenv+(i-1)*nclus:19*nclus+(i-1)*nclus+4*nclus*nenv)];
        mu6=[mu6; var(18*nclus+1+5*nclus*nenv+(i-1)*nclus:19*nclus+(i-1)*nclus+5*nclus*nenv)];
        end

        q=var2';
        initvalues=var3;
        %options=odeset('NonNegative',1);
        
        %[tt,Results]=ode45(@(t,x) dengueODE4(t,x,timerange, nclus, Temperature, q, Nh, uh, kv, kh, gama, alpha, pv, ph, tau, mu1, mu2, mu3, mu4, mu5,mu6,mu7, mu8, mu9, k0, ep, Tp, Tl, Ti, Te), timerange, initvalues,options);
        [tt,Results]=ode23tb(@(t,x) dengueODE4_Modified(t,x,timerange, nclus, Temperature, q, Nh, uh, kv, kh, gama, alpha, pv, ph, tau, k0, ep, Tp, Tl, Ti, Te,Pre01,Pre02,Pre03,mu1,mu2,mu3,mu4,mu5,mu6,nenv), timerange, initvalues);

%if selectorvar==1
%    ObjFun=Results(:,2*nclus+1:3*nclus);
%elseif selectorvar==2
%    ObjFun=Results(:,7*nclus+1:8*nclus);
%elseif selectorvar==3
%    ObjFun=Results(:,nclus+1:2*nclus);
%end

if selectorvar==2
Yestimado=Results(:,7*nclus+1:8*nclus);
elseif selectorvar==1
Yestimado=Results(:,2*nclus+1:3*nclus);
elseif selectorvar==3
Yestimado=Results(:,nclus+1:2*nclus);
end
ObjFun=sum(sum(((ydata-Yestimado).^2)/numel(ydata)));
setappdata(0,'residual',((ydata-Yestimado).^2)/numel(ydata))
%Valores=getappdata(0,'Valores')
%Valores=[Valores; ObjFun]
%setappdata(0,'Valores',x)
end