vcom "$DSN\src\sort.vhd" 
vcom "$DSN\src\TestBench\sort_TB.vhd" 
vsim TESTBENCH_FOR_sort 
wave  
wave clk
wave reset
wave working
wave data_in
wave data_out
run 0. ps
# The following lines can be used for timing simulation
# vcom <backannotated_vhdl_file_name>
# vcom "$DSN\src\TestBench\sort_TB_tim_cfg.vhd" 
# vsim TIMING_FOR_sort 
