`ifndef ASYNCF_UP_MONITOR__SV
`define ASYNCF_UP_MONITOR__SV
class asyncf_up_monitor extends uvm_monitor;

   virtual up_if up_if;

   uvm_analysis_port #(asyncf_transaction)  ap;
   
   `uvm_component_utils(asyncf_up_monitor)
   function new(string name = "asyncf_up_monitor", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual up_if)::get(this, "", "up_if", up_if))
         `uvm_fatal("asyncf_up_mornitor", "virtual interface must be set for up_if!!!")
      ap = new("ap", this);
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task collect_one_pkt(asyncf_transaction tr);
endclass

task asyncf_up_monitor::main_phase(uvm_phase phase);
   asyncf_transaction tr;
   while(1) begin
      tr = new("tr");
      collect_one_pkt(tr);
      ap.write(tr);
   end
endtask

task asyncf_up_monitor::collect_one_pkt(asyncf_transaction tr);
   
   while(1) begin
      @(posedge up_if.wclk);
      if(up_if.winc) break;
   end
   
   `uvm_info("asyncf_up_monitor", "begin to collect one pkt", UVM_MEDIUM);
   tr.data = up_if.wdata;
   @(posedge up_if.wclk);
   `uvm_info("asyncf_up_monitor", "end collect one pkt", UVM_MEDIUM);
endtask


`endif
