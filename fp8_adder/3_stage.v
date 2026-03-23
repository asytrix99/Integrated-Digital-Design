module FP8_ADDER( 
CLK, 
RESETN, 
input_a, 
input_b, 
output_c 
); 
 
 
input CLK; 
input RESETN;           ////    reset disable 
 
input [7:0] input_a;    ////    fp8 operand 
input [7:0] input_b;    ////    fp8 operand 
 
output [7:0] output_c;  ////    fp8 output 
 
reg [7:0] operand_a;    ////    bigger operand 
reg [7:0] operand_b;    ////    smaller operand 
 
////////*       stage 1 (swap)  *//////// 
always @ (posedge CLK or negedge RESETN) begin 
//// fill in your code//// 
 
        if (!RESETN) begin 
                operand_a <= 8'b0; 
                operand_b <= 8'b0; 
        end else begin 
                if (input_a[6:3] >= input_b[6:3]) begin 
                        operand_a <= input_a; 
                        operand_b <= input_b; 
                end else begin 
                        operand_a <= input_b; 
                        operand_b <= input_a; 
                end 
        end 
 
end 
 
//// fill in the three equation below //// 
 
//// exp_diff is the substraction of two operand 
// obtain positive exp_diff 

wire [3:0] exp_diff = operand_a[6:3] - operand_b[6:3]; 
 
//// shifted_mas is the mantissa shifted by exp_diff 
// shifted by a positive exp diff 
wire [3:0] shifted_mas = {1'b1, operand_b[2:0]} >> exp_diff; 
 
//// mas_add_result is addition result of two mantissa 
// include extra bit to consider for potential carry out 
wire [4:0] mas_add_result = {1'b1, operand_a[2:0]} + shifted_mas; 
 
reg [7:0] output_s2;    //// register of second stage (basically the result of addition) 
 
////////*       stage 2         *//////// 
always @ (posedge CLK or negedge RESETN) begin 
        if (!RESETN) begin 
                output_s2 <=8'b0; 
        end else begin 
                if (mas_add_result[4] == 1) begin 
                        // consider for overflow, shift mantissa to right by 1 
                        output_s2 <= {operand_a[7], operand_a[6:3] + 4'd1, mas_add_result[3:1]}; 
                end else begin 
                        output_s2 <= {operand_a[7], operand_a[6:3], mas_add_result[2:0]}; 
                end 
        end 
end 
 
reg [7:0] sync_result; //// sychronized final result 
 
////////*       sync output (additional cycle for stability)    *//////// 
always @ (posedge CLK or negedge RESETN) begin 
        if (!RESETN) begin 
                sync_result <= 8'b0; 
        end else begin 
                sync_result <= output_s2; 
        end 
end 
 
assign output_c = sync_result; 
 
 
endmodule 