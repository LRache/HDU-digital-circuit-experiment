module Register (
    input  clk,
    input  rst,
    input  [7:0] d,
    input  not_oe,
    output [7:0] q
);
    reg [7:0] register;

    wire oe = ~not_oe;
    assign q = oe ? register : 8'bz;

    always @(posedge clk) begin
        if (rst) begin
            register = 8'h0;
        end else begin
            register = d;
        end
    end
    
endmodule //Register
