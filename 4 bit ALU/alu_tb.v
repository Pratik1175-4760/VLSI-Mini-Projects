`timescale 1ns / 1ps

module alu_tb();

    // Inputs
    reg signed [3:0] a;
    reg signed [3:0] b;
    reg [2:0] select;

    // Outputs
    wire [3:0] out;
    wire carry, overflow, parity, zero, sign;

    // Instantiate the ALU
    alu uut (
        .a(a),
        .b(b),
        .select(select),
        .out(out),
        .carry(carry),
        .overflow(overflow),
        .parity(parity),
        .zero(zero),
        .sign(sign)
    );

    // Initialize inputs and monitor changes
    initial begin
        // Display header
        $display("Time\tOp\tA\tB\tOut\tCarry\tOverflow\tSign\tZero\tParity");
        $monitor("%4t\t%3d\t%4b\t%4b\t%4b\t%b\t%b\t\t%b\t%b\t%b", 
                $time, select, a, b, out, carry, overflow, sign, zero, parity);

        // Test Addition (select = 0)
        select = 0;
        a = 4'b0111; b = 4'b0001; #10;  // 7 + 1 = -8 (overflow)
        a = 4'b1000; b = 4'b1111; #10;  // -8 + -1 = 7 (no overflow)

        // Test Subtraction (select = 1)
        select = 1;
        a = 4'b0100; b = 4'b0010; #10;  // 4 - 2 = 2
        a = 4'b0000; b = 4'b0001; #10;  // 0 - 1 = -1 (unsigned borrow)

        // Test Multiplication (select = 2)
        select = 2;
        a = 4'b0011; b = 4'b0010; #10;  // 3 * 2 = 6
        a = 4'b1100; b = 4'b0011; #10;  // -4 * 3 = -12 (overflow)

        // Test Division (select = 3)
        select = 3;
        a = 4'b0110; b = 4'b0010; #10;  // 6 / 2 = 3
        a = 4'b1000; b = 4'b1111; #10;  // -8 / -1 = 8 (overflow)
        a = 4'b0110; b = 4'b0000; #10;  // 6 / 0 (division by zero)

        // Test Bitwise AND (select = 4)
        select = 4;
        a = 4'b0101; b = 4'b0011; #10;  // 0101 & 0011 = 0001

        // Test Bitwise OR (select = 5)
        select = 5;
        a = 4'b0101; b = 4'b0011; #10;  // 0101 | 0011 = 0111

        // Test Bitwise XOR (select = 6)
        select = 6;
        a = 4'b0101; b = 4'b0011; #10;  // 0101 ^ 0011 = 0110

        // Test Bitwise NOT (select = 7)
        select = 7;
        a = 4'b0101; #10;               // ~0101 = 1010

        $finish;
    end

endmodule