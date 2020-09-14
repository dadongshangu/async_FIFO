`ifndef ASYNCF_MODEL__SV
`define ASYNCF_MODEL__SV

class asyncf_model extends uvm_component;
   
   uvm_blocking_get_port #(asyncf_transaction)  port;
   uvm_analysis_port #(asyncf_transaction)  ap;

   extern function new(string name, uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);

   `uvm_component_utils(asyncf_model)
endclass 

function asyncf_model::new(string name, uvm_component parent);
   super.new(name, parent);
endfunction 

function void asyncf_model::build_phase(uvm_phase phase);
   super.build_phase(phase);
   port = new("port", this);
   ap = new("ap", this);
endfunction

task asyncf_model::main_phase(uvm_phase phase);
   asyncf_transaction tr;
   asyncf_transaction new_tr;
   super.main_phase(phase);
   while(1) begin
      port.get(tr);
      new_tr = new("new_tr");
      new_tr.copy(tr);
      `uvm_info("asyncf_model", "get one transaction, copy and print it:", UVM_LOW)
      new_tr.print();
      ap.write(new_tr);
   end
endtask
`endif
