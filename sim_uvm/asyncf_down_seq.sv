`ifndef ASYNCF_DOWN_SEQ_SV
`define ASYNCF_DOWN_SEQ_SV

class asyncf_down_seq extends uvm_sequence #(asyncf_down_transaction);
   
   function  new(string name= "asyncf_down_seq");
      super.new(name);
   endfunction 

   extern virtual task body();
   extern virtual task pre_body();
   extern virtual task post_body();

   `uvm_object_utils(asyncf_down_seq)
endclass

task asyncf_down_seq::body();
   asyncf_down_transaction down_trans; 
    `uvm_do(down_trans)
    `uvm_info("asyncf_down_seq", "Get one transaction", UVM_MEDIUM)

endtask

task asyncf_down_seq::pre_body();
    if(starting_phase != null) begin 
        starting_phase.raise_objection(this);
    end
endtask

task asyncf_down_seq::post_body();
    if(starting_phase != null) begin 
        starting_phase.drop_objection(this);
    end
endtask
`endif
