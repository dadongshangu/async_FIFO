`ifndef ASYNCF_DOWN_MONITOR__SV
`define ASYNCF_DOWN_MONITOR__SV
class asyncf_down_monitor extends uvm_monitor;

   virtual down_if down_if;

   uvm_analysis_port #(asyncf_transaction)  ap;
   
   `uvm_component_utils(asyncf_down_monitor)
   function new(string name = "asyncf_down_monitor", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual down_if)::get(this, "", "down_if", down_if))
         `uvm_fatal("asyncf_down_mornitor", "virtual interface must be set for down_if!!!")
      ap = new("ap", this);
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task collect_one_pkt(asyncf_transaction tr);
endclass

task asyncf_down_monitor::main_phase(uvm_phase phase);
   asyncf_transaction tr;
   while(1) begin
      tr = new("tr");
      collect_one_pkt(tr);
      ap.write(tr);
   end
endtask

task asyncf_down_monitor::collect_one_pkt(asyncf_transaction tr);
   
   while(1) begin
      @(posedge down_if.rclk);
      if(down_if.rinc) break;
   end
   
   `uvm_info("asyncf_down_monitor", "begin to collect one pkt", UVM_MEDIUM);
   tr.data = down_if.rdata;
   @(posedge down_if.rclk);
   `uvm_info("asyncf_down_monitor", "end collect one pkt", UVM_MEDIUM);
endtask


`endif
