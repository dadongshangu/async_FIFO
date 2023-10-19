module async_fifo #(parameter DSIZE = 8,
                    parameter ASIZE = 4)
            (
                rdata,
                wfull,
                rempty,
                wdata,
                winc, 
                wclk, 
                wrst_n,
                rinc, 
                rclk, 
                rrst_n
            );
output [DSIZE-1:0]  rdata;
output              wfull;
output              rempty;

input [DSIZE-1:0]   wdata;
input               winc;
input               wclk;
input               wrst_n;

input               rinc;
input               rclk;
input               rrst_n;

wire [ASIZE-1:0]    waddr;
wire [ASIZE-1:0]    raddr;
wire [ASIZE:0]      wptr;
wire [ASIZE:0]      rptr;
wire [ASIZE:0]      wq2_rptr;
wire [ASIZE:0]      rq2_wptr;

gray_sync2d #(ASIZE) sync_r2w (
    .o_ptr(wq2_rptr), 
    .i_ptr(rptr),
    .des_clk(wclk), 
    .des_rst_n(wrst_n)
);

gray_sync2d #(ASIZE) sync_w2r (
    .o_ptr(rq2_wptr), 
    .i_ptr(wptr),
    .des_clk(rclk), 
    .des_rst_n(rrst_n)
);

fifomem #(DSIZE, ASIZE) fifomem (
    .rdata(rdata), 
    .wdata(wdata),
    .waddr(waddr), 
    .raddr(raddr),
    .wclken(winc), 
    .wfull(wfull),
    .wclk(wclk)
);

rptr_empty #(ASIZE) rptr_empty(
    .rempty(rempty),
    .raddr(raddr),
    .rptr(rptr), 
    .rq2_wptr(rq2_wptr),
    .rinc(rinc), 
    .rclk(rclk),
    .rrst_n(rrst_n)
);

wptr_full #(ASIZE) wptr_full (
    .wfull(wfull), 
    .waddr(waddr),
    .wptr(wptr), 
    .wq2_rptr(wq2_rptr),
    .winc(winc), 
    .wclk(wclk),
    .wrst_n(wrst_n)
);

endmodule
