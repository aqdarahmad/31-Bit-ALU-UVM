`ifndef ALU_AGENT_SV
`define ALU_AGENT_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

// Ensure these files exist and are included in compile list
`include "alu_driver.sv"
`include "alu_sequencer.sv"
`include "alu_monitor.sv"

class alu_agent extends uvm_agent;

  `uvm_component_utils(alu_agent)

  // Component handles
  alu_driver    driver;
  alu_sequencer sequencer;
  alu_monitor   monitor;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = alu_sequencer::type_id::create("sequencer", this);
    driver    = alu_driver::type_id::create("driver", this);
    monitor   = alu_monitor::type_id::create("monitor", this);
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction

endclass : alu_agent

`endif
