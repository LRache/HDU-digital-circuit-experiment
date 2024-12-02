module Fdiv(
    input clk_20M,
    input rst,
    output clk_0_5,
    output clk_1,
    output clk_2,
    output clk_6s
);

    reg [31:0] count_0_5 = 0;
    reg [31:0] count_1   = 0;
    reg [31:0] count_2   = 0;
    reg [31:0] count_6s  = 0;

    reg clk_0_5_reg = 0;
    reg clk_1_reg   = 0;
    reg clk_2_reg   = 0;
    reg clk_6s_reg  = 0;

    // 0.5Hz
    always @(posedge clk_20M or posedge rst) begin
        if (rst) begin
            count_0_5 <= 0;
            clk_0_5_reg <= 0;
        end else begin
            if (count_0_5 == 32'd20_000_000) begin
                count_0_5 <= 0;
                clk_0_5_reg <= ~clk_0_5_reg;
            end else begin
                count_0_5 <= count_0_5 + 1;
            end
        end
    end
    assign clk_0_5 = clk_0_5_reg;

    // 1Hz
    always @(posedge clk_20M or posedge rst) begin
        if (rst) begin
            count_1 <= 0;
            clk_1_reg <= 0;
        end else begin
            if (count_1 == 32'd10_000_000 - 1) begin
                count_1 <= 0;
                clk_1_reg <= ~clk_1_reg;
            end else begin
                count_1 <= count_1 + 1;
            end
        end
    end
    assign clk_1 = clk_1_reg;

    // 2Hz
    always @(posedge clk_20M or posedge rst) begin
        if (rst) begin
            count_2 <= 0;
            clk_2_reg <= 0;
        end else begin
            if (count_2 == 32'd5_000_000) begin
                count_2 <= 0;
                clk_2_reg <= ~clk_2_reg; // 每次计数器满时翻转时钟
            end else begin
                count_2 <= count_2 + 1;
            end
        end
    end
    assign clk_2 = clk_2_reg;

    // 6s
    always @(posedge clk_20M or posedge rst) begin
        if (rst) begin
            count_6s <= 0;
            clk_6s_reg <= 0;
        end else begin
            if (count_6s == 32'd60_000_000) begin
                count_6s <= 0;
                clk_6s_reg <= ~clk_6s_reg; // 每次计数器满时翻转时钟
            end else begin
                count_6s <= count_6s + 1;
            end
        end
    end
    assign clk_6s = clk_6s_reg;

endmodule // Fdiv
