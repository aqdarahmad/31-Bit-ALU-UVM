`ifndef ALU_MONITOR_SV
`define ALU_MONITOR_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_monitor extends uvm_monitor;

  // Virtual Interface
  virtual alu_interface vif;

  // Analysis Port for sending transactions
  uvm_analysis_port#(alu_sequence_item) port;

  // Sequence item to store sampled data
  alu_sequence_item item;

  // Register class in the factory
  `uvm_component_utils(alu_monitor)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
    port = new("port", this);
  endfunction

  // Build phase: get virtual interface
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_interface)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Virtual interface not set for monitor");
  endfunction

  // Run phase: sample signals and send to scoreboard
  task run_phase(uvm_phase phase);
    `uvm_info("MONITOR", "Monitor started", UVM_LOW)
    forever begin
      item = alu_sequence_item::type_id::create("item", this);
      wait(!vif.rst);

      // Sample inputs
      @(posedge vif.clk);
      item.A      = vif.A;
      item.B      = vif.B;
      item.Opcode = vif.Opcode;

      // Sample outputs
      @(posedge vif.clk);
      item.Result   = vif.Result;
      item.Overflow = vif.Overflow;
      item.Underflow = vif.Underflow;

      // Send to scoreboard
      port.write(item);

      `uvm_info("MONITOR",
        $sformatf("Sampled: A=%0d, B=%0d, Opcode=%0h, Result=%0d, Overflow=%0b, Underflow=%0b",
                  item.A, item.B, item.Opcode, item.Result, item.Overflow, item.Underflow),
        UVM_MEDIUM)
    end
  endtask

endclass
`endif

