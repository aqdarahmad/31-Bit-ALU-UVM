`ifndef ALU_UNDEFINED_OPCODE_SEQUENCE_SV
`define ALU_UNDEFINED_OPCODE_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "alu_sequence_item.sv"

class alu_undefined_opcode_sequence extends uvm_sequence #(alu_sequence_item);
  `uvm_object_utils(alu_undefined_opcode_sequence)

  function new(string name = "alu_undefined_opcode_sequence");
    super.new(name);
  endfunction

  task body();
    alu_sequence_item req = alu_sequence_item::type_id::create("req");

    start_item(req);
    req.randomize() with {
      rst == 0;
      Opcode inside {[3'b101:3'b111]}; // Undefined range
    };
    finish_item(req);
    #10;
  endtask
endclass

`endif

