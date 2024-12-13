import fixedpoint::*;

module relu
    (input fixed_point_t sum_inputs,
     output fixed_point_t relu_result);

    fixed_point_t intermediate_data;

    fixed_point_t leaky_relu_scalar;
    leaky_relu_coeff.integer_fixed = 8'sd0;
    leaky_relu_coeff.decimal_fixed = 8'sd-32;

    if(sum_inputs < 0){
        //inputs * -1 * 0.1 (i couldnt figure out how to do -0.1)
        intermediate_data = multiply(sum_inputs, leaky_relu_scalar);
    }
    else{
        intermediate_data = sum_inputs;
    }
    
    assign relu_result = intermediate_data;
endmodule