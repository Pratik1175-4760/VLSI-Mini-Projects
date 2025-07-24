module tb_traffic_light();
    reg clk, reset;
    wire [2:0] light;

    traffic_light uut (clk, reset, light);

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1;
        #10 reset = 0;  // Release reset
        #500 $finish;   // Run for 500 ns
    end
endmodule