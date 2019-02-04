
disp('==============================');
disp('     BINOMIAL TREE MODEL');
disp('==============================');
time  = input('Input Time                : ');
sto_p = input('Input Initial Stock Price : ');
incf  = input('Input Increasing Factor   : ');
decf  = input('Input Decreasing Factor   : ');
str_p = input('Input Strike Price        : ');

disp('------------------------------');
disp('     EUROPEAN PUT OPTIONS');
disp('------------------------------');
for j=0:1:time
    fprintf('Time %g\n',j);
    for i=j:-1:0
        c=(sto_p)*(incf^(i))*(decf^(j-i));
        temp=(str_p)-(c);
        payoff=max(temp,0);
        fprintf('     Stock Price : %g\n',c);
        fprintf('     Payoff      : %g\n',payoff);
        disp(' ');
    end
end

disp('------------------------------');
disp('     EUROPEAN CALL OPTIONS');
disp('------------------------------');
for j=0:1:time
    fprintf('Time %g\n',j);
    for i=j:-1:0
        c=(sto_p)*(incf^(i))*(decf^(j-i));
        temp=c-(str_p);
        payoff=max(temp,0);
        fprintf('     Stock Price : %g\n',c);
        fprintf('     Payoff      : %g\n',payoff);
        disp(' ');
    end
end