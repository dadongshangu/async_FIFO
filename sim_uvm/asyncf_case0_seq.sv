`ifndef ASYNCF_CASE0_SEQ__SV
`define ASYNCF_CASE0_SEQ__SV
class asyncf_case0_sequence extends uvm_sequence;
    
    `uvm_object_utils(asyncf_case0_sequence)
    `uvm_declare_p_sequencer(asyncf_virtual_sequencer)
    
   function  new(string name= "asyncf_case0_sequence");
      super.new(name);
   endfunction 
   
   extern virtual task body();
   extern virtual task pre_body();
   extern virtual task post_body();

endclass

task asyncf_case0_sequence::body();
   asyncf_up_seq up_seq;
   asyncf_down_seq down_seq;
      repeat (7) begin
         `uvm_do_on(up_seq,p_sequencer.m_up_seqr)
      end
    `uvm_info("asyncf_case0", "Sent 7 done", UVM_MEDIUM)
      repeat (7) begin
         `uvm_do_on(down_seq,p_sequencer.m_down_seqr)
      end
    `uvm_info("asyncf_case0", "Get 7 done", UVM_MEDIUM)
      repeat (3) begin
         `uvm_do_on(up_seq,p_sequencer.m_up_seqr)
      end
    `uvm_info("asyncf_case0", "Sent 3 done", UVM_MEDIUM)
      repeat (3) begin
         `uvm_do_on(down_seq,p_sequencer.m_down_seqr)
      end
    `uvm_info("asyncf_case0", "Get 3 done", UVM_MEDIUM)
#3000;
    `uvm_info("asyncf_case0", "body finished", UVM_MEDIUM)
endtask

task asyncf_case0_sequence::pre_body();
    if(starting_phase != null) begin 
        starting_phase.raise_objection(this);
    end
endtask

task asyncf_case0_sequence::post_body();
    `uvm_info("asyncf_case0", "Entering post_body", UVM_MEDIUM)
    if(starting_phase != null) begin 
        `uvm_info("asyncf_case0", "starting_pase is null", UVM_MEDIUM)
        starting_phase.drop_objection(this);
    end
endtask

`endif
