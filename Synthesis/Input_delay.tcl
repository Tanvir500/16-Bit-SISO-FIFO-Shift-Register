# Run Genus in Legacy UI if Genus is invoked with Common UI 
::legacy::set_attribute common_ui false / 
if {[file exists /proc/cpuinfo]} { 
sh grep "model name" /proc/cpuinfo 
sh grep "cpu MHz" /proc/cpuinfo 
} 
puts "Hostname : [info hostname]" 
############################################################################## 
### Preset global variables and attributes 
############################################################################## 
# Set input delays to iterate over 
set inp_delays {0.1 0.2 0.4 0.6 0.8 1 1.3 1.5} 
set DESIGN SISO_FIFO_ShiftRegister 
set SYN_EFF high 
set MAP_EFF high 
set OPT_EFF high 
# Directory of PDK 
set pdk_dir /home/cad/VLSI2Lab/Digital/library/ 
set_attribute init_lib_search_path $pdk_dir 
# Set synthesizing effort for each synthesis stage 
set_attribute syn_generic_effort $SYN_EFF 
set_attribute syn_map_effort $MAP_EFF 
set_attribute syn_opt_effort $OPT_EFF 
set_attribute library "slow_vdd1v0_basicCells.lib" 
# Exclude certain library cells 
set_dont_use [get_lib_cells CLK*] 
set_dont_use [get_lib_cells SDFF*] 
set_dont_use [get_lib_cells DLY*] 
set_dont_use [get_lib_cells HOLD*] 
# Load Design 
read_hdl "${DESIGN}.v" 
elaborate $DESIGN 
# Iterate over each input delay 
foreach inp_delay $inp_delays { 
# Create a new SDC file for each input delay 
set sdc_file "${DESIGN}_inpDelay_${inp_delay}_high.sdc" 
# Write the new SDC file 
set output [open $sdc_file "w"] 
puts $output "create_clock -period 10 -waveform {0 6} -name func_clk [get_ports 
Clk]" 

puts $output "set_input_delay ${inp_delay} -clock [get_clocks func_clk] {Load 
Left Din A}" 
puts $output "set_output_delay 0.6 -clock [get_clocks func_clk] {Dout register}" 
close $output 
# Read the newly created SDC file 
read_sdc $sdc_file 
# Run synthesis 
syn_generic 
puts "Runtime & Memory after 'syn_generic' for input delay ${inp_delay} ns" 
time_info GENERIC 
# Report power and generate output files 
report_power -verbose -detail >> 
reports/power_report_inpDelay_${inp_delay}_high.txt 
report_area >> reports/area_report_inpDelay_${inp_delay}_high.txt 
synthesize -to_mapped 
write -mapped > SISO_FIFO_ShiftRegister_synth_inpDelay_${inp_delay}_high.v 
} 
# Write final script 
write_script > script
