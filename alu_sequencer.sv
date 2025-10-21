`ifndef ALU_SEQUENCER_SV
`define ALU_SEQUENCER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "alu_sequence_item.sv"

class alu_sequencer extends uvm_sequencer #(alu_sequence_item);
  `uvm_component_utils(alu_sequencer)

  // Constructor
  function new(string name = "alu_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

endclass : alu_sequencer

`endif

