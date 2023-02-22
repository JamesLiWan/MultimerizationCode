function [y_new, D_new, h_new, w_new, v_new] = sampler_update_trajectories(y_old, D_old, h_old, w_old, v_old, f, z, params)
% This function udpades together photon levels and drift
% it uses a Metropolis-Hastings step


N = length(z);

%% Get proposal spline
D_prop = mvnrnd( D_old, params.MwGs*ones(1,params.M) );

[y_prop, v_prop] = get_drift( params.Dnodes, D_prop, N );

log_a1 = 0.5*sum( f(2,:).*(  (f(1,:)+y_old-z  ).^2 - (f(1,:)+y_prop-z ).^2 ) );
log_a2 = 0.5*w_old*sum(  (h_old-D_old).^2 - (h_old-D_prop).^2 );
log_a3 = 0.5/params.Deps2*(  v_old^2 - v_prop^2 );
log_a  = log_a1 + log_a2 + log_a3;

%% Update spline

if exprnd(1) > -log_a
    D_new = D_prop;
    y_new = y_prop;
    v_new = v_prop;
else
    D_new = D_old;
    y_new = y_old;
    v_new = v_old;
end    

%%

h_new = ( sum(D_new)*w_old*params.Dh_s2 + params.Dh_mu )/( params.M*w_old*params.Dh_s2 + 1 );
h_new = h_new + sqrt( params.Dh_s2/( params.M*w_old*params.Dh_s2 + 1 ) )*randn;

w_new = gamrnd( params.Dw_a + 0.5*params.M, 1/( params.Dw_b + 0.5*sum( (D_new-h_new).^2 ) ) );


