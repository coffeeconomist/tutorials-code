function [o] = formulaBS(So,K,t,T,r,q,epsilon,sigma)

d1 = (log(So/K)+(r-q)*(T-t) )/(sigma*sqrt(T-t)) + (sigma*sqrt(T-t)/2);
d2 = d1 - sigma*sqrt(T-t);
Vo = epsilon*So*exp(-q*(T-t))*normcdf(epsilon*d1) -epsilon*K*exp(-r*(T-t))*normcdf(epsilon*d2);
o = Vo;

end