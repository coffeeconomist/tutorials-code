clear all
clc
rng(34)

% Parameters
numSteps = 20; % Number of steps
dt = 0.1; % Time step
mu = 0.1; % Drift
sigma = 0.15; % Volatility
S0 = 100; % Initial stock price
N = 25;

% Generate Brownian motion increments
dW = sqrt(dt) * randn(numSteps, N);

% Generate geometric Brownian motion path
t = linspace(0, numSteps*dt, numSteps+1);
S = S0 * exp(cumsum((mu - 0.5 * sigma^2) * dt + sigma * dW));
S = [(ones(1,N)*S0);S];

% Create a GIF file
filename = 'monte_carlo_simulation.gif';

figure;
xlim([0, numSteps*dt]); % Adjust according to your data range
ylim([0,250]); % Fix y-axis
xlabel('Time');
ylabel('Stock Price');
title('Monte-Carlo Simulation of a GBM');
hold on;

% Plot each trajectory and save frames
for j=1:N
    h = plot(t(1), S(1,j), 'r.');
    trail = plot(t(1), S(1,j), 'k');
    
    for i = 2:numSteps+1
        set(h, 'XData', t(i), 'YData', S(i,j));
        set(trail, 'XData', [get(trail, 'XData'), t(i)], 'YData', [get(trail, 'YData'), S(i,j)], 'Color', rand(1,3));
        pause(0.01); % Adjust the pause time as needed
        drawnow;
        
        % Capture the frame
        frame = getframe(gcf);
        im = frame2im(frame);
        [A,map] = rgb2ind(im,256);
        if i == 2 && j == 1
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.04);
        else
            imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.04);
        end
    end
end

hold off;
