clear
rng(34)

So = 100;    %the spot price of the stock
r = 0.05;    %the risk-free rate
q = 0.03;    %the dividend the stock pays
sigma = 0.3; %the volatility of the underlying
K = 120;    %the Strike price
T = 1;      %the Maturity in years
N = 10000;  %Number of paths

[call_price] = callMonteCarlo(So,r,q,K,T,sigma,N);
disp(call_price); %displays the monte-carlo estimation of the price

%% Black-Scholes formula
call_price_blackscholes= formulaBS(So,K,0,T,r,q,1,sigma);
disp(call_price_blackscholes); %displays the price from Black-Scholes