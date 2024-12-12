import fixedpoint::*;
//using delta rule?? https://en.wikipedia.org/wiki/Delta_rule

module gradientdescent (input fixed_point_t target_output, 
                        input fixed_point_t actual_output, 
                        input fixed_point_t weighted_sum_inputs, 
                        input fixed_point_t input_val, 
                        input fixed_point_t learning_rate,
                        output fixed_point_t weight_delta);
 
endmodule