clear all
%% Photoncount.txt should be pre-loaded with the data of photon counts for multiple events from one DNA tether.
%% This program uses HMMs to analyze the photon count database and generate an appropriate set of equally spaced photon levels.
%% Link with sampler's source
addpath('sampler_SRC')


%% Import some data
z = load('photoncount.txt');


%% Set ICON's parameters

% Concentrations
opts.a = 1; % Transitions (alpha)
opts.g = 1; % Base (gamma)

%  hyper-parameters
opts.Q(1) = mean(z);        % mean of means (lambda)
opts.Q(2) = 1/std(z)^2;     % Precision of means (rho)
opts.Q(3) = 0.1;              % Shape of precisions (beta)
opts.Q(4) = 0.00001;           % Scale of precisions (omega)

opts.M = 10;                % Nodes in the interpolation 

%% Set sampler's parameters

opts.dr_sk  = 1;    % Stride, ie save samples every dr_sk itterations
opts.K_init = 50;   % Initial number of photon levels


%% Set output flags

flag_stat = true;   % Print progress report in command line
flag_anim = true;   % Visualize current sample


%% Create a chain and generate samples

R = 1000; % number of samples to be generated

chain = chainer_main( z, R, [], opts, flag_stat, flag_anim );   % run sampler



%% Store samples for external analysis

fr = 0.25;  % fraction of samples to be discarded due to burn-in
dr = 2;     % samples stride, ie exporta every r sample

chainer_export(chain,fr,dr,'samples','mat')


%% Perform some preliminary analysis

% discretize state space
m_min = 0;
m_max = 1;
m_num = 25;

% estimate state trajectory
[m_mod,m_red] = chainer_analyze_means(chain,fr,dr,m_min,m_max,m_num,z);

% estimate transition probabilities
[m_edges,p_mean,d_dist] = chainer_analyze_transitions(chain,fr,dr,m_min,m_max,m_num,true);

% estimate drift trajectory
[y_mean,y_std] = chainer_analyze_drift(chain,fr,dr,z);


