module Mux83 (
    input a,
    input b,
    input c,

    input g1,
    input not_g2a,
    input not_g2b,

    output reg [7:0] not_y
);

    wire [2:0] select = {c, b, a};
    always @(*) begin
        if (g1 == 1'b0 || not_g2a || not_g2b) begin
            not_y = 8'b11111111;
        end else begin
            case (select)
                3'b000 : not_y = 8'b11111110;
                3'b001 : not_y = 8'b11111101;
                3'b010 : not_y = 8'b11111011;
                3'b011 : not_y = 8'b11110111;
                3'b100 : not_y = 8'b11101111;
                3'b101 : not_y = 8'b11011111;
                3'b110 : not_y = 8'b10111111;
                default: not_y = 8'b01111111;
            endcase
        end
    end
    
endmodule