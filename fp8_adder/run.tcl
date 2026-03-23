#read verilog file 
read_verilog src/FP8_ADDER.v 
 
#set current design 
current_design FP8_ADDER 
 
#auto loads ddc files 
link 
 
#constrain the design 
source syn/constraint.tcl 
 
#compile design 
compile 
 
#generate timing report 
redirect -tee syn/FP8_ADDER_timing.rpt \ 
                {report_timing} 
 
#generate area report 
redirect -tee syn/FP8_ADDER_area.rpt \ 
                {report_area} 
 
#generate constraint violations report 
redirect -tee syn/FP8_ADDER_constraint.rpt \ 
                {report_constraint -all_violators} 
 
#save mapped design as ddc 
write -format ddc -hierarchy -output syn/output/FP8_ADDER.ddc 
 
#save synthesized netlist as verilog 
write -format verilog -hierarchy -output syn/output/FP8_ADDER_netlist.v 
 
#save sdc constraints 
write_sdc syn/output/FP8_ADDER.sdc 
 
#quit design compiler 
quit 