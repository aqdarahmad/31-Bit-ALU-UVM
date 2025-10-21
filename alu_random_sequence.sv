`ifndef ALU_RANDOM_SEQUENCE_SV
`define ALU_RANDOM_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "alu_sequence_item.sv"

class alu_random_sequence extends uvm_sequence #(alu_sequence_item);
  `uvm_object_utils(alu_random_sequence)

  function new(string name = "alu_random_sequence");
    super.new(name);
  endfunction

  task body();
    alu_sequence_item req;
    req = alu_sequence_item::type_id::create("req");
    
    // Reset transaction
    start_item(req);
    req.rst = 1;
    `uvm_info(get_type_name(), "Resetting DUT...", UVM_LOW)
    finish_item(req);
    #10;

    // Send random transactions
    repeat (10) begin
      start_item(req);
      req.randomize() with { rst == 0; };
      finish_item(req);
      #10;
    end
  endtask
endclass

`endif

