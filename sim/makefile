
sim: 
	vcs +v2k -debug_all -full64 \
	-P ${NOVAS_HOME}/share/PLI/VCS/LINUX64/verdi.tab \
	   ${NOVAS_HOME}/share/PLI/VCS/LINUX64/pli.a \
	+incdir+../tb \
	-f ../flist/filelist.f \
	+notimingcheck \
	+nospecify \
	-l sim.log \
	-top top_tb \
	-R \

verdi:
	verdi -f ../flist/filelist.f &

.PHONY: sim clean verdi 

clean:
	-@rm -rf novas.* verdiLog *.log simv simv.daidir *.fsdb *.key csrc
