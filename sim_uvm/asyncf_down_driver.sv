`ifndef ASYNCF_DOWN_DRIVER__SV
`define ASYNCF_DOWN_DRIVER__SV
class asyncf_down_driver extends uvm_driver#(asyncf_down_transaction);

   virtual down_if down_if;
   logic no_tr = 1'b0;

   `uvm_component_utils(asyncf_down_driver)
   function new(string name = "asyncf_down_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual down_if)::get(this, "", "down_if", down_if))
         `uvm_fatal("asyncf_down_driver", "virtual interface must be set for down_if!!!")
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task drive_one_pkt(asyncf_down_transaction tr);
   extern task drive_nothing();
endclass

task asyncf_down_driver::main_phase(uvm_phase phase);
   down_if.rinc  <= 1'b0;
   while(!down_if.rrst_n)
      @(posedge down_if.rclk);
   fork

       while(1) begin
          seq_item_port.get_next_item(req);
          no_tr = 1'b0;
          drive_one_pkt(req);
          no_tr = 1'b1;
          seq_item_port.item_done();
       end
       while (1) begin
           drive_nothing();
       end
   join

endtask

task asyncf_down_driver::drive_one_pkt(asyncf_down_transaction tr);
//   repeat(1) @(posedge down_if.rclk);
      @(posedge down_if.rclk);
      while(1) begin
        if (down_if.rempty) begin
            //wait if empty.
            down_if.rinc <= 1'b0;
            @(posedge down_if.rclk);
        end
        else begin
          down_if.rinc<= 1'b1;
          break;
        end
      end

endtask

task asyncf_down_driver::drive_nothing();
   @(posedge down_if.rclk);
   if (no_tr) down_if.rinc<= 1'b0; //If no transaction. Drive the rinc to zero.

endtask

`endif
