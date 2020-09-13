`ifndef ASYNCF_SEQUENCER__SV
`define ASYNCF_SEQUENCER__SV

class asyncf_sequencer extends uvm_sequencer #(asyncf_transaction);
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(asyncf_sequencer)
endclass

`endif
