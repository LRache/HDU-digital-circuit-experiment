module Top(
    input clk,
    input rst,
    input stopa,
    input stopb,
    input start,
    input pause,
    output [6:0] seg_ah,
    output [6:0] seg_al,
    output [6:0] seg_bh,
    output [6:0] seg_bl,
    output reg [2:0] led_a,
    output reg [2:0] led_b
);
    reg [31:0] counter;
    
    typedef enum reg[2:0] { 
        s_1,
        s_2,
        s_3,
        s_4,
        s_idle
    } state_t;
    state_t state;

    reg [3:0] timer_high;
    reg [3:0] timer_low;
    wire timeout = !((|timer_high) & (|timer_low));
    reg running;
    always @(posedge clk) begin
        if (rst) begin
            state <= s_idle;
        end else if (pause || stopa || stopb) begin
            state <= state;
        end else begin 
            if (state == s_idle) begin
                if (start) state <= s_1;
                else state <= s_idle;
            end else if (state == s_1) begin
                if (timeout) state <= s_2;
                else state <= s_1;
            end else if (state == s_2) begin
                if (timeout) state <= s_3;
                else state <= s_2;
            end else if (state == s_3) begin
                if (timeout) state <= s_4;
                else state <= s_3;
            end else begin
                if (timeout) state <= s_1;
                else state <= s_4;
            end
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            counter <= '0;
        end else if (pause || stopa || stopb) begin
            counter <= counter;
        end else if (timeout) begin
            counter <= '0;
        end else if (counter == 32'd10_000_000) begin
            counter <= '0;
        end else begin
            counter <= counter + 32'd1;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            timer_high <= 4'd0;
            timer_low  <= 4'd0;
        end else if (state == s_idle & start) begin
            timer_high <= 4'd3;
            timer_low  <= 4'd5;
        end else if (state == s_1 & timeout) begin
            timer_high <= 4'd0;
            timer_low  <= 4'd5;
        end else if (state == s_2 & timeout) begin
            timer_high <= 4'd2;
            timer_low  <= 4'd5;
        end else if (state == s_3 & timeout) begin
            timer_high <= 4'd0;
            timer_low  <= 4'd5;
        end else if (state == s_4 & timeout) begin
            timer_high <= 4'd3;
            timer_low  <= 4'd5;
        end else if (counter == 32'd10_000_000) begin
            timer_high <= timer_low == '0 ? (timer_high - 4'd1) : timer_high;
            timer_low  <= timer_low == '0 ? 4'd9 : (timer_low  - 4'd1);
        end
    end

    wire stop = stopa || stopb;
    BCD7Seg seg0 (
        .digit (stop ? 4'ha : timer_high),
        .seg   (seg_ah)
    );

    BCD7Seg seg1 (
        .digit (stop ? 4'ha : timer_low),
        .seg   (seg_al)
    );

    BCD7Seg seg2 (
        .digit (stop ? 4'ha : timer_high),
        .seg   (seg_bh)
    );

    BCD7Seg seg3 (
        .digit (stop ? 4'ha : timer_low),
        .seg   (seg_bl)
    );

    // red green yellow
    always @(*) begin
        case (state)
            s_1: begin
                led_a = 3'b010;
                led_b = 3'b100;
            end
            s_2: begin
                led_a = 3'b001;
                led_b = 3'b100;
            end
            s_3: begin
                led_a = 3'b100;
                led_b = 3'b010;
            end
            s_4: begin
                led_a = 3'b100;
                led_b = 3'b001;
            end
            default: 
        endcase
    end
    
endmodule //Top
