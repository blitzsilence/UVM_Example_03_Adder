`ifndef BASE_TEST__SV
`define BASE_TEST__SV

class base_test extends uvm_test;
	`uvm_component_utils(base_test)
	
	my_env env;
	
	function new(string name = "base_test", uvm_component parent = null);
			super.new(name, parent);
	endfunction

	extern virtual function void build_phase (uvm_phase phase);
	extern virtual function void end_of_elaboration_phase ( uvm_phase phase);
	extern virtual task main_phase (uvm_phase phase);
	extern virtual function void report_phase (uvm_phase phase);
endclass

function void base_test::build_phase (uvm_phase phase);
	super.build_phase(phase);
	
	env = my_env::type_id::create("env", this);
endfunction

function void base_test::end_of_elaboration_phase (uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
endfunction

task base_test::main_phase (uvm_phase phase);
	base_sequence seq;
	
	phase.raise_objection(this);
	seq = base_sequence::type_id::create("seq");
	`uvm_info(get_type_name(), "start base_sequence", UVM_HIGH)
	
	if (!seq.randomize())
		`uvm_fatal(get_type_name(), "sequence randomize failed")		
		
	seq.start(env.i_agt.sqr);
	phase.drop_objection(this);
endtask

function void base_test::report_phase (uvm_phase phase);
	uvm_report_server server;
	int err_num;
	string testname;
	
	super.report_phase(phase);
	
	$value$plusargs("TESTNAME=%s", testname);

	server = get_report_server();
	err_num =  server.get_severity_count(UVM_WARNING) + server.get_severity_count(UVM_ERROR) + server.get_severity_count(UVM_FATAL);

	if (err_num != 0) begin
			$display("==================================================");
			$display("%s testcase Failed!", testname);
			$display("==================================================");
	end
	else begin
			$display("==================================================");
			$display("%s testcase Passed!", testname);
			$display("==================================================");
	end

endfunction

`endif 


 
