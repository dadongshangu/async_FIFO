`timescale 1ns/1ns

module top_tb;
wire [7:0]  rdata;
wire              wfull;
wire              rempty;
reg [7:0]   wdata;
reg               winc;
reg               wclk;
reg               wrst_n;
reg               rinc;
reg               rclk;
reg               rrst_n;

initial begin
   wrst_n= 0;
   rrst_n= 0;
   wdata=0;
   winc=0;
   rinc=0;
   #500;
   wrst_n= 1;
   rrst_n= 1;
   #200;
   wdata = 1;
   winc = 1;
   rinc=0;

   #200;
   wdata = 2;
   winc = 1;
   rinc=0;

   #200;
   wdata = 3;
   winc = 1;
   rinc=0;

   #200;
   wdata = 0;
   winc = 0;
   rinc=1;

   #400;
   rinc=0;
   
   #200;
   rinc=1;

   #200;
   rinc=0;
   
   
   #4000;
   $finish; 
end

initial begin
   rclk = 0;
   forever begin
      #100 rclk = ~rclk;
   end
end

initial begin
   wclk = 0;
   forever begin
      #100 wclk = ~wclk;
   end
end

async_fifo async_fifo(
                .rdata(rdata),
                .wfull(wfull),
                .rempty(rempty),
                .wdata(wdata),
                .winc(winc), 
                .wclk(wclk), 
                .wrst_n(wrst_n),
                .rinc(rinc), 
                .rclk(rclk), 
                .rrst_n(rrst_n)
            );
// fsdb
initial begin
    $fsdbDumpfile("top_tb.fsdb");
    $fsdbDumpvars(0, top_tb);
end

endmodule
