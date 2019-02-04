function results = Erp_Call(step,So,K,r,T,sigma)
    dt = T/step;
    u = exp(sigma*sqrt(dt));
    d = 1/u;
    p = (exp(r*dt)-d)/(u-d);
    
    temp = 0;
    for i = 0:1:step
        temp = temp + p^(step-i)*(1-p)^i*max(So*u^(step-i)*d^i-K,0)*nchoosek(step,i);
    end;
    results = exp(-step*r*dt)*temp;
end