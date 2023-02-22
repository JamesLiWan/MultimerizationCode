function params = chainer_init_params(z,opts)
% This function initializes chain parameters

N = length(z);

%% Concentrations

params.a = opts.a;
params.g = opts.g;

%% priors for the emission parameters

% params.Q = [ lambda, rho, beta, omega ];
params.Q = opts.Q;


%% Drift
params.M = opts.M;

params.Dnodes = linspace(1,N,params.M);

params.Dh_mu = 0;   % [L]
params.Dh_s2 = var(z);   % [L^2]

params.Dw_a = 1;    % [1]
params.Dw_b = var(z)*params.Dw_a;    % [L^2]

params.Deps2 = ( std(z)*( 1e2/N ) )^2; % [L^2]

params.MwGs = 0.0001*std(z);  % [L]  % adjust if necessary



%% other sampler's parameters

params.Brep = 25;
params.Frep = 25;

