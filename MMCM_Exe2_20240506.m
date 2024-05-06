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

% Discrete increment of space
dx = Xs(2)-Xs(1);

% Array to represent the images of a function applied to the values of Xs
Fs = linspace(0,L,nL);
    for i = 1:nL
    
        Fs(i) = f(Xs(i));
        fprintf('%d \t', Fs(i))
    
    end 

fprintf('\n%i\n',length(Xs))




% ----- DOWNWIND METHOD -----



% (Time) Array representing the center of n intervals of lentgh T/nT
aux = linspace(0,T,nT+1);
Ts = linspace(0,T,nT);
    for i = 1:nT
    
        Ts(i) = (aux(i)+aux(i+1))/2;
    
    end 
fprintf('\n')

% Discrete increment of time
dt = Ts(2)-Ts(1); 

% Creating another auxiliar array, now of the same dimension as Fs, this
% will help us to go forward in time on each iteration
aux = linspace(0,L,nL);
    for i = 1:nL
    
        aux(i) = Fs(i);
    
    end

% implementation of the downwind method with constant c = 1
for j = 1:nT

    for i = 1:nL-1

        Fs(i) = aux(i) - (dt/dx)*(aux(i+1)-aux(i));

    end

    Fs(nL) = aux(nL) - (dt/dx)*(aux(1)-aux(nL)); %Final step on the iretation

end


figure(1);
plot(Xs, Fs);
title('Aproximation via "Downwind method" of te function $sin((2*k*pi*x)/L-t);$', 'interpreter', 'latex', 'FontSize', 14);





% ----- UPWIND METHOD -----

% Reset of variables
Fs = f(Xs);
aux = Fs;


% implementation of the upwind method with constant c = 1
for j = 1:nT

    for i = 2:nL

        Fs(i) = aux(i) - (dt/dx)*(aux(i)-aux(i-1));

    end

    Fs(1) = aux(1) - (dt/dx)*(aux(1)-aux(nL)); %Final step on the iretation

end


figure(2);
plot(Xs, Fs);
title('Aproximation via "Upwind method" of te function $sin((2*k*pi*x)/L-t);$', 'interpreter', 'latex', 'FontSize', 14);






% ----- CENTRAL METHOD -----

% Reset of variables
Fs = f(Xs);
aux = Fs;


% implementation of the central method with constant c = 1
for j = 1:nT

    for i = 2:nL-1

        Fs(i) = aux(i) - (dt/dx)*(aux(i+1)-aux(i-1));

    end

    %Final steps on the iretation
    Fs(1) = aux(1) - (dt/dx)*(aux(1)-aux(nL)); 

end


figure(2);
plot(Xs, Fs);
title('Aproximation via "Upwind method" of te function $sin((2*k*pi*x)/L-t);$', 'interpreter', 'latex', 'FontSize', 14);


