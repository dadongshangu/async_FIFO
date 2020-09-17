`ifndef ASYNCF_UP_SEQUENCER__SV
`define ASYNCF_UP_SEQUENCER__SV

class asyncf_up_sequencer extends uvm_sequencer #(asyncf_transaction);
   
   function new(string name = "asyncf_up_sequencer", uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(asyncf_up_sequencer)
endclass

`endif
