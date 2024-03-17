function [call_estimate, delta] = callMonteCarlo(So,r,q,K,T,sigma,N)
tic
sum = 0; %accumulador
sum2 = 0;%accumulator of squared payoffs

for i =1:N
    ST = So*exp((r-q -(sigma^2)/2 )*T + (sigma*sqrt(T)*randn())); 
    CT = max(ST-K,0); %we calculate the payoff
    YT = CT/exp(r*T); %we discount the payoff
    sum = sum + YT;
    sum2 = sum2 + YT^2;
end
call_estimate = sum/N;     %Price estimator
var = sum2/N - (sum/N)^2;  %variance of the estimator
delta = sqrt(var)/sqrt(N); %measure of accuracy
toc
end