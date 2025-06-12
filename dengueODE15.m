%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.

function ObjFun =dengueODE15(x, xdata, nclus, q, initvalues, fixedparam, parameters,NumParamProblema,tamanos,selectorvariables,ydata)
timerange=xdata;
%var=zeros(NumParamProblema,nclus);
var=zeros(1,NumParamProblema*nclus);
var2=zeros(1,nclus*nclus);
var3=zeros(1,nclus*8);
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
  
        Nh=var(1:nclus);
        Nv=var(nclus+1:2*nclus);
        uv=var(2*nclus+1:3*nclus);
        uh=var(3*nclus+1:4*nclus);
        kv=var(4*nclus+1:5*nclus);
        kh=var(5*nclus+1:6*nclus);
        gama=var(6*nclus+1:7*nclus);
        alpha=var(7*nclus+1:8*nclus);
        pv=var(8*nclus+1:9*nclus);
        ph=var(9*nclus+1:10*nclus);
        tau=var(10*nclus+1:11*nclus);   
        options=odeset('NonNegative',1,'RelTol',1e-3,'AbsTol',1e-6);
        q=var2';
        initvalues=var3;

[tt,f]=ode23tb(@(t,x) dengueODE1(t,x,nclus,q, Nh, Nv, uv, uh, kv, kh, gama, alpha, pv, ph, tau), timerange, initvalues,options);

if selectorvariables==2
Yestimado=f(:,7*nclus+1:8*nclus);
elseif selectorvariables==1
Yestimado=f(:,2*nclus+1:3*nclus);
end
ObjFun=100*sum(sum(((ydata-Yestimado).^2)/numel(ydata)));
setappdata(0,'residual',((ydata-Yestimado).^2)/numel(ydata))
end