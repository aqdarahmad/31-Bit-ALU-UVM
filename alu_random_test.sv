`ifndef ALU_RANDOM_TEST_SV
`define ALU_RANDOM_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "alu_environment.sv"
`include "alu_sequence.sv"

class alu_random_test extends uvm_test;

  `uvm_component_utils(alu_random_test)

  // Components
  alu_environment env;
  alu_sequence seq;

  // Constructor
  function new(string name = "alu_random_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase: create environment
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = alu_environment::type_id::create("env", this);
  endfunction

  // Run phase: execute sequence
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = alu_sequence::type_id::create("seq");
    repeat(500) begin
      seq.start(env.agent.sequencer);
    end
    phase.drop_objection(this);
    `uvm_info(get_type_name(), "End of Random Testcase", UVM_LOW)
  endtask

endclass : alu_random_test

`endif
