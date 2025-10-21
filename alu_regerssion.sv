`ifndef ALU_REGRESSION_TEST_SV
`define ALU_REGRESSION_TEST_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_regression_test extends uvm_test;

  alu_environment alu_environment;

  // Register the test class
  `uvm_component_utils(alu_regression_test)

  function new(string name = "alu_regression_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build environment
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    alu_environment = alu_environment::type_id::create("environment", this);
  endfunction

  // Run all ALU sequences one by one
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // Create and start each sequence type
    alu_add_sequence add_seq = alu_add_sequence::type_id::create("add_seq");
    alu_sub_sequence sub_seq = alu_sub_sequence::type_id::create("sub_seq");
    alu_and_sequence and_seq = alu_and_sequence::type_id::create("and_seq");
    alu_or_sequence  or_seq  = alu_or_sequence ::type_id::create("or_seq");
    alu_xor_sequence xor_seq = alu_xor_sequence::type_id::create("xor_seq");
    alu_overflow_sequence overflow_seq = alu_overflow_sequence::type_id::create("overflow_seq");
    alu_underflow_sequence underflow_seq = alu_underflow_sequence::type_id::create("underflow_seq");
    alu_undefined_opcode_sequence undef_seq = alu_undefined_opcode_sequence::type_id::create("undef_seq");

    // Sequential execution
    add_seq.start(alu_environment.agent.sequencer);
    sub_seq.start(alu_environment.agent.sequencer);
    and_seq.start(alu_environment.agent.sequencer);
    or_seq.start(alu_environment.agent.sequencer);
    xor_seq.start(alu_environment.agent.sequencer);
    overflow_seq.start(alu_environment.agent.sequencer);
    underflow_seq.start(alu_environment.agent.sequencer);
    undef_seq.start(alu_environment.agent.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_type_name(), "End of Regression Testcase", UVM_LOW)
  endtask

endclass : alu_regression_test

`endif

