`ifndef ALU_SEQUENCE_ITEM_SV
`define ALU_SEQUENCE_ITEM_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

// ------------------------------------------------------
// ALU Sequence Item
// ------------------------------------------------------
class alu_sequence_item extends uvm_sequence_item;

  // Group: Variables
  rand logic rst;                       // Reset signal
  rand logic signed [31:0] A;           // Operand 1
  rand logic [31:0] B;                   // Operand 2
  rand logic [2:0] Opcode;              // Operation code

  logic signed [31:0] Result;           // Output result
  logic Reset, Overflow, Underflow, Error;  // Flags

  // Register all fields with UVM factory and print/compare automation
  `uvm_object_utils_begin(alu_sequence_item)
    `uvm_field_int(rst, UVM_ALL_ON)
    `uvm_field_int(A, UVM_ALL_ON)
    `uvm_field_int(B, UVM_ALL_ON)
    `uvm_field_int(Opcode, UVM_ALL_ON)
    `uvm_field_int(Result, UVM_ALL_ON)
    `uvm_field_int(Reset, UVM_ALL_ON)
    `uvm_field_int(Overflow, UVM_ALL_ON)
    `uvm_field_int(Underflow, UVM_ALL_ON)
    `uvm_field_int(Error, UVM_ALL_ON)
  `uvm_object_utils_end

  // Constructor
  function new(string name = "alu_sequence_item");
    super.new(name);
  endfunction

endclass : alu_sequence_item

`endif
