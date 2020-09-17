`ifndef ASYNCF_UP_AGENT__SV
`define ASYNCF_UP_AGENT__SV

class asyncf_up_agent extends uvm_agent ;
   asyncf_up_sequencer  sqr;
   asyncf_driver     drv;
   asyncf_up_monitor mon;
   
   uvm_analysis_port #(asyncf_transaction)  ap;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(asyncf_up_agent)
endclass 


function void asyncf_up_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   sqr = asyncf_up_sequencer::type_id::create("sqr", this);
   drv = asyncf_driver::type_id::create("drv", this);
   mon = asyncf_up_monitor::type_id::create("mon", this);
endfunction 

function void asyncf_up_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   drv.seq_item_port.connect(sqr.seq_item_export);
   ap = mon.ap;
endfunction

`endif

