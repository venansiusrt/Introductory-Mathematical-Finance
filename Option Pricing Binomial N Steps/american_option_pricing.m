disp('AMERICAN OPTION');
t = input('Input step    : ');
s = input('Input stock   : ');
K = input('Strike Price  : ');
u = input('Increasing Fc.: ');
d = input('Decreasing Fc.: ');
r = input('Interest rate : ');

%Find how many slot needed in array
size = (1/2)*(t+1)*(t+2);

%Create array bin, payoff, opp_c (call option), and opp_p (put option)
bin = zeros ([1 size]);
payoff_c = zeros ([1 size]);
payoff_p = zeros ([1 size]);
opp_c = zeros ([1 size]);
opp_p = zeros ([1 size]);

%Set bin and po index
bin_index = 0;
po_index = 0;

%Find Stock Price at time t
for i = 0 : 1 : t
    for j = 0 : 1 : i
        bin_index = bin_index + 1;
        bin(bin_index) = s*(u^(i-j))*(d^(j));
    end
end

%Find p
p = (exp(r)-d)/(u-d);

%Find payoff for american call and put for each node
for i = 0 : 1 : t
    for j = 0 : 1 : i
        po_index = po_index + 1;
        payoff_c(po_index) = max(bin(po_index)-K,0);
        payoff_p(po_index) = max(K-bin(po_index),0);
    end
end

%Find first index of last column
in = 1;
for i = 1 : 1 : t
    in = in + i;
end

%Get all value for last column 
for i = in : 1 : (in+t)
    opp_c(i) = payoff_c(i);
    opp_p(i) = payoff_p(i);
end

%Comparing process for american call and put
for i = t : -1 : 1
    for j =  (in-1) : -1 : (in-i)
        opp_c(j) = exp(-r)*((opp_c(j+i))*p + (opp_c(j+i+1))*(1-p));
        opp_c(j) = max(opp_c(j),payoff_c(j));
        opp_p(j) = exp(-r)*((opp_p(j+i))*p + (opp_p(j+i+1))*(1-p));
        opp_p(j) = max(opp_p(j),payoff_p(j));
    end
    in = in - i;
end

%Show Option Price
disp(opp_c);
disp(opp_p);