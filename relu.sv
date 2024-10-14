import fixedpoint::*;

module relu
    (input fixed_point_t sum_inputs,
     output fixed_point_t relu_result);

    fixed_point_t intermediate_data;

    fixed_point_t leaky_relu_coeff = {11111110, 00011000}

    if(sum_inputs < 0){
        //inputs * -1
        intermediate_data = multiply(sum_inputs, leaky_relu_coeff);
    }
    else{
        intermediate_data = sum_inputs;
    }
    
    assign relu_result = intermediate_data;
endmodule