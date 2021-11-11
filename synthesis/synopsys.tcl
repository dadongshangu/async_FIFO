#-----------------------------------------------------------------------------
# Synthesis Script for async_fifo
#-----------------------------------------------------------------------------

set_app_var dc_allow_rtl_pg true
lappend DEFINE_LIST ""
set     RTL_FILE_LIST [ list \
 ../src/async_fifo.v   \
 ../src/fifo_mem.v     \
 ../src/gray_sync2d.v  \
 ../src/rptr_empty.v   \
 ../src/wptr_full.v    \
 ]

set serach_path [list $search_path \
 ../src \
 ]

set RTL_INCLUDE_FILE ""

#-----------------------------------------------------------------------------
# Read/analyze/elaborate the design

analyze -format sverilog -define $DEFINE_LIST $RTL_FILE_LIST 

elaborate ${DESIGN} 

current_design ${DESIGN} 

set_fix_multiple_port_nets -all -buffer_constants

link > ./${log}/link_design.log

uniquify -force

check_design > ./${log}/check_design.log
write -format ddc -h -out ./${report}/${DESIGN}_elaborate.ddc


#-----------------------------------------------------------------------------
# Set the timing constraints

current_design ${DESIGN} 

source -e -v timing.tcl

set_wire_load_mode  top
#set_wire_load_model -name MEDIUM

#Group

set clock_ports [get_ports -quiet [all_fanout -clock_tree -flat]]
set all_inputs [all_inputs]
set all_outputs [all_outputs]
set all_nonclk_inputs [remove_from_collection $all_inputs $clock_ports]
set all_nonclk_outputs [remove_from_collection $all_outputs $clock_ports]
set all_icgs [get_cells -hier -filter "is_integrated_clock_gating_cell == true"]
set all_reg [all_registers]
set all_reg [remove_from_collection $all_reg $all_icgs]
set all_mem [get_cells -hierarchical -filter "is_memory_cell == true"]

group_path -from $all_reg -to $all_reg -name reg2reg
group_path -from $all_reg -to $all_nonclk_outputs -name reg2out
group_path -from $all_nonclk_inputs -to $all_reg -name in2reg 
group_path -from $all_nonclk_inputs -to $all_nonclk_outputs -name in2out 
#group_path -from $all_mem -to $all_reg -name mem2reg
#group_path -from $all_reg -to $all_mem -name reg2mem 

#-----------------------------------------------------------------------------


#-----------------------------------------------------------------------------
# Compile the design

#ungroup -all -flatten
compile_ultra -gate_clock -no_seq_output_inversion -no_autoungroup -timing_high_effort_script
#compile
#-----------------------------------------------------------------------------

