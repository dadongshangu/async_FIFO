case0: simv
	./simv +UVM_TESTNAME=asyncf_case0 -l case0_run.log 

case1: simv
	./simv +UVM_TESTNAME=asyncf_case1 -l case1_run.log 
simv: 
	vcs +v2k -debug_all -full64 \
	-P ${NOVAS_HOME}/share/PLI/VCS/LINUX64/verdi.tab \
	   ${NOVAS_HOME}/share/PLI/VCS/LINUX64/pli.a \
    +vpi -sverilog ${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS -timescale=1ns/1ps \
	+incdir+../tb \
	-f ../flist/filelist_uvm.f \
	+notimingcheck \
	+nospecify \
	-l vsim.log \
	-top top_tb 


verdi:
	verdi -f ../flist/filelist_uvm.f -ssf top_tb.fsdb -nologo &

.PHONY: case0 clean verdi 

clean:
	-@rm -rf novas.* verdiLog *.log simv simv.daidir *.fsdb *.key csrc *.h
