`ifndef ASYNCF_VIRTUAL_SEQUENCER__SV
`define ASYNCF_VIRTUAL_SEQUENCER__SV

class asyncf_virtual_sequencer extends uvm_sequencer;
   //Declaration.
   asyncf_up_sequencer m_up_seqr;
   asyncf_down_sequencer m_down_seqr;
   
   function new(string name = "asyncf_virtual_sequencer", uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   `uvm_component_utils(asyncf_virtual_sequencer)
endclass

`endif
