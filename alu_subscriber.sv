`ifndef ALU_SUBSCRIBER_SV
`define ALU_SUBSCRIBER_SV


`include "uvm_macros.svh"
import uvm_pkg::*;

// Subscriber class
class alu_subscriber extends uvm_subscriber #(alu_sequence_item);

  `uvm_component_utils(alu_subscriber)


  
  
  
  alu_sequence_item sub;


function new(string name,uvm_component parent);
  super.new(name,parent);
 // aluCoverage = new();
  sub = new();
endfunction

covergroup aluCoverage;
  A: coverpoint sub.A;
  B: coverpoint sub.B;
  Opcode: coverpoint sub.Opcode ;
  Result: coverpoint sub.Result;
  Error: coverpoint sub.Error;
endgroup

function void write (alu_sequence_item t);
  sub.A = t.A;
  sub.B = t.B;
  sub.Opcode = t.Opcode;
  sub.Result = t.Reset;
  sub.Error = t.Error;
  aluCoverage.sample();
endfunction

function void report_phase(uvm_phase phase);
  super.report_phase(phase);
  `uvm_info(get_type_name, 
  $sformatf("coverage: %d",aluCoverage.get_coverage()),
  UVM_HIGH);
endfunction


endclass


`endif
