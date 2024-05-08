clc;

L = 10; % For space interval [0,L]
T = 30; % For time interval [0,T]
nL = 50; % For nL spaces in array Xs
nT = 10; %For nT spaces in array Xs
k = 15;  % Some integer k
w = -15; % Some integer w

% Our functions
f = @(x) sin((2*k*pi*x)/L);
g = @(x,t) sin((2*k*pi*x)/L-w*t);

% 1 DIMENSION

% (Space) Array representing the center of n intervals of lentgh L/nL
aux = linspace(0,L,nL+1);
Xs = linspace(0,L,nL);
    for i = 1:nL
    
        Xs(i) = (aux(i)+aux(i+1))/2;
        fprintf('%d \t', Xs(i))
    
    end 
fprintf('\n')

% Array to represent the images of a function applied to the values of Xs
Fs = linspace(0,L,nL);
    for i = 1:nL
    
        Fs(i) = f(Xs(i));
        fprintf('%d \t', Fs(i))
    
    end 

fprintf('\n%i\n',length(Xs))

% 2 DIMENSIONS

% (Time) Array representing the center of n intervals of lentgh T/nT
aux = linspace(0,T,nT+1);
Ts = linspace(0,T,nT);
    for i = 1:nT
    
        Ts(i) = (aux(i)+aux(i+1))/2;
        fprintf('%d \t', Ts(i))
    
    end 
fprintf('\n')

[X,T] = meshgrid(Xs, Ts);
Z = g(X,T);

figure(1);
plot(Xs, Fs);
title('$f(x) = x^2 \sin(\pi x) + \cos(\pi x)/x$, n=10', 'interpreter', 'latex', 'FontSize', 14);

figure(2);
surf(X, T, Z);
title('$g(x,y) = \cos(xy) \sin(\pi x)$, n = 10', 'interpreter', 'latex', 'FontSize', 14);


