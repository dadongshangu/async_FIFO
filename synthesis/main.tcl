#-----------------------------------------------------------------------------
# Main Synthesis Script 
#-----------------------------------------------------------------------------

echo "######################"
echo ""
date
echo ""
echo "######################"


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

set DW_PATH "/tools/synopsys/dc/dc_L-2016.03-SP1/libraries/syn"
set search_path ". $search_path $DW_PATH"
set synthetic_library dw_foundation.sldb
set_app_var link_library "$link_library $synthetic_library"

#-----------------------------------------------------------------------------

define_design_lib WORK -path ./WORK

source -e -v synopsys.tcl

current_design ${DESIGN}

echo "${DESIGN} has [sizeof_coll [all_reg]] registers"
set design_all_clocks [all_clocks]
foreach_in_collection clk $design_all_clocks {
    set no_clock_reg [remove_from_collection [all_registers] [all_registers -clock $clk]]
}

query_objects $no_clock_reg                                             > ./${report}/registers_witout_clk.${DESIGN}.rpt

check_timing                                                            > ./${report}/CheckTiming.${DESIGN}.rpt
report_area                                                             > ./${report}/Area.${DESIGN}.rpt
report_area -hierarchy                                                  > ./${report}/Area_hier.${DESIGN}.rpt
report_qor                                                              > ./${report}/Qor.${DESIGN}.rpt
report_timing -nets -capacitance -input_pins -derate -max_paths 2000    > ./${report}/Timing.${DESIGN}.rpt
report_constraints -all_violators                                       > ./${report}/Violatior.${DESIGN}.rpt
report_ideal_network                                                    > ./${report}/IdealNetwork.${DESIGN}.rpt

write -format verilog -hierarchy -output ./${netlist}/Netlists.${DESIGN}.gv
write -format ddc -h -out                ./${report}/${DESIGN}.ddc
write_sdc -nosplit                       ./${report}/${DESIGN}.sdc

echo "######################"
echo ""
date
echo ""
echo "######################"

#quit
