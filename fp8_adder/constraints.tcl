# complete this file based on the requirements 
 
# define clock period 
create_clock -period 1.5 [get_ports CLK] 
 
#set clock uncertainty 
set_clock_uncertainty -setup 0.1 [get_clocks CLK] 
 
#set input transition (exclude clock) 
set_max_transition 0.1 [get_ports {input_a input_b RESETN}] 
 
#set max input delay (exclude clock and reset) 
set_input_delay -max 0.2 -clock CLK [get_ports {input_a input_b}] 
 
#set max output delay (all outputs) 
set_output_delay -max 0.2 -clock CLK [get_ports {output_c}] 
 
#set load capacitance (output) 5fF = 0.005pF 
set_max_capacitance 0.005 [get_ports {output_c}] 
 
#set output load - inverter with 4X strength 
set_driving_cell -lib_cell INVX4_RVT -library saed32rvt_tt1p05v125c [get_ports {input_a input_b 
RESETN}] 
 
#set max area (no constraints) 
set_max_area 0