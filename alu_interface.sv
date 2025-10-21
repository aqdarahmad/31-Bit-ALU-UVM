`timescale 1ns/1ps
interface alu_interface(input logic clk, rst);

  // Input and output signals
  logic signed [31:0] A;       // Operand 1
  logic signed [31:0] B;       // Operand 2
  logic [2:0] Opcode;          // Operation code
  logic signed [31:0] Result;  // Output result
  logic Overflow;              // Overflow flag
  logic Underflow;  
   logic Error;           // Underflow flag

  // ----------------------------
  // Clocking block for DRIVER
  // ----------------------------
  clocking cb_drv @(negedge clk);
    default input #1 output #0;
    output A;
    output B;
    output Opcode;
  endclocking

  // ----------------------------
  // Clocking block for MONITOR
  // ----------------------------
  clocking cb_mon @(posedge clk);
    default input #0 output #1;
    input A;
    input B;
    input Opcode;
    input Result;
    input Overflow;
    input Underflow;
  endclocking

  // ----------------------------
  // Modports
  // ----------------------------
  modport drv (clocking cb_drv, input clk, input rst);
  modport mon (clocking cb_mon, input clk, input rst);

endinterface

