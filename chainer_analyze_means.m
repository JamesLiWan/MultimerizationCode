function [m_mod,m_red] = chainer_analyze_means(chain,fr,dr,m_min,m_max,m_num,z)
% This function uses the samples in chain and computes the sequence of emission means

% Input:
% fr, dr are used to determine burn-in and effective sample
% m_min, m_max, m_num are used to compute histograms of the posteriors
% x is the time series. If x==[], no output is displayed

% Output:
% m_mod
% m_red

%% collect samples
r_max = chain.r_max;
r_min = fix( fr*r_max );
r_ind = r_min:dr:r_max;

N = size(chain.s,2);

%% adjust ranges to avoid errors
F = cell2mat( chain.F(r_ind) );
M_min = min( F(:,1) );
M_max = max( F(:,1) );
clear F

adj = false;
if M_min < m_min
    m_min = M_min;
    adj = true;
end    
if M_max > m_max
    m_max = M_max;
    adj = true;
end    


%% bin parameter space
m_edges = linspace(m_min,m_max,m_num+1);

f_num = m_num;

%% find min class
if     f_num <= intmax('uint8')
    cla = 'uint8';
elseif f_num <= intmax('uint16')
    cla = 'uint16';
elseif f_num <= intmax('uint32')
    cla = 'uint32';
elseif f_num <= intmax('uint64')
    cla = 'uint64';
else
    error('too large!')
end

f = zeros( length(r_ind), N, cla );  % bin tag
clear cla

%% run over collected samples and transform wrt global grid
for i = 1:length(r_ind)
    r = r_ind(i);
    f_idx = discretize( chain.F{r}(:,1) , m_edges );
    f(i,:) = f_idx(chain.s(r,:));
end
clear i r m_idx s_idx f_idx comps

%%
m_centers = ( m_edges(1:end-1)+m_edges(2:end) )/2;

f_mod = mode(f);   % mode trajectory
m_mod = m_centers( f_mod );
m_red = sort( unique(m_mod) )';


%% demo

if ~isempty(z)
    
    figure

    col = 'k';
    if adj
        col = 'r';
    end
    
    % mode trajectory
    plot(1:N,z,'c-',...
         1:N,m_mod,'o-')
    xlim([0 N+1])
    ylim([m_min m_max])
    line(get(gca,'Xlim'),[1 1]'*m_edges,'color',col,'linestyle',':')
    box off
    xlabel('Time step (n)')
    ylabel('Emission mean \mu_n^*')
    title('Sequence of modes \mu_n^* of marginal posteriors P(\mu_n|\{x_n\}_n)','color',col)
    
end

