function [y,v] = get_drift( Dnodes, D, N )

y = spline( Dnodes, D, 1:N );

v = mean(y);
