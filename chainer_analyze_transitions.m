function [m_edges,p_mean,d_dist] = chainer_analyze_transitions(chain,fr,dr,m_min,m_max,m_num,demo_flag)
% This function uses the samples in chain and computes the transition
% probabilities and dwell times

% Input:
% fr, dr are used to determine burn-in and effective sample
% m_min, m_max, m_num are used to compute histograms of the posteriors
% demo_flag indicated if output will be displayed or not

% Output:
% m_edges
% p_mean
% d_dist

%
if isempty(m_min) && isempty(m_max)
    m_min = min(m_num);
    m_max = max(m_num);
end

%% collect samples
r_max = chain.r_max;
r_min = fix( fr*r_max );
r_ind = r_min:dr:r_max;

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

m_D_num = m_num;
m_A_num = m_num;

m_D_edges = linspace(m_min,m_max,m_D_num+1)';  % Departing
m_A_edges = linspace(m_min,m_max,m_A_num+1) ;  % Arriving

%% run over collected samples and transform wrt global grid
p = zeros( m_D_num, m_A_num, length(r_ind) );
d = zeros( m_D_num,          length(r_ind) ); % expected dwell time

for i = 1:length(r_ind)

    r = r_ind(i);
    
    f_D_idx = discretize( chain.F{r}(:,1) , m_D_edges );
    f_A_idx = discretize( chain.F{r}(:,1) , m_A_edges )';

    for jD = 1:chain.K(r)
        for iA = 1:chain.K(r)
            p( f_D_idx(jD),f_A_idx(iA), i ) = p( f_D_idx(jD),f_A_idx(iA), i ) + chain.P{r}(jD,iA)*chain.B{r}(jD)/sum( chain.B{r}( f_D_idx==f_D_idx(jD) ) );
        end
    end
    
    d(:,i) = -1./log( diag(p(:,:,i)) );
    
end
clear i r f_D_idx f_A_idx jD iA

%%
p_mean = mean(p,3);
m_edges = m_D_edges;

d_dist = [mean(d,2),std(d,[],2)];


%% demo

if demo_flag
    
    figure

    col = 'k';
    if adj
        col = 'r';
    end
    
    % mean transition matrix
    pcolor(m_A_edges,m_D_edges, [[p_mean,nan(m_D_num,1)];nan(1,m_A_num+1) ] );
    xlim([m_min m_max])
    ylim([m_min m_max])
    shading flat
    line(get(gca,'Xlim'),[1 1]'*m_D_edges','color',col,'linestyle',':')
    line([1 1]'*m_A_edges,get(gca,'Ylim'),'color',col,'linestyle',':')
    line([m_min m_max],[m_min m_max],'color',col,'linestyle',':')
    
    box off
    xlabel('Arriving \mu_{arr}')
    ylabel('Departing \mu_{dep}')
    title('Mean transition probs. \pi^*_{\mu_{dep}->\mu_{arr}} of marginal posterior P(\pi_{\mu_{dep}->\mu_{arr}}|\{x_n\}_n)','color',col)
    
    caxis([0 1])

    c = colorbar;
    ylabel(c,'Probability')
    
    

    

    figure

    
    m_centers = ( m_edges(1:end-1)+m_edges(2:end) )/2;

    bar( m_centers, d_dist(:,1) ,'facecolor','c')
    hold on
        errorbar(m_centers,d_dist(:,1),d_dist(:,2),'k.')
    hold off
    ylabel('Time steps (n)')
    xlabel('Emission mean \mu')
    box off

    line([1 1]'*m_edges',get(gca,'Ylim'),'color',col,'linestyle',':')

    title('Mean expected dwell times \Delta^*_{\mu} of marginal posterior P(\Delta_{\mu}|\{x_n\}_n)','color',col)
        
end


