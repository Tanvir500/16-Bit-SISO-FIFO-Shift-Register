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
# Set setup times to iterate over 
set clock_periods {5 10 20 50 100} 
set DESIGN SISO_FIFO_ShiftRegister 
set SYN_EFF low 
set MAP_EFF low 
set OPT_EFF low 
# Directory of PDK 
set pdk_dir /home/cad/VLSI2Lab/Digital/library/ 
set_attribute init_lib_search_path $pdk_dir 
# Set synthesizing effort for each synthesis stage 
set_attribute syn_generic_effort $SYN_EFF 
set_attribute syn_map_effort $MAP_EFF 
set_attribute syn_opt_effort $OPT_EFF 
set_attribute library "slow_vdd1v0_basicCells.lib" 
set_dont_use [get_lib_cells CLK*] 
set_dont_use [get_lib_cells SDFF*] 
set_dont_use [get_lib_cells DLY*] 
set_dont_use [get_lib_cells HOLD*] 
# Load Design 
read_hdl "${DESIGN}.v" 
elaborate $DESIGN 
#check_design -unresolved 
# Iterate over each setup time 
foreach clock_period $clock_periods { 
# Create a new SDC file for each setup time 
set sdc_file "${DESIGN}_clock_${clock_period}_low.sdc" 
# Write the new SDC file 
set output [open $sdc_file "w"] 
#puts $output "set setup_time 3" 
puts $output "create_clock -period ${clock_period} -waveform {0 6} -name func_clk 
[get_ports Clk]" 
puts $output "set_input_delay 0.4 -clock [get_clocks func_clk] {Load Left Din A}"

puts $output "set_output_delay 0.6 -clock [get_clocks func_clk] {Dout register}" 
#puts $output "set_multicycle_path -setup 3 -from [get_ports rst_n]" 
#puts $output "set_multicycle_path -hold 2 -from [get_ports rst_n]" 
close $output 
# Read the newly created SDC file 
read_sdc $sdc_file 
# Run synthesis 
syn_generic 
puts "Runtime & Memory after 'syn_generic' for clock period ${clock_period} ns" 
time_info GENERIC 
# Report power and generate output files 
report_power -verbose -detail >> 
reports/power_report_clock_${clock_period}_low.txt 
report_area  >> reports/area__report_clock_${clock_period}_low.txt 
synthesize -to_mapped 
write -mapped > SISO_FIFO_ShiftRegister_synth_clock_${clock_period}_low.v 
} 
# Write final script 
write_script > script
