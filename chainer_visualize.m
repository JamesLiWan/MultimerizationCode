function G = chainer_visualize( G, r, chain, z )

N = length(z);
y = get_drift(chain.params.Dnodes,chain.D(r,:),N);
x = z-y;

if isempty(G)

    
    % show labels
    fl = false;

    figure

    
    % Set ranges
    K_lim = 15;
    y_lim = [min(z) max(z)]+[-0.25 +0.25];
    s_lim = [0  1.2*std(z)];
    
    
    % upper left
    subplot(4,5,[1 2 3 4])
    G.g1 = plot(1:chain.r_max,chain.K,'.-');
    if fl
        text(0.5,0.5,{'G.g1'},'units','normalized','FontWeight','Bold','FontSize',20)
    end
    xlim([0 chain.r_max+1])
    ylim([0 max(K_lim,min(2*K_lim,max(get(gca,'Ylim'))))])
    set(gca,'XAxisLocation','top')
    grid on
    ylabel('K')
    xlabel('Sample (r)')
    box off
    
    
    % lower left
    subplot(4,5,[6 7 8 9  11 12 13 14  16 17 18 19])
    G.g2 = plot(1:N,z,'c-',...
                1:N,x,'-',...
                1:N,y,'k--',...
                1:N,chain.F{r}(chain.s(r,:)),'.-');
    if fl
        text(0.5,0.5,{'G.g2'},'units','normalized','FontWeight','Bold','FontSize',20)
    end
    grid on
    ylabel('Signals')
    xlabel('Time (n)')
    ylim( y_lim )
    xlim([0 N+1])
    line([1;1]*chain.params.Dnodes,get(gca,'Ylim'),'color','k','linestyle',':')
    line(get(gca,'Xlim'),0*[1 1],'color','k','linestyle',':')
    legend('z','y','x','\mu','location','NW')
    legend boxoff
    box off
   
    
    % lower right
    subplot(4,5,[10 15 20])
    y_temp = linspace(y_lim(1),y_lim(end),250);
    x_temp = 0*y_temp;
    for k = 1:chain.K(r)
        x_temp = x_temp + chain.F{r}(k,3)*sqrt(0.5*chain.F{r}(k,2)/pi)*exp( -0.5*chain.F{r}(k,2)*(y_temp-chain.F{r}(k,1)).^2 );
    end
    G.h1(1) = histogram(z,linspace(y_lim(1),y_lim(2),50),'facecolor',get(G.g2(1),'color'),'orientation','horizontal','normalization','pdf');
    hold on
    G.h1(2) = histogram(x,linspace(y_lim(1),y_lim(2),50),'facecolor',get(G.g2(2),'color'),'orientation','horizontal','normalization','pdf');
    hold off
    G.g3 = line( x_temp, y_temp );
    ylim([y_temp(1) y_temp(end)])
    xlim(get(gca,'Xlim').*[1 1.2])
    G.g5(1) = line(sqrt(0.5/pi/chain.params.Deps2)*exp( -0.5/chain.params.Deps2*y_temp.^2 ),y_temp,'color',get(G.g2(3),'color'));
    G.g5(2) = line(get(gca,'XLim'),chain.v(r)*[1 1],'color',get(G.g2(3),'color'));
    G.g5(3) = line(sqrt(0.5*chain.w(r)/pi)*exp( -0.5*chain.w(r)*(y_temp-chain.h(r)).^2 )   ,y_temp,'color',get(G.g2(3),'color'),'linestyle',get(G.g2(3),'linestyle'));
    G.g6    = line(nan+repmat(y_temp',1,50),repmat(y_temp',1,50),'color',get(G.g2(4),'color'));
    G.t1    = text(0.20,0.05,{'acc rat = ',[num2str(100*sum(diff(chain.v(1:r))~=0)/(r-1),'%5.2f'),' %']},'units','normalized');
    for k = 1:chain.K(r)
        set( G.g6(k),'Xdata',1/chain.K(r)*sqrt(0.5*chain.F{r}(k,2)/pi)*exp( -0.5*chain.F{r}(k,2)*(get(G.g6(k),'Ydata')-chain.F{r}(k,1)).^2 ));
    end
    if fl
        text(0.5,0.5,{'G.h1','G.g3','G.g5','G.g6','G.t1'},'units','normalized','FontWeight','Bold','FontSize',20)
    end
    set(gca,'XTickLabel',[],'YTickLabel',[])
    box off
    
    
    % upper right
    subplot(4,5,5)
    m_temp = linspace(y_lim(1),y_lim(2));
    s_temp = linspace(s_lim(1),s_lim(2));
    m_pdf = normpdf(m_temp,chain.params.Q(1),sqrt(1/chain.params.Q(2)));
    s_pdf = max(0,2./s_temp.^3).*gampdf( 1./s_temp.^2, chain.params.Q(3)/2, 2/(chain.params.Q(4)*chain.params.Q(3)) );
    line(s_temp,y_lim(2)-0.25*(y_lim(2)-y_lim(1))*s_pdf/max(s_pdf),'linestyle','-','color','c')
    line(s_lim(2)-0.25*(s_lim(2)-s_lim(1))*m_pdf/max(m_pdf),m_temp,'linestyle','-','color','c')
    G.g4(1) = line( 1./sqrt(chain.F{r}(:,2)), chain.F{r}(:,1),'marker','o','linestyle','none','color',get(G.g2(4),'color'));
    G.g4(2) = line( 1./sqrt(chain.F{r}(chain.s(r,1),2)), chain.F{r}(chain.s(r,1),1),'marker','.','linestyle','none','color',get(G.g2(4),'color'));
    if fl
        text(0.5,0.5,{'G.g4'},'units','normalized','FontWeight','Bold','FontSize',20)
    end
    ylim(y_lim)
    xlim(s_lim)
    line(get(gca,'xlim'), mean(z)*[1 1],'color','c','linestyle','--')
    line(  std(z)*[1 1],get(gca,'ylim'),'color','c','linestyle','--')
    set(gca,'XAxisLocation','top','YAxisLocation','right') 
    ylabel('\mu')
    xlabel('\sigma')


    

    

    
    
    
    
    
else
    
    
    set(G.g1(1),'YData',chain.K);

    set(G.g2(2),'YData',x)
    set(G.g2(3),'YData',y)
    set(G.g2(4),'YData',chain.F{r}(chain.s(r,:),1))
    
    y_temp = get(G.g3,'Ydata');
    x_temp = 0*y_temp;
    for k = 1:chain.K(r)
        x_temp = x_temp + chain.F{r}(k,3)*sqrt(0.5*chain.F{r}(k,2)/pi)*exp( -0.5*chain.F{r}(k,2)*(y_temp-chain.F{r}(k,1)).^2 );
    end
    set(G.g3,'XData',x_temp)
    
    set(G.g4(1),'XData', 1./sqrt(chain.F{r}(:,2)), 'YData', chain.F{r}(:,1));
    set(G.g4(2),'XData',1./sqrt(chain.F{r}(chain.s(r,1),2)),'YData',chain.F{r}(chain.s(r,1),1));
        
    set(G.g5(2),'YData',chain.v(r)*[1 1]);
    set(G.g5(3),'XData',sqrt(0.5*chain.w(r)/pi)*exp( -0.5*chain.w(r)*(y_temp-chain.h(r)).^2 ));

    for k = 1:chain.K(r)
        set( G.g6(k),'Xdata',1/chain.K(r)*sqrt(0.5*chain.F{r}(k,2)/pi)*exp( -0.5*chain.F{r}(k,2)*(get(G.g6(k),'Ydata')-chain.F{r}(k,1)).^2 ));
    end
    for k = chain.K(r)+1:length(G.g6)
        set( G.g6(k),'Xdata',nan+get(G.g6(k),'Ydata') );
    end
    
    if ~isempty(G.h1(2))
        set(G.h1(2),'Data',x)
    end
    
    set(G.t1,'string',{'acc rat = ',[num2str(100*sum(diff(chain.v(1:r))~=0)/(r-1),'%5.2f'),' %']});

    
end

drawnow
