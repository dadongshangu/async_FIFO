#-----------------------------------------------------------------------------
# Main Synthesis Script 
#-----------------------------------------------------------------------------

sh "date"

set DESIGN async_fifo
set report report
set log log 
set netlist netlist 

if [file exist ${report}] {} else {file mkdir ${report}}
if [file exist ${log}] {} else {file mkdir ${log}}
if [file exist ${netlist}] {} else {file mkdir ${netlist}}

set rtl_path ".."
set search_path [list .                                 \
                   ${rtl_path}                          \
                ]
#-----------------------------------------------------------------------------
set_app_var target_library    {/tools/synopsys/dc/dc_L-2016.03-SP1/libraries/syn/lsi_9k.db}
set_app_var link_library      {/tools/synopsys/dc/dc_L-2016.03-SP1/libraries/syn/lsi_9k.db}

#-----------------------------------------------------------------------------

define_design_lib WORK -path ./WORK

source -e -v synopsys.tcl

current_design ${DESIGN}

echo "${DESIGN} has [sizeof_coll [all_reg]] registers"

report_area                                                             > ./${report}/Area.${DESIGN}.rpt
report_timing -nets -capacitance -input_pins -derate -max_paths 2000    > ./${report}/Timing.${DESIGN}.rpt
report_constraints -all_violators                                       > ./${report}/Violatior.${DESIGN}.rpt
report_ideal_network                                                    > ./${report}/IdealNetwork.${DESIGN}.rpt

write -format verilog -hierarchy -output ./${netlist}/Netlists.${DESIGN}.gv

quit
