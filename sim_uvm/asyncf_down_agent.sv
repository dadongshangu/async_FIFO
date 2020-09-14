`ifndef ASYNCF_DOWN_AGENT__SV
`define ASYNCF_DOWN_AGENT__SV

class asyncf_down_agent extends uvm_agent ;
   asyncf_down_monitor  mon;
   
   uvm_analysis_port #(my_transaction)  ap;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(asyncf_down_agent)
endclass 


function void asyncf_down_agent::build_phase(uvm_phase phase);
   super.build_phase(phase);
   mon = asyncf_down_monitor::type_id::create("mon", this);
endfunction 

function void asyncf_down_agent::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   ap = mon.ap;
endfunction

`endif

