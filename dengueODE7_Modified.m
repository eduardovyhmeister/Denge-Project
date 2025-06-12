%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.


function ObjFun =dengueODE7_Modified(x, xdata, nclus, Temperature,~, fixedparam, parameters,selectorvar,tamanos,ydata,nenv)
timerange=xdata;
var=zeros(1,numel(parameters)-5*nclus);
var3=zeros(1,nclus*5);

count=1;
  for i=1:tamanos(1)
     if fixedparam(i)==1 %si esta fijo, obtengo el parametro de los entregado por el sistema
        var(i)=parameters(1,i);
     else
        var(i)=x(1,count);
        count=count+1;
     end
  end      
  
  for i=1:tamanos(2)
      if fixedparam(tamanos(1)+i)==1
        var3(i)=parameters(1,tamanos(1)+i);     
      else
          var3(i)=x(count);
          count=count+1;
      end
  end

        
        k0=var(1:nclus);
        ep=var(nclus+1:2*nclus);
        Tp=var(2*nclus+1:3*nclus);
        Tl=var(3*nclus+1:4*nclus);
        Ti=var(4*nclus+1:5*nclus);
        Te=var(5*nclus+1:6*nclus);
        Pre01=var(6*nclus+1:7*nclus);
        Pre02=var(7*nclus+1:8*nclus);
        Pre03=var(8*nclus+1:9*nclus);
        mu1=[];
        mu2=[];
        mu3=[];
        mu4=[];
        mu5=[];
        mu6=[];
        for i=1:nenv
        mu1=[mu1; var(8*nclus+1+i*nclus:9*nclus+i*nclus)];
        mu2=[mu2; var(8*nclus+1+nclus*nenv+i*nclus:9*nclus+i*nclus+nclus*nenv)];
        mu3=[mu3; var(8*nclus+1+2*nclus*nenv+i*nclus:9*nclus+i*nclus+2*nclus*nenv)];
        mu4=[mu4; var(8*nclus+1+3*nclus*nenv+i*nclus:9*nclus+i*nclus+3*nclus*nenv)];
        mu5=[mu5; var(8*nclus+1+4*nclus*nenv+i*nclus:9*nclus+i*nclus+4*nclus*nenv)];
        mu6=[mu6; var(8*nclus+1+5*nclus*nenv+i*nclus:9*nclus+i*nclus+5*nclus*nenv)];
        end
        initvalues=var3;
        options=odeset('NonNegative',1);
        
%
%        
        [tt,results]=ode23tb(@(t,x) dengueODE3_Modified(t,x,timerange, nclus, Temperature,k0, ep, Tp, Tl, Ti, Te,Pre01,Pre02,Pre03,mu1,mu2,mu3,mu4,mu5,mu6,nenv), timerange, initvalues,options);
%
if selectorvar==1
    Yestimado=results(:,1:nclus);
elseif selectorvar==2
    Yestimado=results(:,nclus+1:2*nclus);
elseif selectorvar==3
    Yestimado=results(:,2*nclus+1:3*nclus);
elseif selectorvar==4
    Yestimado=results(:,4*nclus+1:5*nclus);
end

ObjFun=sum(sum(((ydata-Yestimado).^2)/numel(ydata)));
setappdata(0,'residual',((ydata-Yestimado).^2)/numel(ydata))


end