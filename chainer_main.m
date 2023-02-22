function chain = chainer_main( z, r_max, chain_init, opts, flag_sta, flag_vis )
% This function handles MCMC chains

% Calling syntaxes:
% (1) Init and expand
% chain = sampler_main(  z, r_max,         [], opts, flag_sta, flag_vis )
% (2) Just expand
% chain = sampler_main(  z, r_max, chain_init,   [], flag_sta, flag_vis )


if iscolumn(z)
    z = z';
end

N = length(z);
z = double(z);



%% Initialize chain
% if chain_init is empty initialize the chain from scratch
if isempty(chain_init)

    % init parameters
    chain.params = chainer_init_params(z,opts);

    % allocate some space
    chain.s = zeros(r_max,N,'uint8');
    chain.K =   nan(r_max,1);
    chain.B =  cell(r_max,1);
    chain.O =  cell(r_max,1);
    chain.P =  cell(r_max,1);
    chain.F =  cell(r_max,1);
    chain.h =   nan(r_max,1);
    chain.w =   nan(r_max,1);
    chain.v =   nan(r_max,1);
    chain.D =   nan(r_max,chain.params.M);
    chain.y =   nan(r_max,N);
    
    chain.r_max = r_max;
    chain.dr_sk = opts.dr_sk;    % saves when mod(r,dr_sk) == 1

    % init from scratch
    [ s_curr, K_curr, B_curr, O_curr, P_curr, F_curr,...
      h_curr, w_curr, v_curr, D_curr, y_curr, i_curr ] = ...
    sampler_init_sample( z, opts, chain.params );

    r = 1;
    chain.s(r,:) = s_curr;
    chain.K(r  ) = K_curr;
    chain.B{r  } = B_curr;
    chain.O{r  } = O_curr;
    chain.P{r  } = P_curr;
    chain.F{r  } = F_curr;
    chain.h(r  ) = h_curr;
    chain.w(r  ) = w_curr;
    chain.v(r  ) = v_curr;
    chain.D(r,:) = D_curr;
    chain.y(r,:) = y_curr;
    chain.i      = i_curr;



else % otherwhise expand existing chain

    % copy from input
    chain.params = chain_init.params;

    % allocate some space
    chain.s = zeros(r_max+chain_init.r_max,N,'uint8');
    chain.K =   nan(r_max+chain_init.r_max,1);
    chain.B =  cell(r_max+chain_init.r_max,1);
    chain.O =  cell(r_max+chain_init.r_max,1);
    chain.P =  cell(r_max+chain_init.r_max,1);
    chain.F =  cell(r_max+chain_init.r_max,1);
    chain.h =   nan(r_max+chain_init.r_max,1);
    chain.w =   nan(r_max+chain_init.r_max,1);
    chain.v =   nan(r_max+chain_init.r_max,1);
    chain.D =   nan(r_max+chain_init.r_max,chain_init.params.M);
    chain.y =   nan(r_max+chain_init.r_max,N);
    chain.i =  nan;

    % copy from input
    r = 1:chain_init.r_max;
    chain.s(r,:) = chain_init.s(r,:); 
    chain.K(r  ) = chain_init.K(r  );
    chain.B(r  ) = chain_init.B(r  );
    chain.O(r  ) = chain_init.O(r  );
    chain.P(r  ) = chain_init.P(r  );
    chain.F(r  ) = chain_init.F(r  );
    chain.h(r  ) = chain_init.h(r  );
    chain.w(r  ) = chain_init.w(r  );
    chain.v(r  ) = chain_init.v(r  );
    chain.D(r,:) = chain_init.D(r,:);
    chain.y(r,:) = chain_init.y(r,:);
    chain.i      = chain_init.i;

    chain.r_max = chain_init.r_max + r_max;
    chain.dr_sk = chain_init.dr_sk;

    r = r(end);
    s_curr = chain.s(r,:);
    K_curr = chain.K(r  );
    B_curr = chain.B{r  };
    O_curr = chain.O{r  };
    P_curr = chain.P{r  };
    F_curr = chain.F{r  };
    h_curr = chain.h(r  );
    w_curr = chain.w(r  );
    D_curr = chain.D(r,:);
    [y_curr, v_curr] = get_drift( chain.params.Dnodes, D_curr, N );
    i_curr = chain.i;

end


%%
if flag_vis
    G = chainer_visualize( [], r, chain, z );
end

%% Step the chain
while r < chain.r_max

    r_temp = 1;
    while r_temp<=chain.dr_sk
        [ s_curr, K_curr, B_curr, O_curr, P_curr, F_curr,...
          h_curr, w_curr, v_curr, D_curr, y_curr,i_curr ] = ...
        sampler_update( z, chain.params, ...
          s_curr, K_curr, B_curr, O_curr, P_curr, F_curr,...
          h_curr, w_curr, v_curr, D_curr, y_curr, i_curr );
          r_temp = r_temp + 1;
    end

    % Store sample
    r = r+1;
    chain.s(r,:) = s_curr;
    chain.K(r  ) = K_curr;
    chain.B{r  } = B_curr;
    chain.O{r  } = O_curr;
    chain.P{r  } = P_curr;
    chain.F{r  } = F_curr;
    chain.h(r  ) = h_curr;
    chain.w(r  ) = w_curr;
    chain.v(r  ) = v_curr;
    chain.D(r,:) = D_curr;
    chain.y(r,:) = y_curr;
    chain.i      = i_curr;

    % Show some demo
    if flag_vis
        chainer_visualize( G, r, chain, z );
    end


    if flag_sta
        % Print some progress report
        disp(['iter: i = ', num2str(i_curr),...
                 ' - r = ', num2str(r),...
                 ' - K = ', num2str(chain.K(r),'%2d'),...
             ' - occup = ', num2str(chain.F{r}(:,3)','%3.2f ' ) ])
    end

end
