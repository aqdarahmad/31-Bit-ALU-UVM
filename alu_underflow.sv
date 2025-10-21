`ifndef ALU_UNDERFLOW_SEQUENCE_SV
`define ALU_UNDERFLOW_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "alu_sequence_item.sv"

class alu_underflow_sequence extends uvm_sequence #(alu_sequence_item);
  `uvm_object_utils(alu_underflow_sequence)

  function new(string name = "alu_underflow_sequence");
    super.new(name);
  endfunction

  task body();
    alu_sequence_item req = alu_sequence_item::type_id::create("req");

    start_item(req);
    req.randomize() with {
      rst == 0;
      Opcode == 3'b001;           // SUB
      A == 32'sh80000000;         // Min negative number
      B == 32'sh00000001;         // -1 causes underflow
    };
    finish_item(req);
    #10;
  endtask
endclass

`endif

