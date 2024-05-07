clc;

L = 1; % For space interval [0,L]
T = 5; % For time interval [0,T]
nL = 1000; % For nL spaces in array Xs
nT = 100; %For nT spaces in array Ts
k = 5;  % Some integer k
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
    end 

% Discrete increment of space
dx = Xs(2)-Xs(1);

% Array to represent the images of a function applied to the values of Xs
Fs = f(Xs);


% ----- DOWNWIND METHOD -----

% (Time) Array representing the center of n intervals of length T/nT
aux = linspace(0,T,nT+1);
Ts = zeros(1,nT);
    for i = 1:nT
        Ts(i) = (aux(i)+aux(i+1))/2;
    end 

% Discrete increment of time
dt = Ts(2)-Ts(1); 

% Creating another auxiliar array, now of the same dimension as Fs, this
% will help us to go forward in time on each iteration
aux = zeros(1,nL);
    for i = 1:nL
        aux(i) = Fs(i);
    end

% implementation of the downwind method with constant c = 1
for j = 1:nT
    for i = 1:nL-1
        Fs(i) = aux(i) - (dt/dx)*(aux(i+1)-aux(i));
    end

    Fs(nL) = Fs(1); % periodic boundary condition
end

figure(1);
plot(Xs, Fs);
title('Aproximation via "Downwind method" of $\sin((2k\pi x)/L-t), \Delta t = 10^{-2}, \Delta x = 10^{-3}$', 'interpreter', 'latex', 'FontSize', 14);


% ----- UPWIND METHOD -----

% Reset of variables
Fs = f(Xs);
aux = Fs;

% implementation of the upwind method with constant c = 1
for j = 1:nT
    for i = 2:nL
        Fs(i) = aux(i) - (dt/dx)*(aux(i)-aux(i-1));
    end

    Fs(1) = Fs(nL); % periodic boundary condition
end


figure(2);
plot(Xs, Fs);
title('Aproximation via "Upwind method" of $\sin((2k\pi x)/L-t), \Delta t = 10^{-2}, \Delta x = 10^{-3}$', 'interpreter', 'latex', 'FontSize', 14);


% ----- CENTRAL METHOD -----

% Reset of variables
Fs = f(Xs);
aux = Fs;


% implementation of the central method with constant c = 1
for j = 1:nT
    for i = 2:nL-1
        Fs(i) = aux(i) - (dt/(2*dx))*(aux(i+1)-aux(i-1));
    end

    % add ghost points for boundary using periodicity phi(t,x+L)=phi(t,x)
    gh1 = Fs(end-1);
    gh2 = Fs(2);
    Fs(1) = aux(1) - (dt/(2*dx))*(aux(2)-gh1);
    Fs(nL) = aux(nL) - (dt/(2*dx))*(gh2-aux(nL-1));
end

figure(3);
plot(Xs, Fs);
title('Aproximation via "Central method" of $\sin((2k\pi x)/L-t), \Delta t = 10^{-2}, \Delta x = 10^{-3}$', 'interpreter', 'latex', 'FontSize', 14);

% upwind for different values of ∆x and ∆t
fig_count = 4;
for nL = [100, 1000, 10000]
    aux = linspace(0,L,nL+1);
    Xs = linspace(0,L,nL);
    for i = 1:nL
        Xs(i) = (aux(i)+aux(i+1))/2;
    end 
    dx = Xs(2) - Xs(1);

    for nT = [100, 1000, 10000]

        Fs = f(Xs);
        aux = Fs;
        dt = T/nT;
        % implementation of the upwind method with constant c = 1
        for j = 1:nT
            for i = 2:nL
                Fs(i) = aux(i) - (dt/dx)*(aux(i)-aux(i-1));
            end
        
            Fs(1) = Fs(nL); % periodic boundary condition
        end

        figure(fig_count)
        plot(Xs, Fs);
        fig_count = fig_count + 1;
        title(['∆t = ', num2str(dt), ' ∆x = ', num2str(dx)])
    end
end
