module FP8_ADDER( 
CLK, 
RESETN, 
input_a, 
input_b, 
output_c 
21 
); 
 
 
input CLK; 
input RESETN;     ////  reset disable 
 
input [7:0] input_a;   ////  fp8 operand 
input [7:0] input_b;  ////  fp8 operand 
 
output [7:0] output_c;  ////  fp8 output 
 
reg [7:0] operand_a;  ////  bigger operand 
reg [7:0] operand_b;  ////  smaller operand 
 
////////*  stage 1 (swap)  *//////// 
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
 
reg [3:0] exp_diff_reg; 
reg [3:0] shifted_mas_reg; 
reg [7:0] operand_a_s2; 
 
////////*  stage 2 (exp_diff + shifted_mas)    *//////// 
// convert exp_diff and shifted_mas operations from combinational to sequential 
always @ (posedge CLK or negedge RESETN) begin 
  if (!RESETN) begin 
    exp_diff_reg <= 4'b0; 
    shifted_mas_reg <= 4'b0; 
    operand_a_s2 <= 8'b0; 
  end else begin 
    exp_diff_reg <= operand_a[6:3] - operand_b[6:3]; 
    shifted_mas_reg <= {1'b1, operand_b[2:0]} >> (operand_a[6:3] - operand_b[6:3]); 
    operand_a_s2 <= operand_a; 
  end 
end 
 
22 
//// mas_add_result is addition result of two mantissa 
// include extra bit to consider for potential carry out 
wire [4:0] mas_add_result = {1'b1, operand_a_s2[2:0]} + shifted_mas_reg; 
 
reg [7:0] output_s2;   //// register of second stage (basically the result of addition) 
 
////////*  stage 3 (output_s2)   *//////// 
always @ (posedge CLK or negedge RESETN) begin 
  if (!RESETN) begin 
    output_s2 <=8'b0; 
  end else begin 
    if (mas_add_result[4] == 1) begin 
      // consider for overflow, shift mantissa to right by 1 
      output_s2 <= {operand_a_s2[7], operand_a_s2[6:3] + 4'd1, mas_add_result[3:1]}; 
    end else begin 
      output_s2 <= {operand_a_s2[7], operand_a_s2[6:3], mas_add_result[2:0]}; 
    end 
  end 
end 
 
reg [7:0] sync_result; //// sychronized final result 
 
////////*  sync output (additional cycle for stability)  *//////// 
always @ (posedge CLK or negedge RESETN) begin 
  if (!RESETN) begin 
    sync_result <= 8'b0; 
  end else begin 
    sync_result <= output_s2; 
  end 
end 
 
assign output_c = sync_result; 
 
 
endmodule