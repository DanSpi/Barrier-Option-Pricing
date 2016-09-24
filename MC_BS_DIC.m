function [ Price ] = MC_BS_DIC( S, K,t, T, n, sigma, r, N, B )
%Computation of the MonteCarlo BS price of Down and In Call option
%
%Input:
%S Underlying stock price
%K Strice price
%t Actual time
%T Maturity time 
%n number of equally spaced time intervals
%sigma Standard deviation
%r Risk free rate
%N number of simulations
%B Barrier
%
%Output:
%Price of the option


S(1)=S; %Starting point GBM
dt=(T-t)/n; %Discrete time interval

Sample_Payoff=zeros(1,N); 
Payoff=zeros(1,N);
Lower_Bound=zeros(1,N);

root_dt=sqrt(dt);

%Sample paths generator via SDE
for j=1:N
    for i=2:n+1
        S(i)=S(i-1)+r*S(i-1)*dt+sigma*S(i-1)*root_dt*randn;    
    end
    Sample_Payoff(j)=S(n+1);
    Lower_Bound(j)=min(S);
end

%Down and In condition
for j=1:N 
    if Lower_Bound(j)<=B
        Payoff(j)=max(Sample_Payoff(j)-K,0);
    else
        Payoff(j)=0;
    end
    
Price=exp(-r*(T-t))*mean(Payoff);

end


end