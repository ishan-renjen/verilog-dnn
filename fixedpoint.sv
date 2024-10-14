package fixedpoint;
    typedef struct packed{
        logic signed [7:0] integer_fixed;
        logic signed [7:0] decimal_fixed;
    } fixed_point_t

    function fixed_point_t add(fixed_point_t a, fixed_point_t b);
        fixed_point_t result;
        result.integer_fixed = a.integer_fixed + b.integer_fixed;
        result.decimal_fixed = a.decimal_fixed + b.decimal_fixed;
        //decimal overflow
        if(result.decimal_fixed > 8'sd127){
            result.integer_fixed += 8'sd1;
            result.decimal_fixed -= 8'sd256;
        }
        //underflow cant happen for decimal
        //set overflow to 127, underflow to -128
        if(result.integer_fixed > 8'sd127){
            result.integer_fixed = 8'sd127;
        }
        else if(result.integer_fixed < 8'sd-128){
            result.integer_fixed = 8'sd-128;
        }
        return result;
    endfunction

    /******************Multiplication Calculation example
                1.25*2.5 = 3.125
                0000000101000000 
                0000001010000000
                ----------------
                0000000000000000
                0000000000000000|
                0000000000000000||
                0000000000000000|||
            0000000000000000||||
            0000000000000000|||||
            0000000000000000||||||
            0000000101000000|||||||
        0000000000000000||||||||
        0000000101000000|||||||||
        0000000000000000||||||||||
        0000000000000000|||||||||||
    0000000000000000||||||||||||
    0000000000000000|||||||||||||
    0000000000000000||||||||||||||
    0000000000000000|||||||||||||||
    --------------------------------
    00000000 00000011 00100000 00000000
    = 00000011.00100000                 
    ****************************************************/

    function fixed_point_t multiply(fixed_point_t a, fixed_point_t b);
        fixed_point_t result;

        logic signed a_total[15:0] = {a.integer_fixed, a.decimal_fixed};
        logic signed b_total[15:0] = {b.integer_fixed, b.decimal_fixed};

        logic signed[31:0] result_total = a_total * b_total;

        result.integer_fixed = result_total[23:16];
        result.decimal_fixed = result_total[15:8];

        //handle overflow
        if(result.decimal_fixed > 8'sd127){
            result.integer_fixed += 8'sd1;
            result.decimal_fixed -= 8'sd256;
        }
        //underflow cant happen for decimal
        //set overflow to 127, underflow to -128
        if(result.integer_fixed > 8'sd127){
            result.integer_fixed = 8'sd127;
        }
        else if(result.integer_fixed < 8'sd-128){
            result.integer_fixed = 8'sd-128;
        }
        return result;
    endfunction
endpackage