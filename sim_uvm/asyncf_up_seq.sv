`ifndef ASYNCF_UP_SEQ_SV
`define ASYNCF_UP_SEQ_SV

class asyncf_up_seq extends uvm_sequence #(asyncf_transaction);
   
   function  new(string name= "asyncf_up_seq");
      super.new(name);
   endfunction 

   extern virtual task body();
   extern virtual task pre_body();
   extern virtual task post_body();

   `uvm_object_utils(asyncf_up_seq)
endclass

task asyncf_up_seq::body();
    asyncf_transaction up_trans; 
    `uvm_do(up_trans)
    `uvm_info("asyncf_up_seq", "send one transaction", UVM_MEDIUM)

endtask

task asyncf_up_seq::pre_body();
//    if(starting_phase != null) begin 
//        starting_phase.raise_objection(this);
//    end
endtask

task asyncf_up_seq::post_body();
//    if(starting_phase != null) begin 
//        starting_phase.drop_objection(this);
//    end
endtask
`endif
