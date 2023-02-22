function F_new = sampler_update_emission_model( F_old, x, s, K, params)
% This function initializes and updates the  distributions

if isempty(x)   % init
    
    F_new = nan(K,3);
    for j=1:K
        F_new(j,:) = [ params.Q(1) + sqrt( 1/params.Q(2) )*randn , gamrnd( params.Q(3)/2, 2/(params.Q(4)*params.Q(3)) ), nan];
    end

    
else % update
    
    N = length(x);
    
    F_new = nan(K,3);
    
    for j=1:K
        
        ind = s==j;
        num = sum(ind);
        
        for rep = 1:params.Frep
        
            % means
            F_new(j,1) = ( sum( x(ind) )*F_old(j,2) + params.Q(1)*params.Q(2) )/( num*F_old(j,2) + params.Q(2) );
            F_new(j,1) = F_new(j,1) + sqrt( 1/( num*F_old(j,2) + params.Q(2) ) )*randn;
        
            % press
            F_new(j,2) = gamrnd( (num+params.Q(3))/2, 2/(params.Q(4)*params.Q(3)+sum( ( x(ind)-F_new(j,1) ).^2 )) );
        
        end
        
        % occup
        F_new(j,3) = num/N;
        
    end
    
    
end

