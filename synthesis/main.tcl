#-----------------------------------------------------------------------------
# Main Synthesis Script 
#-----------------------------------------------------------------------------

sh "date"

set MODULE_NAME async_fifo 
set rtl_path ".."
set search_path [list .                                 \
                   ${rtl_path}                          \
                ]

define_design_lib WORK -path ./WORK

source synopsys.tcl
current_design ${MODULE_NAME}

echo "${MODULE_NAME} has [sizeof_coll [all_reg]] registers"

report_area                                                             > Area.${MODULE_NAME}.txt
report_timing -nets -capacitance -input_pins -derate -max_paths 2000    > Timing.${MODULE_NAME}.txt
report_constraints -all_violators                                       > Violatior.${MODULE_NAME}.txt
report_ideal_network                                                    > IdealNetwork.${MODULE_NAME}.txt

write -format verilog -hierarchy -output Netlists.${MODULE_NAME}.v

quit
