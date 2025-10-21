`ifndef ALU_ENVIRONMENT_SV
`define ALU_ENVIRONMENT_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

// Include the dependent files
`include "alu_agent.sv"
`include "alu_scoreboard.sv"
`include "alu_subscriber.sv"

class alu_environment extends uvm_env;

  `uvm_component_utils(alu_environment)

  // Component handles
  alu_agent       agent;
  alu_scoreboard  scoreboard;
  alu_subscriber  subscriber;

  // Constructor
  function new(string name = "alu_environment", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent       = alu_agent::type_id::create("agent", this);
    scoreboard  = alu_scoreboard::type_id::create("scoreboard", this);
    subscriber  = alu_subscriber::type_id::create("subscriber", this);
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.port.connect(scoreboard.exp);
    agent.monitor.port.connect(subscriber.analysis_export);
  endfunction

endclass : alu_environment

`endif
