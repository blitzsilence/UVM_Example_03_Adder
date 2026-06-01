`ifndef TEST_LIB__SV
`define TEST_LIB__SV

// random_data_delay_test
class random_data_delay_test extends base_test;
	`uvm_component_utils(random_data_delay_test)
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	extern virtual task main_phase (uvm_phase phase);
endclass

task random_data_delay_test::main_phase (uvm_phase phase);
	random_data_delay_sequence seq;
	
	phase.raise_objection(this);
	seq = random_data_delay_sequence::type_id::create("seq");
	
	if (!seq.randomize())
		`uvm_fatal(get_type_name(), "sequence randomize failed")		
		
	seq.start(env.i_agt.sqr);
	phase.drop_objection(this);

endtask

// burst_data_test
class burst_data_test extends base_test;
	`uvm_component_utils(burst_data_test)
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	extern virtual task main_phase (uvm_phase phase);
endclass

task burst_data_test::main_phase (uvm_phase phase);
	burst_nodelay_sequence seq;
	
	phase.raise_objection(this);
	seq = burst_nodelay_sequence::type_id::create("seq");
	
	if (!seq.randomize())
		`uvm_fatal(get_type_name(), "sequence randomize failed")		
		
	seq.start(env.i_agt.sqr);
	phase.drop_objection(this);
endtask

// order_data_test
class order_data_test extends base_test;
	`uvm_component_utils(order_data_test)
	
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	extern virtual task main_phase (uvm_phase phase);
endclass

task order_data_test::main_phase (uvm_phase phase);
	order_data_seq seq;
	
	phase.raise_objection(this);
	seq = order_data_seq::type_id::create("seq");
	seq.start(env.i_agt.sqr);
	phase.drop_objection(this);
endtask

`endif