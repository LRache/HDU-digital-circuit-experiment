module Shifter(
    input  clk,
    input  rst,
    input  [1:0] s,
    input  sr,
    input  sl,
    input  [7:0] d,
    output [7:0] q
);

    reg [7:0] register;

    assign q = register;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            register = 8'b0;
        end else if (s == 2'b00) begin
            register = register;
        end else if (s == 2'b01) begin
            register = {sr, register[6:0]};
        end else if (s == 2'b10) begin
            register = {register[6:0], sl};
        end else begin
            register = d;
        end
    end
    
endmodule //Shifter
