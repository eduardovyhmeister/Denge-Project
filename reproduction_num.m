% this code is usefull to estimate the reproduction number
syms Nh Eh Ih Rh Nm Em Im f bm bh gamah p um uv ah vm vh

F=[0 0 ah f*bm*Nh; 0 0 f*bm*Nm 0; 0 0 0 0; 0 0 0 0];
V=[uv 0 0 0; 0 um+vm+p 0 0; -vh 0 gamah 0; 0 -vm 0 um+p];
salida=F*V^(-1);
[V,D]=eig(salida);


