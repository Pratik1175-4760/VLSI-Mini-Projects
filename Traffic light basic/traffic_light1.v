module traffic_light (
    input wire clk,          // Clock (e.g., 50 MHz)
    input wire reset,        // Active-high reset
    output reg [2:0] light   // Output: [RED, YELLOW, GREEN]
);

// Parameters for timer counts (adjust for your clock frequency)
parameter GREEN_TIME = 25;   // 25 clock cycles (simplified)
parameter YELLOW_TIME = 4;  
parameter RED_TIME = 30;     // Red time after green+yellow

// State encoding (best practice: use enumerated types or parameters)
parameter S_GREEN = 2'b00;
parameter S_YELLOW = 2'b01;
parameter S_RED = 2'b10;

reg [1:0] state;            // Current state
reg [5:0] timer;           // Counts clock cycles

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S_GREEN;   // Start in GREEN state
        timer <= 0;
        light <= 3'b001;    // GREEN light ON (LSB = GREEN)
    end
    else begin
        case (state)
            S_GREEN: begin
                if (timer >= GREEN_TIME) begin
                    state <= S_YELLOW;
                    timer <= 0;
                    light <= 3'b010;  // YELLOW
                end
                else timer <= timer + 1;
            end

            S_YELLOW: begin
                if (timer >= YELLOW_TIME) begin
                    state <= S_RED;
                    timer <= 0;
                    light <= 3'b100;  // RED
                end
                else timer <= timer + 1;
            end

            S_RED: begin
                if (timer >= RED_TIME) begin
                    state <= S_GREEN;
                    timer <= 0;
                    light <= 3'b001;  // GREEN
                end
                else timer <= timer + 1;
            end

            default: state <= S_GREEN;  // Fallback
        endcase
    end
end
endmodule