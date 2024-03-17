% Introduction to Montecarlo Simulations in Finance
clc;
clear;
rng(27);

So = 100;    %the spot price of the stock
r = 0.05;    %the risk-free rate
q = 0.03;    %the dividend the stock pays
sigma = 0.3; %the volatility of the underlying
K = 120;    %the Strike price
T = 1;      %the Maturity in years
N = 10000;  %Number of paths
N2 = 10^6;

[call_price_mc, delta_call] = callMonteCarlo(So,r,q,K,T,sigma,N);
disp(call_price_mc); %displays the monte-carlo estimation of the price

%% Black-Scholes formula
[call_price_bs]= formulaBS(So,K,0,T,r,q,1,sigma);
% disp(call_price_bs); %displays the price from Black-Scholes

%% error of the estimator
err = abs(call_price_mc -call_price_bs);
disp(err);
disp(delta_call);

%% Plot
[Vest1M,Acc1M,Err1M] = errorPlot(So,0,T,q,r,K,sigma,N2,1);

