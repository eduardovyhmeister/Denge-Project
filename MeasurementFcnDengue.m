%% Copyright (c) 2018. The Insight Centre for Data Analytics, University College Cork, Ireland.
%% Code cannot be copied and/or distributed without the express permission University College Cork
%% All rights reserved.

function yk = MeasurementFcnDengue(xk,caso,nclus)

if caso==1
yk=xk(2*nclus+1:3*nclus); %SEIR SEI y SEIR LSEI Ih 
elseif caso==2
yk=xk(7*nclus+1:8*nclus); % SEIR SEI an SEIR LSEI Cv
elseif caso==3
yk=xk(nclus+1:2*nclus); % SEIR SVa;
elseif caso==4
yk=xk(4*nclus+1:5*nclus); %LSEI  
elseif caso==5
yk=xk(2*nclus+1:3*nclus); %LSEI  
elseif caso==6
yk=xk(nclus+1:2*nclus); %LSEI  
elseif caso==4
yk=xk(1:nclus); %LSEI  

end