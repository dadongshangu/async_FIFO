`ifndef ASYNCF_CASE0__SV
`define ASYNCF_CASE0__SV

class asyncf_case0 extends base_test;

   function new(string name = "asyncf_case0", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   `uvm_component_utils(asyncf_case0)
endclass


function void asyncf_case0::build_phase(uvm_phase phase);
   super.build_phase(phase);

   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.m_virtual_asyncf_seqr.main_phase", 
                                           "default_sequence", 
                                           asyncf_case0_sequence::type_id::get());
endfunction

`endif
