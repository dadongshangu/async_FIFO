`ifndef ASYNCF_DOWN_AGENT__SV
`define ASYNCF_DOWN_AGENT__SV

class asyncf_down_agent extends uvm_agent ;
   asyncf_down_sequencer  sqr;
   asyncf_down_monitor  mon;
   asyncf_down_driver   drv;
   
   uvm_analysis_port #(asyncf_transaction)  ap;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(asyncf_down_agent)
endclass 


function void asyncf_down_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   sqr = asyncf_down_sequencer::type_id::create("sqr", this);
   mon = asyncf_down_monitor::type_id::create("mon", this);
   drv = asyncf_down_driver::type_id::create("drv", this);
endfunction 

function void asyncf_down_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   drv.seq_item_port.connect(sqr.seq_item_export);
   ap = mon.ap;
endfunction

`endif

