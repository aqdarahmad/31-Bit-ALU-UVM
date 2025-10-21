`ifndef ALU_SCOREBOARD_SV
`define ALU_SCOREBOARD_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

// Include sequence item
`include "alu_sequence_item.sv"

class alu_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(alu_scoreboard)

  uvm_analysis_imp#(alu_sequence_item, alu_scoreboard) exp;

  function new(string name = "alu_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    exp = new("exp", this);
  endfunction

  // Example write method
  function void write(alu_sequence_item t);
    // Implement scoreboard check logic here
    `uvm_info(get_type_name(), $sformatf("Received transaction: A=%0d, B=%0d, Opcode=%0b", t.A, t.B, t.Opcode), UVM_LOW)
  endfunction

endclass : alu_scoreboard

`endif
