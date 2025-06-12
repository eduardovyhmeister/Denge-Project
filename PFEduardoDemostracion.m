%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.

%generate the true states (which is at the end the prediction)
Salida=ODEs(1,[0:1:30],2,[2319655 527091],[4.36E6 4.36E6*0.1],[1 0;0.3 0.7],[1/30 1/30],[1/(75*365) 1/(75*365)], [1/8 1/8], [1/4 1/4], [1/6 1/6], [0.4517 0.4517], [0.2378 0.2378], [0.2199 0.2199], [0.0262 0.0262], [0.999647810000000*2319655;0.999964781000000*527091;0.999495620000000*4.36E6;0.999979139306116*4.36E6*0.1;0.000143120000000000*2319655;1.43120000000000E-05*527091;0.000286240000000000*4.36E6;1.18386236911653e-05*4.36E6*0.1;0.000109070000000000*2319655;1.09070000000000e-05*527091;0.000218140000000000*4.36E6;9.02207019281301e-06*4.36E6*0.1;0.000100000000000000*2319655;1.00000000000000E-05*527091;0;0], 0)
XTrue=Salida(:,2:end)
tspan=Salida(:,1)'
%now we get the samples (which is the data given...we assume it comes with
%small white noise.
sqrtR=0.01
yMeas(:,1:2)=XTrue(:,15:16)+XTrue(:,15:16).*(sqrtR*randn(numel(tspan),1)); %it is important to notice that the meaasurment not include all the state variables
yMeas
initialState=[0.999647810000000*2319655 0.999964781000000*527091 0.999495620000000*4.36E6 0.999979139306116*4.36E6*0.1 0.000143120000000000*2319655 1.43120000000000E-05*527091 0.000286240000000000*4.36E6 1.18386236911653e-05*4.36E6*0.1 0.000109070000000000*2319655 1.09070000000000e-05*527091 0.000218140000000000*4.36E6 9.02207019281301e-06*4.36E6*0.1 0.000100000000000000*2319655 1.00000000000000E-05*527091 0 0] %This is the initial state for the ODE!!!!!
measN=0.01;
pNoise=0.1;
%%construyo el filtro
myPF=particleFilter(@(x)dengueODE12(x,2,[1 0;0.3 0.7],[2319655 527091],[4.36E6 4.36E6*0.1],[1/30 1/30],[1/(75*365) 1/(75*365)], [1/8 1/8], [1/4 1/4], [1/6 1/6], [0.4517 0.4517], [0.2378 0.2378], [0.2199 0.2199], [0.0262 0.0262],pNoise),@vdpMeasurementLikelihoodFcn);
initialize(myPF,100,initialState,eye(16))
myPF.StateEstimationMethod='mean';
myPF.ResamplingMethod='systematic';


%makes two estimates
xEst = zeros(size(XTrue));
for k=1:size(XTrue,1)
       xEst(k,:)=correct(myPF,yMeas(k));
       [xpredict]=predict(myPF);  
end

% Plot results
figure
    plot(XTrue(:,15),XTrue(:,15),'x',xEst(:,15),xEst(:,15),'ro',yMeas,yMeas,'*');
    legend('True','Estimated');