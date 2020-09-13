`ifndef ASYNCF_DRIVER__SV
`define ASYNCF_DRIVER__SV
class asyncf_driver extends uvm_driver#(asyncf_transaction);

   virtual up_if up_if;
   virtual down_if down_if;

   `uvm_component_utils(asyncf_driver)
   function new(string name = "asyncf_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual up_if)::get(this, "", "up_if", up_if))
         `uvm_fatal("asyncf_driver", "virtual interface must be set for up_if!!!")
      if(!uvm_config_db#(virtual down_if)::get(this, "", "down_if", down_if))
         `uvm_fatal("asyncf_driver", "virtual interface must be set for up_if!!!")
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task drive_one_pkt(asyncf_transaction tr);
endclass

task asyncf_driver::main_phase(uvm_phase phase);
   up_if.wdata <= 8'b0;
   up_if.winc  <= 1'b0;
   while(!up_if.wrst_n)
      @(posedge up_if.wclk);
   while(1) begin
      seq_item_port.get_next_item(req);
      drive_one_pkt(req);
      seq_item_port.item_done();
   end
endtask

task asyncf_driver::drive_one_pkt(asyncf_transaction tr);
   byte unsigned     data_q[];
   int  data_size;
   
   data_size = tr.pack_bytes(data_q) / 8; 
   `uvm_info("asyncf_driver", "begin to drive one pkt", UVM_LOW);
   repeat(3) @(posedge up_if.wclk);
   for ( int i = 0; i < data_size; i++ ) begin
      @(posedge up_if.wclk);
      if (~up_if.wfull) begin
        up_if.winc<= 1'b1;
        up_if.wdata <= data_q[i];
      end
      else begin
        up_if.winc <= 1'b0;
        up_if.wdata <= 8'b0;
      end
   end

   @(posedge up_if.wclk);
   up_if.winc<= 1'b0;
   `uvm_info("asyncf_driver", "end drive one pkt", UVM_LOW);
endtask
//TODO. Question: How to drive the rinc side?

`endif
