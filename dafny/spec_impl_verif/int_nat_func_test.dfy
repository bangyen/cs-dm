include "int_nat_func_specs.dfy"

import opened func = functions

/*
Finally, here's a Main method written in 
imperative style. It applies the 
functions we developed above to arguments 
to see if each function produces the 
expected result for one argument value. 
*/
method Main()
{
    print "The value of id_int(3) is ", func.id_int(3), "\n";
    assert id_int(3) == 3;


    print "The value of square(3) is ", func.square(3), "\n";
    assert square(3) == 9;

    print "The value of inc(3) is ", func.inc(3), "\n";
    
    // write corresponding assertions

    print "The value of fact(5) is ", func.fact(5), "\n";

    print "The value of fib(40) is ", func.fib(40), "\n";

    print "The value of sum_squares(5) is ", func.sum_squares(5), "\n";

    print "The value of sum(5) is ", func.sumto(5), "\n";

    print "The value of add(4,5) is ", func.add(4,5), "\n";

    print "The value of exp(3,4) is ", func.exp(3,4), "\n";

    print "Ev 5 is ", func.ev(5), "\n";

    print "Double 10 is ", func.double(10), "\n";

    print "Starting computation of fib for large n\n";
    var n :=40;
    print "The value of fib(", n, ") is ", func.fib(n), "\n";
}

