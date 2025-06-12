%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.

%% The manuscripts that are going to be used as base for the cluster models is: Barrios, E., Lee, Sunmi, Vasilieva, Olga, Assessing the Effects of Daily Commuting in Two-Patch Dengue Dynamics: A Case Study of Cali, Colombia. Journal of theoretical biology 453 (2018)...referenced here as *
%% The manuscripts that is going to be usedd for the vector population models is: Erickson, R.A., Presley, S.M., Allen, L.J.S., Long, K.R., Cox, S.B. Ecological modleing 221 (2010) 1273-1282 referenced as ** A stage-structured Aedes Albopictus population Model. 
%% The function will be modified in function of varargin but in other steps modification will be specified here.

function Salida=ODEs(task,varargin) %me tiene que entregar los datos acumulados de infeccion
    if nargin~=0 && task~=0       
        if task == 1   %estoy frente a solo simulacion del proceso SEIR-SEI
        timerange=varargin{1};
        nclus=varargin{2};
        Nh=varargin{3};
        Nv=varargin{4};
        q=varargin{5};
        uv=varargin{6};
        uh=varargin{7};
        kv=varargin{8};
        kh=varargin{9};
        gama=varargin{10};
        alpha=varargin{11};
        pv=varargin{12};
        ph=varargin{13};
        tau=varargin{14};
        initvalues=varargin{15};     
        options=odeset('NonNegative',1,'AbsTol',1E-10);
        [tt,Results]=ode23tb(@(t,x) dengueODE1(t,x,nclus,q, Nh, Nv, uv, uh, kv, kh, gama, alpha, pv, ph, tau), timerange, initvalues,options);       
        Salida=[tt Results];  
        if numel(timerange)==2
           Salida=[Salida(1,:); Salida(end,:)];
            
        end
        
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
        elseif task==2 % SEIR_LSEI coneccion de modelos anteriores.        
        timerange=varargin{1};
        nclus=varargin{2};
        temp=varargin{3};
        q=varargin{4};
        Nh=varargin{5};  
        uh=varargin{6};
        kv=varargin{7};
        kh=varargin{8};
        gama=varargin{9};
        alpha=varargin{10};
        pv=varargin{11};
        ph=varargin{12};
        tau=varargin{13};
        k0=varargin{14};
        ep=varargin{15};
        Tp=varargin{16};
        Tl=varargin{17};
        Ti=varargin{18};
        Te=varargin{19};
        Pre01=varargin{20};
        Pre02=varargin{21};
        Pre03=varargin{22};
        nenv=varargin{31};
        mu1=reshape(varargin{23},[nenv,nclus]);
        mu2=reshape(varargin{24},[nenv,nclus]);
        mu3=reshape(varargin{25},[nenv,nclus]);
        mu4=reshape(varargin{26},[nenv,nclus]);
        mu5=reshape(varargin{27},[nenv,nclus]);
        mu6=reshape(varargin{28},[nenv,nclus]);
        initvalues=varargin{29};
        range=varargin{30};
        
        if size(temp,1)==1
           temp=[temp; temp];
        end
        
        %if range~=0 && range>=1 %converte la simulacion en forecasting
        %    timerange=0:1:range;
        %    temp=ones(1,range)*temp(end);
        %end   
          
        options=odeset('AbsTol',1E-10);
        [tt,Results]=ode23tb(@(t,x) dengueODE4_Modified(t,x,timerange, nclus, temp, q, Nh, uh, kv, kh, gama, alpha, pv, ph, tau, k0, ep, Tp, Tl, Ti, Te, Pre01, Pre02, Pre03, mu1, mu2,mu3,mu4, mu5, mu6, nenv), timerange, initvalues,options);
     
        % assignin('base','Results',Results);
      %  assignin('base','tt',tt);  
        
         if range~=0 && range>=1
         Salida=Results;
         else
         Salida=[tt Results];    
         end
     %   
     %   assignin('base','Results',Results)
     %   assignin('base','tt',tt)
        if numel(timerange)==2
           Salida=[Salida(1,:); Salida(end,:)];
            
        end    
     
  %%%%%%%%%%%%%%%%%%% task 3 simulacion de solo vector, los vectores  
        elseif task==3 %  
        timerange=varargin{1};
        nclus=varargin{2};
        temp=varargin{3};
        k0=varargin{4};
        ep=varargin{5};
        Tp=varargin{6};
        Tl=varargin{7};
        Ti=varargin{8};
        Te=varargin{9};
        Pre01=varargin{10};
        Pre02=varargin{11};
        Pre03=varargin{12};
        nenv=varargin{21};
        mu1=reshape(varargin{13},[nenv,nclus]);
        mu2=reshape(varargin{14},[nenv,nclus]);
        mu3=reshape(varargin{15},[nenv,nclus]);
        mu4=reshape(varargin{16},[nenv,nclus]);
        mu5=reshape(varargin{17},[nenv,nclus]);
        mu6=reshape(varargin{18},[nenv,nclus]);
        initvalues=varargin{19};    
        range=varargin{20};
        options=odeset('NonNegative',1,'AbsTol',1E-10);
        
        if size(temp,1)==1
           temp=[temp; temp];
        end
        
        %if range~=0 && range>=1
        %    timerange=0:1:range;
        %    temp=ones(1,range)*temp(end);
        %end   
        
        [tt,Results]=ode23tb(@(t,x) dengueODE3_Modified(t,x,timerange, nclus, temp, k0, ep, Tp, Tl, Ti, Te,Pre01, Pre02, Pre03, mu1, mu2,mu3,mu4, mu5, mu6, nenv), timerange, initvalues,options);
        
         if range~=0 && range>=1
         Salida=Results;
         else
         Salida=[tt Results];    
         end
        
    %    assignin('base','Results',Results)
    %    assignin('base','tt',tt)  
        if numel(timerange)==2
           Salida=[Salida(1,:); Salida(end,:)];            
        end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
        elseif task==4 % predicción de parametros para SEIR-SEI       
        xdata=varargin{1}; %esto como será una cantidad de puntos especificos es lo mismo que timerange [0 1 2 3 4 30]
        nclus=varargin{2};
        Nh=varargin{3};
        Nv=varargin{4};
        q=varargin{5};
        uv=varargin{6};
        uh=varargin{7};
        kv=varargin{8};
        kh=varargin{9};
        gama=varargin{10};
        alpha=varargin{11};
        pv=varargin{12};
        ph=varargin{13};
        tau=varargin{14};
        initvalues=varargin{15};
        ydata=varargin{16};  
        fixedparam=varargin{17}; %[1 1 1 1 1 1 1 1 0 0 0 0 1 1 0 0 0 0 0 0 0 0] %fijadas por el usuario [Nh1 Nh2 Nv1 Nv2 Uv1 Uv2 Uh1 Uh2 Kv1 Kv2 Kh1 Kh2 Gama1 Gama2 Alpha1 Alpha2 PV1 Pv2 Ph1 Ph2 Tau1 Tau2]
        fixedq=varargin{18};
        fixedinit=varargin{19};
        selectorvariable=varargin{20};
        tamanos=[length(fixedparam) length(fixedq) length(fixedinit)];
        qp=reshape(q',1,[]);
        fixingM=[fixedparam fixedq fixedinit];
        parameters=[Nh Nv uv uh kv kh gama alpha pv ph tau qp initvalues'];
        NumParamProblema=11; % 11 parametros maximos a fijar.
        ub=ones(1,nclus*NumParamProblema+nclus*nclus+nclus*8)*1E8; %standard upper limit has to be imrpoved by an algorithm
        lb=zeros(1,nclus*NumParamProblema+nclus*nclus+nclus*8); %standard lower limit
        
        Nhlb=zeros(1,nclus); %Nh upper limit
        Nvlb=Nh; %Nh upper limit
        uvlb=1/30*ones(1,nclus); %Nh upper limit
        uhlb=1/(75*365)*zeros(1,nclus); %Nh upper limit
        kvlb=1/15*ones(1,nclus); %Nh upper limit
        khlb=1/10*ones(1,nclus); %Nh upper limit
        gamalb=1/(8)*ones(1,nclus); %Nh upper limit
        alphalb=zeros(1,nclus); %Nh upper limit
        pvlb=zeros(1,nclus); %Nh upper limit
        phlb=zeros(1,nclus); %Nh upper limit
        taulb=zeros(1,nclus); %Nh upper limit
        qplb=zeros(1,nclus*nclus);
        initvalueslb=zeros(1,8*nclus);
        lb=[Nhlb Nvlb uvlb uhlb kvlb khlb gamalb alphalb pvlb phlb taulb qplb initvalueslb];
    
        Nhub=1E10*ones(1,nclus); %Nh upper limit
        Nvub=5*Nh; %Nh upper limit
        uvub=1/11*ones(1,nclus); %Nh upper limit
        uhub=1/(65*365)*ones(1,nclus); %Nh upper limit
        kvub=1/(6.5)*ones(1,nclus); %Nh upper limit
        khub=1/3*ones(1,nclus); %Nh upper limit
        gamaub=1/6*ones(1,nclus); %Nh upper limit
        alphaub=2*ones(1,nclus); %Nh upper limit
        pvub=1*ones(1,nclus); %Nh upper limit
        phub=1*ones(1,nclus); %Nh upper limit
        tauub=1/14*ones(1,nclus); %Nh upper limit
        qpub=1*ones(1,nclus*nclus);
        initvaluesub=1E12*ones(1,8*nclus);
        ub=[Nhub Nvub uvub uhub kvub khub gamaub alphaub pvub phub tauub qpub initvaluesub];
        
        otros=eps^0.5*ones(1,nclus*11+nclus*nclus);
        initvaluesfd=1E-3*ones(1,8*nclus);
        fd=[otros initvaluesfd];  
   
        xo=parameters(find(~fixingM));
        ub=ub(find(~fixingM));
        lb=lb(find(~fixingM));
        fd=fd(find(~fixingM));
               
        aeqh =[[fixingM(1,(NumParamProblema*nclus+nclus*nclus+1):(NumParamProblema*nclus+nclus*nclus+nclus))]' [fixingM(1,(NumParamProblema*nclus+nclus*nclus+1+2*nclus):(NumParamProblema*nclus+nclus*nclus+3*nclus))]' [fixingM(1,(NumParamProblema*nclus+nclus*nclus+4*nclus+1):(NumParamProblema*nclus+nclus*nclus+5*nclus))]' [fixingM(1,(NumParamProblema*nclus+nclus*nclus+6*nclus+1):(NumParamProblema*nclus+nclus*nclus+7*nclus))]' [fixingM(1,1:nclus)]'];
        aeqv =[[fixingM(1,(NumParamProblema*nclus+nclus*nclus+1+nclus):(NumParamProblema*nclus+nclus*nclus+2*nclus))]' [fixingM(1,(NumParamProblema*nclus+nclus*nclus+1+3*nclus):(NumParamProblema*nclus+nclus*nclus+4*nclus))]' [fixingM(1,(NumParamProblema*nclus+nclus*nclus+5*nclus+1):(NumParamProblema*nclus+nclus*nclus+6*nclus))]' [fixingM(1,(1+nclus):2*nclus)]'];
        if sum(sum(aeqh))~=5*nclus ||  sum(sum(aeqv))~=4*nclus
           aeq=zeros(nclus,size(xo,2));
           aeq2=zeros(nclus,size(xo,2));
           beq=zeros(2*nclus,1);
               for i=1:nclus
                  for j=1:size(fixingM,2)
                       if fixingM(1,j)==0 && (j==(NumParamProblema*nclus+nclus^2+i) || j==(NumParamProblema*nclus+nclus^2+i+2*nclus) || j==(NumParamProblema*nclus+nclus^2+i+4*nclus) || j==(NumParamProblema*nclus+nclus^2+i+6*nclus))
                          indice=find(find(~fixingM)==j);
                           aeq(i,indice)=1;
                       elseif fixingM(1,j)==0 && (j==(NumParamProblema*nclus+nclus^2+i+nclus) || j==(NumParamProblema*nclus+nclus^2+i+3*nclus) || j==(NumParamProblema*nclus+nclus^2+i+5*nclus))
                          indice=find(find(~fixingM)==j);
                           aeq2(i,indice)=1;
                       elseif fixingM(1,j)==0 && j==i
                           indice=find(find(~fixingM)==j);
                           aeq(i,indice)=-1;
                       elseif fixingM(1,j)==0 && j==i+nclus
                           indice=find(find(~fixingM)==j);
                           aeq2(i,indice)=-1;
                       end
                  end
                  if numel(find(aeq(i,:)))~=5
                        beq(i)=-fixingM(1,NumParamProblema*nclus+nclus*nclus+i)*parameters(1,NumParamProblema*nclus+nclus*nclus+i)-fixingM(1,NumParamProblema*nclus+nclus*nclus+i+2*nclus)*parameters(1,NumParamProblema*nclus+nclus*nclus+i+2*nclus)-fixingM(1,NumParamProblema*nclus+nclus*nclus+4*nclus+i)*parameters(1,NumParamProblema*nclus+nclus*nclus+4*nclus+i)-fixingM(1,NumParamProblema*nclus+nclus*nclus+6*nclus+i)*parameters(1,NumParamProblema*nclus+nclus*nclus+6*nclus+i)+fixingM(1,i)*parameters(1,i);
                  else
                      beq(i)=0;
                  end
                  if numel(find(aeq2(i,:)))~=4
                        beq(i+nclus)=-fixingM(1,NumParamProblema*nclus+nclus*nclus+i+nclus)*parameters(1,NumParamProblema*nclus+nclus*nclus+i+nclus)-fixingM(1,NumParamProblema*nclus+nclus*nclus+i+3*nclus)*parameters(1,NumParamProblema*nclus+nclus*nclus+i+3*nclus)-fixingM(1,NumParamProblema*nclus+nclus*nclus+5*nclus+i)*parameters(1,NumParamProblema*nclus+nclus*nclus+5*nclus+1)+fixingM(1,i+nclus)*parameters(1,i+nclus);
                  else
                      beq(i+nclus)=0;
                  end

               end
        else
            aeq=[];
            beq=[];
        end
      aeq=[aeq; aeq2];      
     options=optimoptions('fmincon','MaxFunEvals',10000,'PlotFcn',@optimplotfval,'OutputFcn',@optimplotfval,'MaxIterations',300,'FunctionTolerance',1E-3,'Algorithm','interior-point','StepTolerance',1E-10,'FiniteDifferenceStepSize',fd);   
     [Coef, fval, exitflag, output, lambda, grad, Hessian]=fmincon(@(x) dengueODE15(x,xdata,nclus,q,initvalues,fixingM,parameters,NumParamProblema,tamanos,selectorvariable,ydata),xo,[],[],aeq,beq,lb,ub,[],options); % IMPORTANT !!!!!!!! la minimización se realiza considerando a ambos clusters al mismo tiempo. se reduce el error de la suma de ambos Cs.
       
     
     
     Rsd=getappdata(0,'residual');
    
        for i=1:tamanos(1)
           if fixedparam(i)==1
               coefs(i)=parameters(i);
           else
               coefs(i)=Coef(1);
               Coef(1)=[];
           end
        end
        
        for i=1:tamanos(2)
           if fixedq(i)==1
               coefs2(i)=parameters(i+tamanos(1));
           else
               coefs2(i)=Coef(1);
               Coef(1)=[];
           end
        end
        
        for i=1:tamanos(3)
           if fixedinit(i)==1
               coefs3(i)=parameters(i+tamanos(1)+tamanos(2));
           else
               coefs3(i)=Coef(1);
               Coef(1)=[];
           end
        end
        
        Salida={coefs coefs2 coefs3 Rsd};
     
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
        elseif task==5 % predicción de parametros para LSEI         
        xdata=varargin{1};     
        nclus=varargin{2};
        temp=varargin{3};
        k0=varargin{4};
        ep=varargin{5};
        Tp=varargin{6};
        Tl=varargin{7};
        Ti=varargin{8};
        Te=varargin{9};
        Pre01=varargin{10};
        Pre02=varargin{11};
        Pre03=varargin{12};
        mu1=varargin{13};
        mu2=varargin{14};
        mu3=varargin{15};
        mu4=varargin{16};
        mu5=varargin{17};
        mu6=varargin{18};
        initvalues=varargin{19};
        ydata=varargin{20}; %this is only 1 columns that con be eggs population, larvae population, pupae, mature mosquitoes.
        fixedparam=varargin{21};     
        selectorvariable=varargin{22}; %this specifies a number 1, 2 ,3 ,4 if 1... the eggs population is used for feeting, 2 .... larvae, 3....pupae, 4 ... mature mosquitoes.
        fixedinit=varargin{23};
        nenv=varargin{24};
        tamanos=[length(fixedparam) length(fixedinit)];
        fixingM=[fixedparam fixedinit];
        
        if size(temp,1)==1
            warning('There is less temperature information than points')
            Salida=[];
        end
        
        parameters=[k0 ep Tp Tl Ti Te Pre01 Pre02 Pre03 mu1 mu2 mu3 mu4 mu5 mu6 initvalues'];
        %NumParamProblema=15;
        
        %ub=ones(1,numel(parameters))*1E8; %standard upper limit has to be imrpoved by an algorithm
        %lb=zeros(1,numel(parameters)); %standard lower limit           

        k0lb=zeros(1,nclus);
        eplb=zeros(1,nclus);
        Tplb=zeros(1,nclus);
        Tllb=zeros(1,nclus);
        Tilb=zeros(1,nclus);
        Telb=zeros(1,nclus);
        Pre01lb=zeros(1,nclus); 
        Pre02lb=zeros(1,nclus);
        Pre03lb=zeros(1,nclus);
        mu1lb=273.15*ones(1,nclus*nenv);
        mu2lb=273.15*ones(1,nclus*nenv);
        mu3lb=273.15*ones(1,nclus*nenv);
        mu4lb=273.15*ones(1,nclus*nenv);
        mu5lb=273.15*ones(1,nclus*nenv);
        mu6lb=273.15*ones(1,nclus*nenv);
        initvalueslb=zeros(1,5*nclus);
        
        lb=[k0lb eplb Tplb Tllb Tilb Telb Pre01lb Pre02lb Pre03lb mu1lb mu2lb mu3lb mu4lb mu5lb mu6lb initvalueslb];
        
        k0ub=1e8*ones(1,nclus);
        epub=1e8*ones(1,nclus);
        Tpub=1e8*ones(1,nclus);
        Tlub=1e8*ones(1,nclus);
        Tiub=1e8*ones(1,nclus);
        Teub=1e8*ones(1,nclus);
        Pre01ub=ones(1,nclus); 
        Pre02ub=ones(1,nclus);
        Pre03ub=ones(1,nclus);
        mu1ub=323.15*ones(1,nclus*nenv);
        mu2ub=323.15*ones(1,nclus*nenv);
        mu3ub=323.15*ones(1,nclus*nenv);
        mu4ub=323.15*ones(1,nclus*nenv);
        mu5ub=323.15*ones(1,nclus*nenv);
        mu6ub=323.15*ones(1,nclus*nenv);
        initvaluesub=1e12*ones(1,5*nclus);
        
        ub=[k0ub epub Tpub Tlub Tiub Teub Pre01ub Pre02ub  Pre03ub mu1ub mu2ub mu3ub mu4ub mu5ub mu6ub initvaluesub];
           
        otros=eps^0.5*ones(1,numel(ub)-5*nclus);
        initvaluesfd=ones(1,5*nclus);
        fd=[otros initvaluesfd];    
        
        xo=parameters(find(~fixingM));
        ub=ub(find(~fixingM));
        lb=lb(find(~fixingM));
      %  fd=fd(find(~fixingM));
        
      %  options=optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','MaxFunEvals',5000,'PlotFcn',@optimplotfval,'MaxIterations',1000,'FunctionTolerance',1E-3,'Algorithm','trust-region-reflective','StepTolerance',1E-5,'FiniteDifferenceStepSize',fd);            
      %  [Coef, Resdnrm, Rsd, ExFlg, OptmInfo, Lmda, Jmat]=lsqcurvefit(@(x,xdata) dengueODE7_Modified(x,xdata,nclus,temp,initvalues,fixingM,parameters,selectorvariable,tamanos,nenv),xo,xdata,ydata,lb,ub,options); % IMPORTANT !!!!!!!! la minimización se realiza considerando a ambos clusters al mismo tiempo. se reduce el error de la suma de ambos Cs. 
    
        
         options=optimoptions('fmincon','MaxFunEvals',10000,'PlotFcn',@optimplotfval,'OutputFcn',@optimplotfval,'MaxIterations',100,'FunctionTolerance',1E-5,'Algorithm','active-set','StepTolerance',1E-5); %'FiniteDifferenceStepSize',fd  
     [Coef, fval, exitflag, output, lambda, grad, Hessian]=fmincon(@(x) dengueODE7_Modified(x,xdata,nclus,temp,initvalues,fixingM,parameters,selectorvariable,tamanos,ydata,nenv),xo,[],[],[],[],lb,ub,[],options); %options IMPORTANT !!!!!!!! la minimización se realiza considerando a ambos clusters al mismo tiempo. se reduce el error de la suma de ambos Cs.
        Rsd=getappdata(0,'residual');
        
        for i=1:tamanos(1)
           if fixedparam(i)==1
               coefs(i)=parameters(i);
           else
               coefs(i)=Coef(1);
               Coef(1)=[];
           end
        end
        
        for i=1:tamanos(2)
           if fixedinit(i)==1
               coefs3(i)=parameters(i+tamanos(1));
           else
               coefs3(i)=Coef(1);
               Coef(1)=[];
           end
        end
        
        coefs2=[];
        Salida={coefs coefs2 coefs3 Rsd};
        
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% task 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
        
        elseif task==6 % Prediccion de parametros para SEIR-LSEI
        
        xdata=varargin{1};
        nclus=varargin{2};
        Temperature=varargin{3};
        q=varargin{4};
        Nh=varargin{5};  %Nv es predecido por el modelo
        uh=varargin{6}; %uv es predecido por el modelo
        kv=varargin{7};
        kh=varargin{8};
        gama=varargin{9};
        alpha=varargin{10};
        pv=varargin{11};
        ph=varargin{12};
        tau=varargin{13};
        k0=varargin{14};
        ep=varargin{15};
        Tp=varargin{16};
        Tl=varargin{17};
        Ti=varargin{18};
        Te=varargin{19};
        Pre01=varargin{20};
        Pre02=varargin{21};
        Pre03=varargin{22};
        mu1=varargin{23};
        mu2=varargin{24};
        mu3=varargin{25};
        mu4=varargin{26};
        mu5=varargin{27};
        mu6=varargin{28};
        initvalues=varargin{29};
        ydata=varargin{30};
        fixedparam=varargin{31};
        selectorvariable=varargin{32};
        fixedq=varargin{33};
        fixedinit=varargin{34};
        nenv=varargin{35};
        tamanos=[length(fixedparam) length(fixedq) length(fixedinit)];
        qp=reshape(q',1,[]);
        fixingM=[fixedparam fixedq fixedinit];
        
        %if size(Temperature,1)==1
        %   Temperature=[Temperature; Temperature];
        %end
        
        parameters=[Nh uh kv kh gama alpha pv ph tau k0 ep Tp Tl Ti Te Pre01 Pre02 Pre03 mu1 mu2 mu3 mu4 mu5 mu6 qp initvalues'];
        ParamNonState=numel(parameters)-12*nclus; %this correspond to all the parameters that are not state variablels  
        
        Nhlb=zeros(1,nclus); %Nh upper limit
        uhlb=zeros(1,nclus); %Nh upper limit
        kvlb=1/15*ones(1,nclus); %Nh upper limit
        khlb=1/10*ones(1,nclus); %Nh upper limit
        gamalb=1/(8)*ones(1,nclus); %Nh upper limit
        alphalb=zeros(1,nclus); %Nh upper limit
        pvlb=zeros(1,nclus); %Nh upper limit
        phlb=zeros(1,nclus); %Nh upper limit
        taulb=zeros(1,nclus); %Nh upper limit
        k0lb=zeros(1,nclus);
        eplb=1*ones(1,nclus);
        Tplb=zeros(1,nclus);
        Tllb=zeros(1,nclus);
        Tilb=zeros(1,nclus);
        Telb=zeros(1,nclus);
        Pre01lb=zeros(1,nclus); %Nh upper limit
        Pre02lb=zeros(1,nclus);
        Pre03lb=zeros(1,nclus);
        mu1lb=273.15*ones(1,nclus*nenv);
        mu2lb=273.15*ones(1,nclus*nenv);
        mu3lb=273.15*ones(1,nclus*nenv);
        mu4lb=273.15*ones(1,nclus*nenv);
        mu5lb=273.15*ones(1,nclus*nenv);
        mu6lb=273.15*ones(1,nclus*nenv);
        qplb=zeros(1,nclus*nclus);
        initvalueslb=zeros(1,12*nclus);
        lb=[Nhlb uhlb kvlb khlb gamalb alphalb pvlb phlb taulb k0lb eplb Tplb Tllb Tilb Telb Pre01lb Pre02lb Pre03lb mu1lb mu2lb mu3lb mu4lb mu5lb mu6lb qplb initvalueslb];       
    
        Nhub=1E10*ones(1,nclus); %Nh upper limit
        uhub=1/(65*365)*ones(1,nclus); %Nh upper limit
        kvub=1/6.5*ones(1,nclus); %Nh upper limit
        khub=1/3*ones(1,nclus); %Nh upper limit
        gamaub=1/6*ones(1,nclus); %Nh upper limit
        alphaub=2*ones(1,nclus); %Nh upper limit
        pvub=1*ones(1,nclus); %Nh upper limit
        phub=1*ones(1,nclus); %Nh upper limit
        tauub=1/14*ones(1,nclus); %Nh upper limit
        k0ub=1e8*ones(1,nclus);
        epub=50*ones(1,nclus);
        Tpub=1*ones(1,nclus);
        Tlub=1*ones(1,nclus);
        Tiub=1*ones(1,nclus);
        Teub=1*ones(1,nclus);
        Pre01ub=323.15*ones(1,nclus); %Nh upper limit
        Pre02ub=323.15*ones(1,nclus);
        Pre03ub=ones(1,nclus);
        mu1ub=323.15*ones(1,nclus*nenv);
        mu2ub=323.15*ones(1,nclus*nenv);
        mu3ub=323.15*ones(1,nclus*nenv);
        mu4ub=323.15*ones(1,nclus*nenv);
        mu5ub=323.15*ones(1,nclus*nenv);
        mu6ub=323.15*ones(1,nclus*nenv);
        qpub=1*ones(1,nclus*nclus);
        initvaluesub=1E20*ones(1,12*nclus);
        ub=[Nhub uhub kvub khub gamaub alphaub pvub phub tauub k0ub epub Tpub Tlub Tiub Teub Pre01ub Pre02ub Pre03ub mu1ub mu2ub mu3ub mu4ub mu5ub mu6ub qpub initvaluesub];
        otros=eps^0.5*ones(1,ParamNonState);
        initvaluesfd=1e-3*ones(1,12*nclus);
        fd=[otros initvaluesfd];    
        
        xo=parameters(find(~fixingM));
        ub=ub(find(~fixingM));
        lb=lb(find(~fixingM));
      %  fd=fd(find(~fixingM));
               
        aeqh =[[fixingM(1,(ParamNonState+1):(ParamNonState+nclus))]' [fixingM(1,(ParamNonState+1+2*nclus):(ParamNonState+3*nclus))]' [fixingM(1,(ParamNonState+4*nclus+1):(ParamNonState+5*nclus))]' [fixingM(1,(ParamNonState+6*nclus+1):(ParamNonState+7*nclus))]' [fixingM(1,1:nclus)]'];
        av =[[fixingM(1,(ParamNonState+1+nclus):(ParamNonState+2*nclus))]' [fixingM(1,(ParamNonState+1+3*nclus):(ParamNonState+4*nclus))]' [fixingM(1,(ParamNonState+5*nclus+1):(ParamNonState+6*nclus))]'];
        if sum(sum(aeqh))~=5*nclus ||  sum(sum(av))~=3*nclus
          aeq=zeros(nclus,size(xo,2));
          beq=zeros(nclus,1);
          A=zeros(nclus,size(xo,2));
          B=zeros(nclus,1);
               for i=1:nclus
                  for j=1:size(fixingM,2)
                       if fixingM(1,j)==0 && (j==(ParamNonState+i) || j==(ParamNonState+i+2*nclus) || j==(ParamNonState+i+4*nclus) || j==(ParamNonState+i+6*nclus))
                          indice=find(find(~fixingM)==j);
                           aeq(i,indice)=1;
                       elseif fixingM(1,j)==0 && j==i
                           indice=find(find(~fixingM)==j);
                           aeq(i,indice)=-1;
                    %   elseif fixingM(1,j)==0 && (j==(ParamNonState+i+nclus) || j==(ParamNonState+i+3*nclus) || j==(ParamNonState+i+5*nclus))
                    %       indice=find(find(~fixingM)==j);
                    %       A(i,indice)=-1;
                       end
                  end
                  if numel(find(aeq(i,:)))~=5 && sum(aeq(i,:))~=0
                        beq(i)=-fixingM(1,ParamNonState+i)*parameters(1,ParamNonState+i)-fixingM(1,ParamNonState+i+2*nclus)*parameters(1,ParamNonState+i+2*nclus)-fixingM(1,ParamNonState+4*nclus+i)*parameters(1,ParamNonState+4*nclus+i)-fixingM(1,ParamNonState+6*nclus+i)*parameters(1,ParamNonState+6*nclus+i)+fixingM(1,i)*parameters(1,i);
                  else
                      beq(i)=0;
                  end
                %  if numel(find(av(i,:)))~=0 && sum(A(i,:))~=0
               %         B(i)=-(Nh(i)/2-fixingM(1,ParamNonState+i+nclus)*parameters(1,ParamNonState+i+nclus)-fixingM(1,ParamNonState+i+3*nclus)*parameters(1,ParamNonState+i+3*nclus)-fixingM(1,ParamNonState+5*nclus+i)*parameters(1,ParamNonState+5*nclus+1));
                %  else
               %       B(i)=0;
               %   end
              end
        else
            aeq=[];
            beq=[];
        end
            A=[];
            B=[];
     options=optimoptions('fmincon','MaxFunEvals',10000,'PlotFcn',@optimplotfval,'OutputFcn',@optimplotfval,'MaxIterations',1000,'FunctionTolerance',1E-3,'Algorithm','interior-point','StepTolerance',1E-10); %  'FiniteDifferenceStepSize',fd
     [Coef, fval, exitflag, output, lambda, grad, Hessian]=fmincon(@(x) dengueODE16_Modified(x,xdata,nclus,q,Temperature,initvalues,fixingM,parameters,selectorvariable,tamanos,ydata,nenv),xo,A,B,aeq,beq,lb,ub,[],options); % IMPORTANT !!!!!!!! la minimización se realiza considerando a ambos clusters al mismo tiempo. se reduce el error de la suma de ambos Cs.
     % [Coef, fval, exitflag, output, lambda, grad, Hessian]=fmincon(@(x) dengueODE16_Modified(x,xdata,nclus,q,Temperature,initvalues,fixingM,parameters,selectorvariable,tamanos,ydata,nenv),xo,[],[],[],[],lb,ub,[],options); % IMPORTANT !!!!!!!! la minimización se realiza considerando a ambos clusters al mismo tiempo. se reduce el error de la suma de ambos Cs.
        Rsd=getappdata(0,'residual');
    
     %  options=optimoptions('ga','PlotFcn',@optimplotfval);
     %  FitnessFunction=@(x) dengueODE16(x,xdata,nclus,q,Temperature,initvalues,fixingM,parameters,NumParamProblema,selectorvariable,tamanos,ydata)
    %[Coef, fval, exitflag, output, population, scores]=ga(FitnessFunction,1,[],[],[],[],[],[],[],options); % IMPORTANT !!!!!!!! la minimización se realiza considerando a ambos clusters al mismo tiempo. se reduce el error de la suma de ambos Cs.
       
        
        for i=1:tamanos(1)
           if fixedparam(i)==1
               coefs(i)=parameters(i);
           else
               coefs(i)=Coef(1);
               Coef(1)=[];
           end
        end
        
        for i=1:tamanos(2)
           if fixedq(i)==1
               coefs2(i)=parameters(i+tamanos(1));
           else
               coefs2(i)=Coef(1);
               Coef(1)=[];
           end
        end
        
        for i=1:tamanos(3)
           if fixedinit(i)==1
               coefs3(i)=parameters(i+tamanos(1)+tamanos(2));
           else
               coefs3(i)=Coef(1);
               Coef(1)=[];
           end
        end
        
        Salida={coefs coefs2 coefs3 Rsd};
        
   %%%%%%%%%%%%%%%% task 7 forecasting No Filtering
   elseif task==7            
    termino=0;
    sistema=varargin{1};
    nclus=varargin{2};
    BackDays=varargin{3};
    ForeDays=varargin{4};
    E=varargin{5};
    V=varargin{6};
    TEMP=varargin{7};
    A=varargin{8};
    q=varargin{9};
    param=varargin{10};
    init=varargin{11};
    Q=varargin{12};
    PARAM=varargin{13};
    INIT=varargin{14};
    optimizoQ=varargin{15};
    handles=varargin{16};  
    xdata=varargin{17};
    ydata=varargin{18};
    Xdata=varargin{19};
    SETING=varargin{20}';
    SETING2=varargin{21}';
    SETING3=varargin{22}';
    nenv=varargin{23};
    
    while     termino==0            
        TamanoDatos=max(size(E,1),size(V,1));
        if BackDays>TamanoDatos
            warndlg('Backward days is too big for the given data')
            Salida=[];
            break
        end
        %depending on the problem type a choose the data to be used and
        %called MOM
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% cambio la variable de interes por la
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% presente %%%%%%%%%%%%%%%%%%%%%%%
    INITIALm=[];
    INITIAL=[];
    for i=1:size(init,1)
        %for j=1:nclus
            if i==3 && get(handles.radiobInfectedHost,'Value')==1 && (find(sistema==1)==1 || find(sistema==1)==4 || find(sistema==1)==2 || find(sistema==1)==5) 
                INITIALm(i,:)=ydata(1,:);
            elseif i==8 && get(handles.radiobCAccumulated,'Value')==1 && (find(sistema==1)==1 || find(sistema==1)==4 || find(sistema==1)==2 || find(sistema==1)==5)
                INITIALm(i,:)=ydata(1,:);
            elseif i==2  && get(handles.radiob124,'Value')==1 && (find(sistema==1)==2 || find(sistema==1)==4)
                INITIALm(i,:)=ydata(1,:);
            elseif (find(sistema==1)==3) && i==1 && get(handles.radiob121,'Value')==1
                INITIALm(i,:)=ydata(1,:);
            elseif (find(sistema==1)==3) && i==2 && get(handles.radiob122,'Value')==1
                INITIALm(i,:)=ydata(1,:);
            elseif (find(sistema==1)==3) && i==3 && get(handles.radiob123,'Value')==1
                INITIALm(i,:)=ydata(1,:);
            elseif (find(sistema==1)==3) && i==5 && get(handles.radiob124,'Value')==1
                INITIALm(i,:)=ydata(1,:);
            else
                INITIALm(i,:)=INIT(i,:);
            end 
        %end
        INITIAL=[INITIAL INITIALm(i,:)];
    end 
    
    if optimizoQ==1  %esto quiere decir que realizo primero una optimizacion)
        Ydata=ydata;
        if get(handles.radiobInfectedHost,'Value')==1
            selectorvariable=1;
         %   SETING3(1,nclus*2+1:3*nclus)=ones(1,nclus);
         SETING3(:,3)=ones(nclus,1);
         
        elseif get(handles.radiobCAccumulated,'Value')==1
            selectorvariable=2;
         %   SETING3(1,nclus*7+1:8*nclus)=ones(1,nclus);
         SETING3(:,8)=ones(nclus,1);
         
        elseif get(handles.radiob121,'Value')==1 && (find(sistema==1)==3)
            selectorvariable=1;
            SETING3(:,1)=ones(nclus,1);
        %    SETING3(1,1:nclus)=ones(1,nclus);    
        elseif get(handles.radiob122,'Value')==1 && (find(sistema==1)==3)
            selectorvariable=2;
            SETING3(:,2)=ones(nclus,1);
         %  SETING3(1,nclus+1:2*nclus)=ones(1,nclus);        
        elseif get(handles.radiob123,'Value')==1 && (find(sistema==1)==3)
            selectorvariable=3;
          %  SETING3(1,2*nclus+1:3*nclus)=ones(1,nclus);     
          SETING3(:,3)=ones(nclus,1);
        elseif get(handles.radiob124,'Value')==1 && (find(sistema==1)==2)
            selectorvariable=3;
            SETING3(:,2)=ones(nclus,1);
          %  SETING3(1,nclus*11+1:12*nclus)=ones(1,nclus);
        elseif get(handles.radiob124,'Value')==1 && (find(sistema==1)==3)
            selectorvariable=4;
            %SETING3(1,3*nclus+1:4*nclus)=ones(nclus);
            SETING3(:,end)=ones(nclus,1);    
        end
        
        if nclus>1
            SETINGM=[];
            SETINGM2=[];
            SETINGM3=[];
            for i=1:size(SETING,2)
                SETINGM=[SETINGM SETING(:,i)'];         
            end
            for i=1:size(SETING2,2)
                SETINGM2=[SETINGM2 SETING2(:,i)'];            
            end
            for i=1:size(SETING3,2)
                SETINGM3=[SETINGM3 SETING3(:,i)'];
            end
            SETING=SETINGM;
            SETING2=SETINGM2;
            SETING3=SETINGM3;
        end
        
        
        
        
        
        
        
        
        
        
        if isempty(selectorvariable)==1 || selectorvariable==0
            warndlg('Please, set first the variable to be used in the optimization','Error','replace')
            Salida=[];
            break
        
        end
        
        
        
        
        if find(sistema==1)~=3    
            if (sum(sum(SETING))+sum(sum(SETING2))+sum(sum(SETING3))-11*nclus-nclus*nclus-8*nclus==0 && find(sistema==1)==1) || (sum(sum(SETING))+sum(sum(SETING2))+sum(sum(SETING3))-18*nclus-6*nenv-nclus*nclus-12*nclus==0 && find(sistema==1)==2) && ((get(handles.checkbox28,'Value')==1 && get(handles.radiobEKF,'Value')==1) || (get(handles.radiobPF,'Value')==1 && get(handles.checkbox29,'Value')==1) || (get(handles.radiobNoFiltering,'Value')==1 && get(handles.checkbox11,'Value')==1) || (get(handles.checkbox27,'Value')==1 && get(handles.radiobEKF,'Value')==1) || (get(handles.checkbox26,'Value')==1 && get(handles.radiobPF,'Value')==1)   )
                warndlg('Cant be performed a forecasting with optimization if all the parameters are fixed. please select those that will be fit','Error','replace')
                Salida=[];
                break
            end      
            
        else     
            
            if sum(sum(SETING))+sum(sum(SETING3))-9*nclus-6*nenv-5*nclus==0 && ((get(handles.checkbox28,'Value')==1 && get(handles.radiobEKF,'Value')==1) || (get(handles.radiobPF,'Value')==1 && get(handles.checkbox29,'Value')==1) || (get(handles.radiobNoFiltering,'Value')==1 && get(handles.checkbox11,'Value')==1) || (get(handles.checkbox27,'Value')==1 && get(handles.radiobEKF,'Value')==1) || (get(handles.checkbox26,'Value')==1 && get(handles.radiobPF,'Value')==1)   )
                warndlg('Cant be performed a forecasting with optimization if all the parameters are fixed. please select those that will be fit','Error','replace')
                Salida=[];
                break         
            end      
            
        end

        
        if size(ydata,1)<BackDays+1 || BackDays==0
           warndlg('there is a problem with the information used. Make sure that enough backward days exist. There is no optimization process without backward days','Error','replace') 
           Salida=[];
           break
        end
        
     %   if (11*nclus+nclus*nclus+8*nclus)-sum(SETING)-sum(sum(SETING2))-sum(SETING3)>BackDays
     %      warndlg('Ideally the number of backward days used must be equal or superior to the number of parameters that will be fit, otherwise there parameters could not be the best alternative','Warning','replace')
     %      break
      %  end

      
       if find(sistema==1)==1 
        results=ODEs(4,xdata,nclus, PARAM(1,:), PARAM(2,:),Q, PARAM(3,:), PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), PARAM(10,:), PARAM(11,:), INITIAL', Ydata, SETING, SETING2, SETING3,selectorvariable);
        coef=results{1,1};
        coef2=results{1,2};
        coef3=results{1,3};
        coef2=reshape(coef2,nclus,nclus)';
        resultsODE7=ODEs(1,Xdata,nclus, coef(1:nclus),coef(nclus+1:2*nclus),coef2, coef(2*nclus+1:3*nclus), coef(3*nclus+1:4*nclus), coef(4*nclus+1:5*nclus), coef(5*nclus+1:6*nclus), coef(6*nclus+1:7*nclus), coef(7*nclus+1:8*nclus), coef(8*nclus+1:9*nclus), coef(9*nclus+1:10*nclus), coef(10*nclus+1:11*nclus), coef3, 0);     
        Salida={resultsODE7, coef, coef2, coef3};
       
       elseif find(sistema==1)==2
           
        Mu1=[];
        Mu2=[];
        Mu3=[];
        Mu4=[];
        Mu5=[];
        Mu6=[];          
        for i=1:nenv
            Mu1=[Mu1 PARAM(18+i,:)];
            Mu2=[Mu2 PARAM(18+nenv+i,:)];
            Mu3=[Mu3 PARAM(18+2*nenv+i,:)];
            Mu4=[Mu4 PARAM(18+3*nenv+i,:)];
            Mu5=[Mu5 PARAM(18+4*nenv+i,:)];
            Mu6=[Mu6 PARAM(18+5*nenv+i,:)];
        end      
           
        results=ODEs(6,xdata,nclus,TEMP, Q, PARAM(1,:), PARAM(2,:), PARAM(3,:), PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), PARAM(10,:), PARAM(11,:), PARAM(12,:), PARAM(13,:), PARAM(14,:), PARAM(15,:), PARAM(16,:), PARAM(17,:), PARAM(18,:), Mu1, Mu2, Mu3, Mu4, Mu5, Mu6, INITIAL', Ydata,  SETING, selectorvariable, SETING2, SETING3,nenv);
        coef=results{1,1};
        coef2=results{1,2};
        coef3=results{1,3};
        coef2=reshape(coef2,nclus,nclus)';
        if TEMP(end,1)<Xdata(end,1)
            adicional=[Xdata(end,1) TEMP(end,2:nclus+nenv)];
            TEMP=[TEMP; adicional];
        end
        resultsODE7=ODEs(2,Xdata,nclus,TEMP,Q, coef(1:nclus),coef(nclus+1:2*nclus), coef(2*nclus+1:3*nclus), coef(3*nclus+1:4*nclus), coef(4*nclus+1:5*nclus), coef(5*nclus+1:6*nclus), coef(6*nclus+1:7*nclus), coef(7*nclus+1:8*nclus), coef(8*nclus+1:9*nclus), coef(9*nclus+1:10*nclus), coef(10*nclus+1:11*nclus), coef(11*nclus+1:12*nclus), coef(12*nclus+1:13*nclus), coef(13*nclus+1:14*nclus), coef(14*nclus+1:15*nclus), coef(15*nclus+1:16*nclus), coef(16*nclus+1:17*nclus), coef(17*nclus+1:18*nclus), coef(18*nclus+1:18*nclus+nclus*nenv), coef(18*nclus+nclus*nenv+1:18*nclus+2*nclus*nenv), coef(18*nclus+2*nclus*nenv+1:18*nclus+3*nclus*nenv), coef(18*nclus+3*nclus*nenv+1:18*nclus+4*nclus*nenv), coef(18*nclus+4*nclus*nenv+1:18*nclus+5*nclus*nenv), coef(18*nclus+5*nclus*nenv+1:18*nclus+6*nclus*nenv), coef3, 0,nenv);     
        Salida={resultsODE7, coef, coef2, coef3};
     
        
       elseif find(sistema==1)==3
           
           Mu1=[];
           Mu2=[];
           Mu3=[];
           Mu4=[];
           Mu5=[];
           Mu6=[];  
        for i=1:nenv
            Mu1=[Mu1 PARAM(9+i,:)];
            Mu2=[Mu2 PARAM(9+nenv+i,:)];
            Mu3=[Mu3 PARAM(9+2*nenv+i,:)];
            Mu4=[Mu4 PARAM(9+3*nenv+i,:)];
            Mu5=[Mu5 PARAM(9+4*nenv+i,:)];
            Mu6=[Mu6 PARAM(9+5*nenv+i,:)];
        end       
           
        results=ODEs(5,xdata,nclus, TEMP, PARAM(1,:), PARAM(2,:), PARAM(3,:), PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), Mu1, Mu2, Mu3, Mu4, Mu5, Mu6, INITIAL', Ydata, SETING, selectorvariable, SETING3,nenv);
        coef=results{1,1};
        coef3=results{1,3};
             if TEMP(end,1)<Xdata(end,1)
            adicional=[Xdata(end,1) TEMP(end,2:nclus+nenv)];
            TEMP=[TEMP; adicional];
        end
        resultsODE7=ODEs(3,Xdata,nclus, TEMP, coef(1:nclus),coef(nclus+1:2*nclus), coef(2*nclus+1:3*nclus), coef(3*nclus+1:4*nclus), coef(4*nclus+1:5*nclus), coef(5*nclus+1:6*nclus), coef(6*nclus+1:7*nclus), coef(7*nclus+1:8*nclus), coef(8*nclus+1:9*nclus), coef(9*nclus+1:9*nclus+nclus*nenv), coef(9*nclus+nclus*nenv+1:9*nclus+2*nclus*nenv), coef(9*nclus+2*nclus*nenv+1:9*nclus+3*nclus*nenv), coef(9*nclus+3*nclus*nenv+1:9*nclus+4*nclus*nenv), coef(9*nclus+4*nclus*nenv+1:9*nclus+5*nclus*nenv), coef(9*nclus+5*nclus*nenv+1:9*nclus+6*nclus*nenv), coef3, 0,nenv);     
        Salida={resultsODE7, coef, [], coef3};
    
    
       end     
    elseif optimizoQ==0 
        if find(sistema==1)==1 || find(sistema==1)==4 
        resultsODE7=ODEs(1,Xdata,nclus, PARAM(1,:),PARAM(2,:),Q, PARAM(3,:), PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), PARAM(10,:), PARAM(11,:), INITIAL, 0); 
        coef=[];
        coef2=[];
        coef3=[];
        Salida={resultsODE7, coef, coef2, coef3};
        
        elseif find(sistema==1)==2
    
            
        resultsODE7=ODEs(2,Xdata,nclus,TEMP, Q, PARAM(1,:),PARAM(2,:), PARAM(3,:), PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), PARAM(10,:), PARAM(11,:),PARAM(12,:),PARAM(13,:),PARAM(14,:),PARAM(15,:),PARAM(16,:),PARAM(17,:),PARAM(18,:),PARAM(19:18+nenv,:)', PARAM(19+nenv:18+2*nenv,:)', PARAM(19+2*nenv:18+3*nenv,:)', PARAM(19+3*nenv:18+4*nenv,:)', PARAM(19+4*nenv:18+5*nenv,:)', PARAM(19+5*nenv:18+6*nenv,:)', INITIAL, 0,nenv); 
        coef=[];
        coef2=[];
        coef3=[];
        Salida={resultsODE7, coef, coef2, coef3};             
            
        elseif find(sistema==1)==3   
        resultsODE7=ODEs(3,Xdata,nclus,TEMP, PARAM(1,:),PARAM(2,:), PARAM(3,:), PARAM(4,:), PARAM(5,:), PARAM(6,:), PARAM(7,:), PARAM(8,:), PARAM(9,:), PARAM(10:9+nenv,:)', PARAM(10+nenv:9+2*nenv,:)', PARAM(10+2*nenv:9+3*nenv,:)',PARAM(10+3*nenv:9+4*nenv,:)',PARAM(10+4*nenv:9+5*nenv,:)',PARAM(10+5*nenv:9+6*nenv,:)', INITIAL, 0,nenv); 
        coef=[];
        coef2=[];
        coef3=[];
        Salida={resultsODE7, coef, coef2, coef3};
        end
    end
    termino=1;
   end
            
  %%%%%%%%%%%%%%%% task 8 forecasting with EKF
        elseif task==8 % 
   
        else

        warning('you are missing inputs to make the current process')

        
        end

    
    end


end





%% here I start with the construction of the ode function
