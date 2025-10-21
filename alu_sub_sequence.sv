`ifndef ALU_SUB_SEQUENCE_SV
`define ALU_SUB_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "alu_sequence_item.sv"

class alu_sub_sequence extends uvm_sequence #(alu_sequence_item);
  `uvm_object_utils(alu_sub_sequence)

  function new(string name = "alu_sub_sequence");
    super.new(name);
  endfunction

  task body();
    alu_sequence_item req = alu_sequence_item::type_id::create("req");

    start_item(req);
    req.randomize() with {
      rst == 0;
      Opcode == 3'b001; // SUB
    };
    finish_item(req);
    #10;
  endtask
endclass

`endif

