`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;



`include "alu_environment.sv"
`include "alu_random_test.sv"

module alu_testbench;

  // Clock and reset signals
  logic clk;
  logic rst;

  // Clock generation: 10 time units period
  always #5 clk = ~clk;

  // Reset generation
  initial begin
    clk = 0;
    rst = 0;
    #1;
    rst = 1;
    #1;
    rst = 0;
  end

  // Instantiate the interface
  alu_interface intf(.clk(clk), .rst(rst));

  // Instantiate the DUT and connect to interface
  alu dut (
    .clk(clk),
    .rst(rst),
    .A(intf.A),
    .B(intf.B),
    .Opcode(intf.Opcode),
    .Result(intf.Result),
    .Error(intf.Error)
  );

  // Set virtual interface in UVM config DB
  initial begin
    uvm_config_db#(virtual alu_interface)::set(uvm_root::get(), "*", "vif", intf);
  end

  // Enable waveform dumping for debugging
  initial begin
 
  $dumpfile("debug.vcd");
  $dumpvars(0, alu_testbench);


 //   $fsdbDumpfile("debug.fsdb"); // Output waveform file
   // $fsdbDumpvars;
   // $fsdbDumpvars("+mda");
   // $fsdbDumpvars("+struct");
    //$fsdbDumpvars("+all");
    //$fsdbDumpon;
  end

  // Run the UVM test
  initial begin
    run_test("alu_random_test"); // Test name must match your test class
  end

endmodule

