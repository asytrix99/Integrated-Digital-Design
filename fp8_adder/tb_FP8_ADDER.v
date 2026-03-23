////	testbench is where your test the design by mimic the signal from PCB	////
`timescale 1ns/10ps

module tb_FP8_ADDER();

parameter period = 2;
parameter num_of_case = 256;
integer i;
integer j;
integer num_of_error;

//// do touch below ////
reg [0:0]		clk;
reg [0:0] 		cs;
reg [0:0]		we;
reg [7:0]		addr;
reg	[127:0]	 	din;
wire[127:0]	 	dout;


MockSRAM #(.DEPTH(256), .ADDR_WIDTH(8), .DATA_WIDTH(128)) SRAMBANKA0 ( .clk(clk), .cs(cs), .we(we), .addr(addr), .din(din), .dout(dout) );
reg [7:0] output_bits_reference [0:255];
always #(period/2.0) clk=~clk;

initial begin
	$readmemb("ref/SRAM_DATA0.txt", SRAMBANKA0.memory);
	$readmemb("ref/output_ans.txt", output_bits_reference);
end
////do touch above ////

wire [7:0] input_0; 	//// first fp8 operand
wire [7:0] input_1; 	//// second fp8 operand
wire [7:0] c;		//// fp8 output

reg [0:0] RESETN;	//// reset disable

//////// assign input here, dout is 16-bit input read from sram	////////
assign input_0 = dout[7:0];
assign input_1 = dout[15:8];


//// instantiate your ADDER here ////
FP8_ADDER u_adder (
	.CLK (clk),
	.RESETN (RESETN),
	.input_a (input_0),
	.input_b (input_1),
	.output_c (c)
);





//// do touch below ////
initial begin
$vcdplusfile("waveform.vpd");
$vcdpluson();
clk 	= 	0;
RESETN 	= 	0;
clk		=	0;
addr	=	8'b0000_0000;
cs	 	=	1'b0;
we	 	=	1'b0;
num_of_error = 0;
#period;#period;#period;#period;#period;#period;
RESETN 	= 	1;
#period;
cs		=	1'b1;

for (i=0;i<255;i=i+1) begin
	
	for (j=0;j<4;j=j+1) begin
		#period;
	end

	if (c == output_bits_reference[i]) begin
	end
	else begin
		num_of_error = num_of_error + 1;
	end

	#period;
	addr	=	addr+1'b1;
end

if (num_of_error == 0) begin
        $display("\n\n\nCongratulations, your original FP8 ADDER code passed all the %d tests...\n\n\n", num_of_case);
	end   	
	else begin
       	$display("\n\n\n%d out of %d test cases failed\n\n\n", num_of_error, num_of_case);
    end

#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;#period;
$vcdplusoff();
$finish;
end



endmodule
