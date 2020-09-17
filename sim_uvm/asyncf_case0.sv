`ifndef ASYNCF_CASE0__SV
`define ASYNCF_CASE0__SV
class case0_sequence extends uvm_sequence;
    
    `uvm_object_utils(case0_sequence)
    `uvm_declare_p_sequencer(asyncf_virtual_sequencer)
    
   function  new(string name= "case0_sequence");
      super.new(name);
   endfunction 
   
   extern virtual task body();
   extern virtual task pre_body();
   extern virtual task post_body();

endclass

task case0_sequence::body();
   asyncf_up_seq up_seq;
   asyncf_down_seq down_seq;
      repeat (7) begin
         `uvm_do_on(up_seq,p_sequencer.m_up_seqr)
      end
      repeat (7) begin
         `uvm_do_on(down_seq,p_sequencer.m_down_seqr)
      end
#300;
    `uvm_info("asyncf_case0", "body finished", UVM_MEDIUM)
endtask

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
                                           case0_sequence::type_id::get());
endfunction

task case0_sequence::pre_body();
    if(starting_phase != null) begin 
        starting_phase.raise_objection(this);
    end
endtask

task case0_sequence::post_body();
    `uvm_info("asyncf_case0", "Entering post_body", UVM_MEDIUM)
    if(starting_phase != null) begin 
        `uvm_info("asyncf_case0", "starting_pase is null", UVM_MEDIUM)
        starting_phase.drop_objection(this);
    end
endtask

`endif
