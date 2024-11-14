module Priority (
    input  wire not_en,
    input  wire [7:0] i,
    output reg  [2:0] y,
    output wire done
);
    assign done = (~(|i)) & not_en;

    always @(*) begin
        if (!not_en) begin
            y = 3'b000;
        end else if (i[0] == 1'b1) begin
            y = 3'h0;
        end else if (i[1] == 1'b1) begin
            y = 3'h1;
        end else if (i[2] == 1'b1) begin
            y = 3'h2;
        end else if (i[3] == 1'b1) begin
            y = 3'h3;
        end else if (i[4] == 1'b1) begin
            y = 3'h4;
        end else if (i[5] == 1'b1) begin
            y = 3'h5;
        end else if (i[6] == 1'b1) begin
            y = 3'h6;
        end else begin
            y = 3'h7;
        end
    end
    
endmodule //priority
