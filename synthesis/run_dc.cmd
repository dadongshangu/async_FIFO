rm -rf alib-52 default.svf WORK Netlists*.v *.report_* *.log *.txt
dc_shell -f main.tcl | tee run.log
