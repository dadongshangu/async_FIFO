`ifndef ASYNCF_IF__SV
`define ASYNCF_IF__SV

interface up_if(input wclk, input wrst_n);

   logic [7:0] wdata;
   logic winc;
   logic wfull;
endinterface

interface down_if(input rclk, input rrst_n);

   logic [7:0] rdata;
   logic rinc;
   logic rempty;
endinterface
`endif //ASYNCF_IF__SV
