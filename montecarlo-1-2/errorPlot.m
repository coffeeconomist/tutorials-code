function [Vestimate, DeltaV, ErrorV] = errorPlot(InitPrice, InitTime, TerminalTime, q, r, K, Sigma, Paths, epsilon)
    t = InitTime;
    T = TerminalTime;
    So = InitPrice;
    N = Paths;
    sigma = Sigma;
    VN = 0;
    Km = 0;
    Km2 = 0;

    X1 = 1:N;
    X2 = zeros(1, N);
    X3 = zeros(1, N);

    Vo = formulaBS(So, K, t, T, r, q, epsilon, sigma);

    for i = 1:N
        S = So * exp((r - q - (sigma^2) / 2) * (T - t) + (sigma * sqrt(T - t) * randn()));
        V = max(epsilon * (S - K), 0);
        Y = V / exp(r * (T - t));
        VN = VN + V;
        Km = Km + Y;
        Km2 = Km2 + Y^2;
        Var = Km2 / i - (Km / i)^2;
        Yest = Km / i;
        X2(i) = sqrt(Var) / sqrt(i);
        X3(i) = abs(Yest - Vo);
    end

    Vestimate = (VN / N) / exp(r * (T - t));
    DeltaV = sqrt(Var) / sqrt(N);
    ErrorV = abs(Vestimate - Vo);

    e_plus_acc = X3 + X2;
    e_minus_acc = X3 - X2;

    x = X1(100:N);
    e = X3(100:N);
    e1 = e_plus_acc(100:N);
    e2 = e_minus_acc(100:N);

    % Create the figure
    figure;
    % Animation loop
    i = 1;
    while i < numel(x)
        % Update the plot
        semilogx(x(1:i), e(1:i), 'r', 'LineWidth', 1);
        title('Estimation Error');
        xlabel('No. of simulations');
        ylabel('Error magnitude');
        hold on;
        semilogx(x(1:i), e1(1:i), 'b');
        semilogx(x(1:i), e2(1:i), 'b');
        legend('Error','Error+Acc','Error-Acc','Location','northwest')
        xlim([10^2, 10^6]); % Set x-axis limits
        ylim([-1.5, 3]);   % Set y-axis limits
        
        % Save each frame of the animation as a GIF
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind, cm] = rgb2ind(im, 256);
        if i == 1
            imwrite(imind, cm, 'mc-error.gif', 'gif', 'Loopcount', inf, 'DelayTime', 0.1);
        else
            imwrite(imind, cm, 'mc-error.gif', 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
        end
        
        % Increment the index based on the current iteration count
        if i < 10
            i = i + 5;
        elseif i < 100
            i = i + 10;
        elseif i < 1000
            i = i + 50;
        elseif i < 5000
            i = i + 500;
        elseif i < 100000
            i = i + 5000;
        else
            i = i + 100000;
        end
        hold off;
    end
end