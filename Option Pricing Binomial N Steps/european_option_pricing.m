clear; clc;

Time = input('Steps             : ');
MD   = input('Maturity Date     : ');
r    = 0.04;%input('Interest Rate     : ');
u    = 1.0696;%input('Increasing Factor : ');
d    = 1/0.0696;%input('Decreasing Factor : ');
So   = 40;%input('Stock Price       : ');
K    = 40;%input('Strike Price      : ');

dt   = MD/Time;

p = (exp(r*dt)-d)/(u-d);
call = 0;
put = 0;

for i = 0:1:Time
    call = call + p^(Time-i)*(1-p)^i*max(So*u^(Time-i)*d^i-K,0)*nchoosek(Time,i);
    put = put + p^(Time-i)*(1-p)^i*max(K-So*u^(Time-i)*d^i,0)*nchoosek(Time,i);
end
fprintf('Call %g\n',exp(-1*Time*r*dt)*call)
fprintf('Put  %g\n',exp(-1*Time*r*dt)*put)

