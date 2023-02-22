function [y_mean,y_std] = chainer_analyze_drift(chain,fr,dr,z)

%% collect samples
r_max = chain.r_max;
r_min = fix( fr*r_max );
r_ind = r_min:dr:r_max;

N = size(chain.s,2);

y      = chain.y(r_ind,:);
y_mean = mean(y);
y_std  =  std(y);

%% demo

if ~isempty(z)
    
    figure

    h = plot(1:N,z,'c-',...
             1:N,z-y_mean','.-',...
             1:N,y_mean,'-',...
             1:N,y_mean+y_std,'--',...
             1:N,y_mean-y_std,'--');
    set(h(3),'color',get(h(2),'color'))
    set(h(5),'color',get(h(4),'color'))
    xlim([0 N+1])
    g = line([1 1]'*chain.params.Dnodes,get(gca,'Ylim'),'color','k','linestyle',':');
    legend([h(1) h(2) h(3) h(4) g(1)],'signal with drift','signal without drift','drift (mean)','drift (mean\pmstd)','nodes')
    box off
    xlabel('time (n)')
    ylabel('y_n^*')
    title('Sequence of means y^*_n of marginal posteriors P(y_n|z)')

end


