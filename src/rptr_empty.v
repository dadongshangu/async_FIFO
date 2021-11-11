module rptr_empty #(parameter ADDRSIZE = 4)
    (rempty,
     raddr,
     rptr,
     rq2_wptr,
     rinc, 
     rclk, 
     rrst_n
    );

output                  rempty;
output [ADDRSIZE-1:0]   raddr;
output [ADDRSIZE :0]    rptr;
input [ADDRSIZE :0]     rq2_wptr;
input                   rinc;
input                   rclk;
input                   rrst_n;

reg [ADDRSIZE:0]        rbin;
wire                    rempty_val;
reg                     rempty;
reg [ADDRSIZE :0]       rptr;
wire [ADDRSIZE:0]       rgraynext;
wire [ADDRSIZE:0]       rbinnext;

//-------------------
// GRAYSTYLE2 pointer
//-------------------
always @(posedge rclk or negedge rrst_n)
    if (!rrst_n) {rbin, rptr} <= 0;
    else {rbin, rptr} <= {rbinnext, rgraynext};
// Memory read-address pointer (okay to use binary to address memory)
assign raddr = rbin[ADDRSIZE-1:0];
assign rbinnext = rbin + (rinc & ~rempty);
assign rgraynext = (rbinnext>>1) ^ rbinnext;

//---------------------------------------------------------------
// FIFO empty when the next rptr == synchronized wptr or on reset
//---------------------------------------------------------------
assign rempty_val = (rgraynext == rq2_wptr);

always @(posedge rclk or negedge rrst_n)
    if (!rrst_n) rempty <= 1'b1;
    else rempty <= rempty_val;

endmodule
