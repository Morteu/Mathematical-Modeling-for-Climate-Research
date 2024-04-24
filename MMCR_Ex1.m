clc;

f = @(x) x.^2.*sin(x*pi) + cos(x*pi)/x;
g = @(x,y) cos(x.*y) .* sin(x*pi);

Xs = linspace(0,10,10);
Ts = linspace(0,1,10);
refined_Xs = linspace(0,10,100);
refined_Ts = linspace(0,1,100);

figure(1);
plot(Xs, f(Xs));
title('$f(x) = x^2 \sin(\pi x) + \cos(\pi x)/x$, n=10', 'interpreter', 'latex', 'FontSize', 14);

figure(2);
plot(refined_Xs, f(refined_Xs));
title('$f(x) = x^2 \sin(\pi x) + \cos(\pi x)/x$, n=100', 'interpreter', 'latex', 'FontSize', 14);

[X,T] = meshgrid(Xs, Ts);
Z = g(X,T);

figure(3);
surf(X, T, Z);
title('$g(x,y) = \cos(xy) \sin(\pi x)$, n = 10', 'interpreter', 'latex', 'FontSize', 14);

[X,T] = meshgrid(refined_Xs, refined_Ts);
Z = g(X,T);

figure(4);
surf(X, T, Z);
title('$g(x,y) = \cos(xy) \sin(\pi x)$, n = 100', 'interpreter', 'latex', 'FontSize', 14);