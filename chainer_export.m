function chainer_export(chain,fr,dr,file_name,frmt)
% This function exports a chain in mat format
% Burn-in samples are excluded

%% collect samples
r_max = chain.r_max;
r_min = fix( fr*r_max );
r_ind = r_min:dr:r_max;

%% save samples

if strcmp(frmt,'mat')
    % export mat
    
    params = chain.params;
         s = chain.s(r_ind,:);
         K = chain.K(r_ind);
         B = chain.B(r_ind);
         O = chain.O(r_ind);
         P = chain.P(r_ind);
         F = chain.F(r_ind);
         h = chain.h(r_ind);
         w = chain.w(r_ind);
         v = chain.v(r_ind);
         D = chain.D(r_ind,:);
         y = chain.y(r_ind,:);
         
         
    save([file_name,'.mat'],'params','s','K','B','O','P','F','h','w','v','D','y')
    disp([file_name,'.mat',' --- Exported'])
        
else
    disp('Unknown export format!')
end
