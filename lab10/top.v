module Top(
    input  clk,
    input  rst,
    input  [1:0]sel,
    output reg dout
);
    wire clk_0_5;
    wire clk_1;
    wire clk_2;
    wire clk_6s;
    Fdiv fdiv(
        .clk_20M    (clk_20M),
        .clk_0_5    (clk_0_5),
        .clk_1      (clk_1),
        .clk_2      (clk_2),
        .clk_6s     (clk_6s),
    );

    always @(*) begin
        if (rst) begin
            dout <= 0;
        end
        case (sel)
            2'b00: dout <= clk_0_5;
            2'b01: dout <= clk_1;
            2'b10: dout <= clk_2;
            2'b11: dout <= clk_6s;
            default: dout <= 0;
        endcase
    end
    
endmodule //Top
