`ifndef ASYNCF_MONITOR__SV
`define ASYNCF_MONITOR__SV
class asyncf_monitor extends uvm_monitor;

   virtual up_if up_if;
   virtual down_if down_if;

   uvm_analysis_port #(asyncf_transaction)  ap;
   
   `uvm_component_utils(asyncf_monitor)
   function new(string name = "asyncf_monitor", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual up_if)::get(this, "", "up_if", up_if))
         `uvm_fatal("asyncf_driver", "virtual interface must be set for up_if!!!")
      if(!uvm_config_db#(virtual down_if)::get(this, "", "down_if", down_if))
         `uvm_fatal("asyncf_driver", "virtual interface must be set for up_if!!!")
      ap = new("ap", this);
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task collect_one_pkt(asyncf_transaction tr);
endclass

task asyncf_monitor::main_phase(uvm_phase phase);
   asyncf_transaction tr;
   while(1) begin
      tr = new("tr");
      collect_one_pkt(tr);
      ap.write(tr);
   end
endtask

task asyncf_monitor::collect_one_pkt(asyncf_transaction tr);
   byte unsigned data_q[$];
   byte unsigned data_array[];
   logic [7:0] data;
   logic valid = 0;
   int data_size;
   
   while(1) begin
      @(posedge vif.clk);
      if(vif.valid) break;
   end
   
   `uvm_info("asyncf_monitor", "begin to collect one pkt", UVM_LOW);
   while(vif.valid) begin
      data_q.push_back(vif.data);
      @(posedge vif.clk);
   end
   data_size  = data_q.size();   
   data_array = new[data_size];
   for ( int i = 0; i < data_size; i++ ) begin
      data_array[i] = data_q[i]; 
   end
   tr.pload = new[data_size - 18]; //da sa, e_type, crc
   data_size = tr.unpack_bytes(data_array) / 8; 
   `uvm_info("asyncf_monitor", "end collect one pkt", UVM_LOW);
endtask


`endif
