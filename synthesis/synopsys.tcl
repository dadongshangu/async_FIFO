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

source timing.tcl

set_wire_load_mode  top
#set_wire_load_model -name MEDIUM

#-----------------------------------------------------------------------------


#-----------------------------------------------------------------------------
# Compile the design

ungroup -all -flatten
#compile_ultra
compile
#-----------------------------------------------------------------------------

