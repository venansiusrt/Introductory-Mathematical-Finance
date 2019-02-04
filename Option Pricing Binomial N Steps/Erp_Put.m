function results = Erp_Put(step,So,K,r,T,sigma)
    dt = T/step;
    u = exp(sigma*sqrt(dt));
    d = 1/u;
    p = (exp(r*dt)-d)/(u-d);

    temp = 0;
    for i = 0:1:step
        temp = temp + p^(step-i)*(1-p)^i*max(K-So*u^(step-i)*d^i,0)*nchoosek(step,i);
    end;
    results = exp(-step*r*dt)*temp;
end