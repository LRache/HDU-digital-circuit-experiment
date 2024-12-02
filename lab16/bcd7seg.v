module BCD7Seg (
    input  [3:0] digit,
    output [6:0] seg
);
    reg [6:0] seg_reg;
    always @(*) begin
        case (digit)
            4'd0: seg_reg = 7'b1011111;
            4'd1: seg_reg = 7'b0000110;
            4'd2: seg_reg = 7'b1011011;
            4'd3: seg_reg = 7'b1001111;
            4'd4: seg_reg = 7'b1100110;
            4'd5: seg_reg = 7'b1101101;
            4'd6: seg_reg = 7'b1111101;
            4'd7: seg_reg = 7'b0000111;
            4'd8: seg_reg = 7'b1111111;
            4'd9: seg_reg = 7'b1101111;
            default: seg_reg =7'b0000000; 
        endcase
    end
    
endmodule //BCD7Seg
