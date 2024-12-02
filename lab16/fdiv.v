module Fdiv(
    input clk_20M,
    input rst,
    output clk_1
);
    reg [31:0] count_1 = 0;
    reg clk_1_reg = 0;

    // 1Hz
    always @(posedge clk_20M or posedge rst) begin
        if (rst) begin
            count_1 <= 0;
            clk_1_reg <= 0;
        end else begin
            if (count_1 == 32'd100_000) begin
                count_1 <= 0;
                clk_1_reg <= ~clk_1_reg;
            end else begin
                count_1 <= count_1 + 1;
            end
        end
    end
    assign clk_1 = clk_1_reg;
endmodule // Fdiv