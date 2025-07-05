`timescale 1ns / 1ps

// In this, both signed and unsigned numbers are considered.
// Carry is for if a and b are unsigned and overflow is for if a and b are signed.
module alu(
    input signed [3:0] a,
    input signed [3:0] b,
    input [2:0] select,
    output reg [3:0] out,
    output reg carry,
    output reg overflow,
    output reg parity,
    output reg zero,
    output reg sign
);
    reg [4:0] temp;
    
    always @(*) begin
        temp = 0;
        carry = 0;
        overflow = 0;
        
        case(select)
            0: begin  // Addition
                temp = a + b;
                out = temp[3:0];
                carry = temp[4];
                overflow = (a[3] == b[3]) && (out[3] != a[3]);
            end
            1: begin  // Subtraction
                temp = a - b;
                out = temp[3:0];
                carry = (a < b);  // Unsigned borrow
                overflow = (a[3] != b[3]) && (out[3] != a[3]);
               end
            2: begin  // Multiplication
                temp = a * b;
                out = temp[3:0];
                overflow = (temp < -8) || (temp > 7);  // Signed overflow
                carry = (temp > 15);                  // Unsigned overflow
               end
            3: begin  // Division
               if (b == 0) begin
               overflow = 1;  // Division by zero
               end else begin
               temp = a / b;
               overflow = (a == -8) && (b == -1);  // Only -8/-1 overflows
               end
                carry = 0;
            end
            4: out = a & b;  // AND
            5: out = a | b;  // OR
            6: out = a ^ b;  // XOR
            7: out = ~a;     // NOT
        endcase

        // Update flags (for all operations)
        zero = (out == 0);
        sign = out[3];
        parity = ~^out;  // Even parity
    end
endmodule