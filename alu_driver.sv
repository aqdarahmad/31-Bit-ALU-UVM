`ifndef ALU_DRIVER_SV
`define ALU_DRIVER_SV
`include "uvm_macros.svh"
import uvm_pkg::*;

class alu_driver extends uvm_driver#(alu_sequence_item);

  // Virtual Interface Declaration
  virtual alu_interface vif;

  // Sequence Item
  alu_sequence_item item;

  // Register class in the factory
  `uvm_component_utils(alu_driver)

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase: get virtual interface
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_interface)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Virtual interface not set for driver");
  endfunction

  // Run phase: get transactions and drive them
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(item);
      drive(item);
      `uvm_info(get_type_name(),
        $sformatf("Driver drove: A=%0d, B=%0d, Opcode=%0h",
                  item.A, item.B, item.Opcode),
        UVM_MEDIUM)
      seq_item_port.item_done();
    end
  endtask

  // Drive task: send signals to DUT
  task drive(alu_sequence_item req);
    @(vif.cb_drv);
    vif.cb_drv.A      <= req.A;
    vif.cb_drv.B      <= req.B;
    vif.cb_drv.Opcode <= req.Opcode;
  endtask

endclass
`endif


