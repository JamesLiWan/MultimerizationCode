function [s_traj, K_scal, B_stsp, O_stsp, P_stsp, F_stsp,...
          h_scal, w_scal, v_scal, D_drif, y_traj, i ] = sampler_init_sample( z, opts, params )
% This function initializes a MCMC chain

i = 0;

s_traj = discretize(z,linspace(min(z),max(z),opts.K_init+1));

K_scal = max(s_traj);
B_stsp = dirrnd( [ones(1,K_scal),params.g] );

P_stsp = repmat(params.a*B_stsp,K_scal,1) + eye(K_scal,K_scal+1);
for j=1:K_scal
    P_stsp(j,:) = dirrnd( P_stsp(j,:) );
end

O_stsp = ones(1,K_scal+1)/(K_scal+1);

F_stsp = sampler_update_emission_model( [], [], [], K_scal, params);


h_scal = params.Dh_mu + sqrt( params.Dh_s2 )*randn;
w_scal = gamrnd( params.Dw_a, 1/params.Dw_b );
D_drif = zeros(1,params.M);
[y_traj,v_scal] = get_drift( params.Dnodes, D_drif, length(z) );

[y_traj, D_drif, h_scal, w_scal, v_scal] = sampler_update_trajectories(y_traj, D_drif, h_scal, w_scal, v_scal, F_stsp(s_traj,1:2)', z, params);

