//`timescale 1ns/1ps

`include "uvm_macros.svh"
`include "env_pkg.sv"

import uvm_pkg::*;
import env_pkg::*;

`include "interface.sv"
`include "base_test.sv"
`include "test_lib.sv"

module tb_top;

	logic clk;
	logic rst_n;
	
	parameter simulation_cycle = 100;		// 100ns: clk=10MHz

	interface_in	input_if	(clk, rst_n);
	interface_out output_if	(clk, rst_n);

	adder u_dut(
			.clk      	(clk),
			.rst_n    	(rst_n),
			.in_valid 	(input_if.valid_i),
			.data_in0 	(input_if.data0),
			.data_in1 	(input_if.data1),
			.out_valid	(output_if.valid_o),
			.data_out 	(output_if.result)
	);

	// CLOCK generation
	initial begin
			clk = 0;
			forever
					#(simulation_cycle/2) clk = ~clk;	// 10MHz
	end

	// RESET trigger
	initial begin
			rst_n <= 1'b0;
			repeat(5) @(posedge clk);
			rst_n <= 1'b1;
	end

	initial begin
			// set the format for time display
			$timeformat(-9, 2, "ns", 10);      
			
			// Interface configuration from tb_top (HW) to verification env (SW)
			uvm_config_db #(virtual interface_in )::set(null, "uvm_test_top.env.i_agt.drv", "vif", input_if);
			uvm_config_db #(virtual interface_in )::set(null, "uvm_test_top.env.i_agt.mon", "vif", input_if);
			uvm_config_db #(virtual interface_out)::set(null, "uvm_test_top.env.o_agt.mon", "vif", output_if);
			run_test();
	end


	// Dump fsdb
	`ifdef DUMP_FSDB
	initial begin : FSDB_generation
		string testname;
		
		$display("DUMP FSDB START!");
		if ($value$plusargs("UVM_TESTNAME=%s", testname) && testname != "") begin
			$fsdbDumpfile({testname, "_sim_dir/", testname, ".fsdb"});
		end else begin
			$fsdbDumpfile("tb.fsdb");
		end
		
		$fsdbDumpvars(0, tb_top);
		$fsdbDumpvars(0, tb_top.u_dut);
	end
	`endif
	
endmodule
