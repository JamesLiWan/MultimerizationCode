function [ s_new, K_new, B_new, O_new, P_new, F_new, h_new, w_new, v_new, D_new, y_new, i_new ] = ...
    sampler_update( z, params, ...
           s_old, K_old, B_old, O_old, P_old, F_old, h_old, w_old, v_old, D_old, y_old, i_old )
% this function performs one MCMC step

%%
N = length(z);

x_old = z-y_old;

flag = true;
while flag
    
    % update slicer
    u_new = sampler_update_slicer(s_old, O_old, P_old);

    % expand statespace
    [K_old_ext, B_old_ext, O_old_ext, P_old_ext, F_old_ext] = ...
        sampler_stsp_expand( u_new, K_old, B_old, O_old, P_old, F_old, params);
    
    % filter forward
    A_forw_new = sampler_update_forward( u_new, x_old,...
        K_old_ext, O_old_ext, P_old_ext, F_old_ext );
    

    test = sum( A_forw_new(:,N) );
    if ~isnan(test) && test>0   % check for over/under-flows
        flag = false;
         
        % sample new state trajectory (with extra states)
        s_new_ext = sampler_update_backward( u_new, A_forw_new, P_old_ext );
        
        % compress statespace
        [s_new, K_new, B_old_red, F_old_red] = sampler_stsp_compress(s_new_ext, K_old_ext, B_old_ext, F_old_ext);

        % update emission distributions
        F_new = sampler_update_emission_model( F_old_red, x_old, s_new, K_new, params);
        
        % sample base
        [C_new, B_new] = sampler_update_base( s_new, K_new, B_old_red, params );
                
        % sample transitions
        [O_new, P_new] = sampler_update_transitions( K_new, C_new, B_new, params );
        

        % sample new trajectories
        [y_new, D_new, h_new, w_new, v_new] = sampler_update_trajectories(y_old, D_old, h_old, w_old, v_old, F_new(s_new,1:2)', z, params);

        
        % -------
        i_new = i_old + 1;
        
    else
         disp(['--- backward sampling failed --- test = ', num2str(test), ' --- K_old_ext = ',num2str(K_old_ext)] )
    end
     
end
