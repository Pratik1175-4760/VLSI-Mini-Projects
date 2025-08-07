`timescale 1ns / 1ps

module tb_lemming;

    // Inputs
    reg clk;
    reg areset;
    reg bump_left;
    reg bump_right;
    reg ground;
    reg dig;

    // Outputs
    wire walk_left;
    wire walk_right;
    wire aaah;
    wire digging;

    // Instantiate the DUT
    top_module uut (
        .clk(clk),
        .areset(areset),
        .bump_left(bump_left),
        .bump_right(bump_right),
        .ground(ground),
        .dig(dig),
        .walk_left(walk_left),
        .walk_right(walk_right),
        .aaah(aaah),
        .digging(digging)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns period

    initial begin
        $display("=== Lemming FSM Simulation ===");
        $monitor("T=%0t | State: walk_left=%b walk_right=%b dig=%b aaah=%b | Inputs: ground=%b bump_l=%b bump_r=%b dig_in=%b", 
            $time, walk_left, walk_right, digging, aaah, ground, bump_left, bump_right, dig);

        clk = 0;
        areset = 1;
        bump_left = 0;
        bump_right = 0;
        ground = 1;
        dig = 0;

        // Reset pulse
        #12;
        areset = 0;

        // Default state: walking left
        #20;

        // Bump into left wall → should go right
        bump_left = 1; #10;
        bump_left = 0; #20;

        // Bump into right wall → should go left
        bump_right = 1; #10;
        bump_right = 0; #20;

        // Start digging (valid only when ground = 1)
        dig = 1; #10;
        dig = 0; #20;

        // Fall begins
        ground = 0;
        #10;

        // 🔴 Dig while falling - should have NO effect
        dig = 1;
        #10;
        dig = 0;
        #10;

        // 🔴 Apply bumps while falling - should have NO effect
        bump_left = 1;
        bump_right = 1;
        #20;
        bump_left = 0;
        bump_right = 0;

        // Wait enough to trigger SPLAT (if over 20 clocks in air)
        repeat (21) @(posedge clk);
        #10;

        // Reapply ground - no effect in SPLAT state
        ground = 1;
        #20;

        $display("=== Simulation Complete ===");
        $finish;
    end

endmodule
