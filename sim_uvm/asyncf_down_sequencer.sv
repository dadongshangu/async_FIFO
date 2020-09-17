`ifndef ASYNCF_DOWN_SEQUENCER__SV
`define ASYNCF_DOWN_SEQUENCER__SV

class asyncf_down_sequencer extends uvm_sequencer #(asyncf_down_transaction);
   
   function new(string name = "asyncf_down_sequencer", uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(asyncf_down_sequencer)
endclass

`endif
