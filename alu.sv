`timescale 1ns/1ps
module alu (
    input logic clk,
    input logic rst,
    input logic signed [31:0] A,       // operand 1
    input logic [31:0] B,              // operand 2
    input logic [2:0] Opcode,          // opcode
    output logic [31:0] Result,        // result
    output logic Error                  // error flag for overflow
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        Result <= 32'b0;
        Error <= 1'b0;
    end else begin
        case (Opcode)
            3'b000: begin // Addition
                Result <= A + B;
                if ((A > 0 && B > 0 && Result < 0) || (A < 0 && B < 0 && Result > 0))
                    Error <= 1;
                else
                    Error <= 0;
            end
            3'b001: begin // Subtraction
                Result <= A - B;
                if ((A < 0 && B > 0 && Result > A) || (A > 0 && B < 0 && Result < A))
                    Error <= 1;
                else
                    Error <= 0;
            end
            3'b010: Result <= A & B; // AND
            3'b011: Result <= A | B; // OR
            3'b100: Result <= A ^ B; // XOR
            default: begin
                Result <= 32'b0;
                Error <= 1;
            end
        endcase
    end
end

endmodule
