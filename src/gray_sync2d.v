module gray_sync2d #(parameter ADDRSIZE = 4)
    (o_ptr,
    i_ptr,
    des_clk,
    des_rst_n
    );

output [ADDRSIZE:0] o_ptr;
input [ADDRSIZE:0] i_ptr;
input des_clk;
input des_rst_n;

reg [ADDRSIZE:0] o_ptr;
reg [ADDRSIZE:0] temp_ptr;

always @(posedge des_clk or negedge des_rst_n)
    if (!des_rst_n) {o_ptr,temp_ptr} <= 0;
    else {o_ptr,temp_ptr} <= {temp_ptr,i_ptr};

endmodule
