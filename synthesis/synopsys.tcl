#-----------------------------------------------------------------------------
# Synthesis Script for async_fifo
#-----------------------------------------------------------------------------


#-----------------------------------------------------------------------------
# Read/analyze/elaborate the design

analyze -format verilog ../src/async_fifo.v
analyze -format verilog ../src/fifo_mem.v
analyze -format verilog ../src/gray_sync2d.v
analyze -format verilog ../src/rptr_empty.v
analyze -format verilog ../src/wptr_full.v

elaborate async_fifo

#remove_license HDL-compiler

#-----------------------------------------------------------------------------
# TODO. No link and target library for trail.
#set search_path [ ]
#set search_path [ ]
#set search_path [ ]
#
#set target_library    {}
#set link_library      {}

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Set the timing constraints

current_design async_fifo

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

