function opp_call = Amr_Call(step,So,K,r,T,sigma)
    dt = T/step;
    u = exp(sigma*sqrt(dt));
    d = 1/u;
    p = (exp(r*dt)-d)/(u-d);

    %Find how many slot needed in array
    size = (1/2)*(step+1)*(step+2);

    %Create array bin, payoff, opp_c (call option), and opp_p (put option)
    bin = zeros ([1 size]);
    payoff_c = zeros ([1 size]);
    opp_c = zeros ([1 size]);
    
    %Set bin and po index
    bin_index = 0;
    po_index = 0;

    %Find Stock Price at step 'step'
    for i = 0 : 1 : step
        for j = 0 : 1 : i
            bin_index = bin_index + 1;
            bin(bin_index) = So*(u^(i-j))*(d^(j));
        end
    end

    %Find first index of last column
    in = 1;
    for i = 1 : 1 : step
        in = in + i;
    end

    %Find payoff for american call and put for each node
    for i = 0 : 1 : step
        for j = 0 : 1 : i
            po_index = po_index + 1;
            payoff_c(po_index) = max(bin(po_index)-K,0);
        end
    end

    %Get all value for last column 
    for i = in : 1 : (in+step)
        opp_c(i) = payoff_c(i);
    end

    %Comparing process for american call and put
    for i = step : -1 : 1
        for j =  (in-1) : -1 : (in-i)
            opp_c(j) = exp(-r*dt)*((opp_c(j+i))*p + (opp_c(j+i+1))*(1-p));
            opp_c(j) = max(opp_c(j),payoff_c(j));
        end
        in = in - i;
    end
    
    %Assign value to variable opp_call
    opp_call = opp_c(1);
end