`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "asyncf_if.sv"
`include "asyncf_transaction.sv"
`include "asyncf_down_transaction.sv"
`include "asyncf_up_sequencer.sv"
`include "asyncf_down_sequencer.sv"
`include "asyncf_up_seq.sv"
`include "asyncf_down_seq.sv"
`include "asyncf_virtual_sequencer.sv"
`include "asyncf_driver.sv"
`include "asyncf_down_driver.sv"
`include "asyncf_up_monitor.sv"
`include "asyncf_down_monitor.sv"
`include "asyncf_up_agent.sv"
`include "asyncf_down_agent.sv"
`include "asyncf_model.sv"
`include "asyncf_scoreboard.sv"
`include "asyncf_env.sv"
`include "base_test.sv"
`include "asyncf_case0_seq.sv"
`include "asyncf_case0.sv"
`include "asyncf_case1_seq.sv"
`include "asyncf_case1.sv"

module top_tb;

reg wclk;
reg rclk;
reg wrst_n;
reg rrst_n;
reg rinc;

up_if up_if(wclk, wrst_n);
down_if down_if(rclk, rrst_n);

async_fifo async_fifo(
                .rdata(down_if.rdata),
                .wfull(up_if.wfull),
                .rempty(down_if.rempty),
                .wdata(up_if.wdata),
                .winc(up_if.winc), 
                .wclk(wclk), 
                .wrst_n(wrst_n),
                .rinc(down_if.rinc), 
                .rclk(rclk), 
                .rrst_n(rrst_n)
            );

//always @(*) begin
//    if (~down_if.rempty)
//    rinc = 1;
//    else
//    rinc = 0;
//    end


initial begin
   wclk = 0;
   forever begin
      #100 wclk = ~wclk;
   end
end

initial begin
   rclk = 0;
   forever begin
      #150 rclk = ~rclk;
   end
end

initial begin
   wrst_n = 1'b0;
   rrst_n = 1'b0;
   #1000;
   wrst_n = 1'b1;
   rrst_n = 1'b1;
end

initial begin
   run_test();
end

initial begin
   uvm_config_db#(virtual up_if)::set(null, "uvm_test_top.env.i_agt.drv", "up_if", up_if);
   uvm_config_db#(virtual up_if)::set(null, "uvm_test_top.env.i_agt.mon", "up_if", up_if);
   uvm_config_db#(virtual down_if)::set(null, "uvm_test_top.env.o_agt.drv", "down_if", down_if);
   uvm_config_db#(virtual down_if)::set(null, "uvm_test_top.env.o_agt.mon", "down_if", down_if);
end

// fsdb
initial begin
    $fsdbDumpfile("top_tb.fsdb");
    $fsdbDumpvars(0, top_tb);
end

endmodule
