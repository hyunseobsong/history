function [para,y0,D_alpha,tauHigh]=getPara

% operation parameters
y0=[0.1,0.1,2]; % initial concentration
para.sf=5; % feed concentration

% parameters for density-dependent growth
para.alpha=0.25; % simpler form 

% kinetic parameters
para.kd=0.2;

para.k1_fs=2;
para.K1_fs=1;
para.k2_fs=2;
para.K2_fs=2;

para.Ys1=1;
para.Ys2=1;

% reference values for non-dimensionalization
para.k1_ref=para.k1_fs; para.K1_ref=para.K1_fs; para.sf_ref=para.sf;
r_ref = para.k1_ref*para.sf_ref/(para.K1_ref+para.sf_ref);

para.xmax=5;

D_alpha=0.1*r_ref;        
tauHigh=0.5/r_ref;

% non-dimensionlization
para.alpha=para.sf*para.alpha; % my own formulation

para.kd=para.kd/r_ref;
para.k1_fs=para.k1_fs/r_ref;
para.k2_fs=para.k2_fs/r_ref;
para.K1_fs=para.K1_fs/para.sf;
para.K2_fs=para.K2_fs/para.sf;

para.xmax=para.xmax/para.sf;

D_alpha=D_alpha/r_ref;
tauHigh=tauHigh*r_ref;

% operation parameters
y0=y0/para.sf; % initial concentration

% finally ...
para.sf=para.sf/para.sf_ref; % feed concentration 