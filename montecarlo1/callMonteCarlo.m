function [call_estimate] = callMonteCarlo(So,r,q,K,T,sigma,N)

sum = 0; %acumulador

for i =1:N
    ST = So*exp((r-q -(sigma^2)/2 )*T + (sigma*sqrt(T)*randn())); 
    CT = max(ST-K,0); %we calculate the payoff
    YT = CT/exp(r*T); %we discount the payoff
    sum = sum + YT;
end
call_estimate = sum/N;
end