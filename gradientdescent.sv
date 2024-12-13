import fixedpoint::*;
//using delta rule?? https://en.wikipedia.org/wiki/Delta_rule

module gradientdescent (input fixed_point_t target_output, 
                        input fixed_point_t actual_output, 
                        input fixed_point_t weighted_sum_inputs, 
                        input fixed_point_t input_val, 
                        input fixed_point_t learning_rate,
                        output fixed_point_t weight_delta);
 
    
    fixed_point_t int_output = subtract(target_output, actual_output);
    fixed_point_t int_inputs = multiply(weighted_sum_inputs, input_val);

    fixed_point_t relu_derivative;
    if(weighted_sum_inputs > 0){
        relu_derivative.integer_fixed = 8'sd1;
        relu_derivative.decimal_fixed = 8'sd0;
    }
    else{
        relu_derivative.integer_fixed = 8'sd0;
        relu_derivative.decimal_fixed = 8'sd-32;
    }

    fixed_point_t int_multiply_derivatives = multiply(relu_derivative int_output);

    fixed_point_t delta = multiply(int_multiply_derivatives, int_inputs);

    fixed_point_t weight_delta = multiply(delta, learning_rate);
endmodule