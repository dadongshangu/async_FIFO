# async_FIFO design
This asynchronous FIFO design is based entirely on Cliff Cumming’s paper [Simulation and Synthesis Techniques for Asynchronous FIFO Design](http://www.sunburst-design.com/papers/CummingsSNUG2002SJ_FIFO1.pdf). 

# Plan
* [x] 1. Create the Async FIFO. (Done)
* [x]  2. Try the basec verilog TB. (Done)
* [x] 3.  Try the UVM verification. (Done)


# Status
1. 2020.09.06: Basic RTL done.
2. 2020.09.06: Basic verilog TB done.
3. 2020.09.17: UVM verification TB done.

# About the UVM verification.
The UVM verification codes are learned and referred to Zhangqiang's book CummingsSNUG2002SJ_FIFO1.pdf(《UVM实战》).

# File introduction:
```text
│  CummingsSNUG2002SJ_FIFO1.pdf      #Zhangqiang's book.
│  README.md
│  
├─flist
│      filelist.f
│      filelist_uvm.f
│      
├─sim                                #Simple verilog testbench.
│      makefile
│      README
│      top_tb.v
│      
├─sim_uvm                            #UVM testbench.
│      asyncf_case0.sv               #case0
│      asyncf_case0_seq.sv           #case0 sequence
│      asyncf_case1.sv               #case1
│      asyncf_case1_seq.sv           #case1 sequence
│      asyncf_down_agent.sv          #FIFO downstream agent
│      asyncf_down_driver.sv         #FIFO downstream driver
│      asyncf_down_monitor.sv        #FIFO downstream monitor
│      asyncf_down_seq.sv            #FIFO downstream sequence
│      asyncf_down_sequencer.sv      #FIFO downstream sequencer
│      asyncf_down_transaction.sv    #FIFO downstream transaction defination
│      asyncf_driver.sv              #FIFO upstream driver
│      asyncf_env.sv                 #Total env.
│      asyncf_if.sv                  #FIFO interface defination: up_if/down_if
│      asyncf_model.sv               #Reference mode.
│      asyncf_scoreboard.sv          #Scoreboard
│      asyncf_transaction.sv         #FIFO upstream transaction defination.
│      asyncf_up_agent.sv            #FIFO upstream agent
│      asyncf_up_monitor.sv          #FIFO upstream monitor
│      asyncf_up_seq.sv              #FIFO upstream sequence
│      asyncf_up_sequencer.sv        #FIFO upstream sequencer
│      asyncf_virtual_sequencer.sv   #Virtual sequencer
│      base_test.sv                  #Bae test
│      debug.rc                      #verdi signal list.
│      makefile                      #make case0 to run case0
│      README.md
│      top_tb.sv                     #TOP file
│      
├─spyglass                           #spyglass script to check DUT
│      async_fifo.prj
│      makefile
│      README
│      run_sg.tcl
│      
├─src                                #DUT
│      async_fifo.v
│      fifo_mem.v
│      gray_sync2d.v
│      README.md
│      rptr_empty.v
│      wptr_full.v
│      
└─synthesis                           #Synthesis script. You need to replace the link/target_library. 
        main.tcl
        makefile
        README
        synopsys.tcl
        timing.tcl
```

# Contributing

If you'd like to add or improve this software design, your contribution is welcome!

# License

This repository is released under the [MIT license](https://opensource.org/licenses/MIT). In short, this means you are free to use this software in any personal, open-source or commercial projects. Attribution is optional but appreciated.
