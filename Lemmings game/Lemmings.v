module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging 
); 
    
    parameter LEFT = 3'd0, RIGHT = 3'd1, LEFT_FALL = 3'd2, RIGHT_FALL = 3'd3, 
              LEFT_DIG = 3'd4, RIGHT_DIG = 3'd5, SPLATTER = 3'd6;

    reg [2:0] state, next_state;
    reg [7:0] count_20_clk;
    
    // Reset & state logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end
    
    // Next state logic (formatted)
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = LEFT_FALL;
                else if (dig)
                    next_state = LEFT_DIG;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end

            RIGHT: begin
                if (!ground)
                    next_state = RIGHT_FALL;
                else if (dig)
                    next_state = RIGHT_DIG;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end

            LEFT_FALL: begin
                if (!ground)
                    next_state = LEFT_FALL;
                else if (count_20_clk > 8'd20)
                    next_state = SPLATTER;
                else
                    next_state = LEFT;
            end

            RIGHT_FALL: begin
                if (!ground)
                    next_state = RIGHT_FALL;
                else if (count_20_clk > 8'd20)
                    next_state = SPLATTER;
                else
                    next_state = RIGHT;
            end

            LEFT_DIG: begin
                if (ground)
                    next_state = LEFT_DIG;
                else
                    next_state = LEFT_FALL;
            end

            RIGHT_DIG: begin
                if (ground)
                    next_state = RIGHT_DIG;
                else
                    next_state = RIGHT_FALL;
            end

            SPLATTER: next_state = SPLATTER;

            default: next_state = LEFT;
        endcase
    end
    
    // 20-cycle fall counter
    always @(posedge clk) begin 
        if (areset)
            count_20_clk <= 8'd0;
        else if (!ground)
            count_20_clk <= count_20_clk + 8'd1;
        else
            count_20_clk <= 8'd0;
    end
                    
    // Output logic
    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == LEFT_FALL || state == RIGHT_FALL);
    assign digging    = (state == LEFT_DIG || state == RIGHT_DIG);

endmodule
