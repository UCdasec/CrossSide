
set_property IOSTANDARD LVCMOS33 [get_ports *]

######## 40-pin GPIO Header
set_property PACKAGE_PIN A12 [get_ports trig]
set_property PACKAGE_PIN A14 [get_ports s]
set_property PACKAGE_PIN A15 [get_ports k]
set_property PACKAGE_PIN C12 [get_ports c]
set_property PACKAGE_PIN N11 [get_ports clk]   

#create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

# both input clocks have same properties so there is no point in doing timing analysis for both:
#set_case_analysis 1 [get_pins U_clocks/CCLK_MUX/S]

# No spec for these, seems sensible:
#set_input_delay -clock clk -add_delay 2.000 [get_ports s]
#set_input_delay -clock clk -add_delay 2.000 [get_ports k]
#set_input_delay -clock clk -add_delay 2.000 [get_ports c]
#set_input_delay -clock clk -add_delay 2.000 [get_ports trig]

#set_property CFGBVS VCCO [current_design]
#set_property CONFIG_VOLTAGE 3.3 [current_design]

#set_property BITSTREAM.CONFIG.USR_ACCESS TIMESTAMP [current_design]
#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
