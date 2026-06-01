`ifndef SEQUENCE_LIB__SV
`define SEQUENCE_LIB__SV

// random_data_delay_sequence
class random_data_delay_sequence extends base_sequence;
	`uvm_object_utils(random_data_delay_sequence)

	constraint cstr_random_data_delay {
		soft data0 == -1;	// random data
		soft data1 == -1;	// random data
		soft ndelay == -1; // random delay
	}
	
	function new(string name = "random_data_delay_sequence");
		super.new(name);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH)
	endfunction

	virtual task body();
		`uvm_info(get_type_name(), "start random_data_delay_sequence", UVM_LOW)
		super.body();		
	endtask

endclass

// burst_nodelay_sequence
class burst_nodelay_sequence extends base_sequence;
	`uvm_object_utils(burst_nodelay_sequence)

	constraint cstr_burst {
		soft data0 == -1;	// random data
		soft data1 == -1;	// random data
		soft ndelay == 0;	// no delay
		soft ntrans inside {[50:100]};	// burst length
	}

	function new(string name = "burst_nodelay_sequence");
		super.new(name);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH)
	endfunction

	virtual task body();
		`uvm_info(get_type_name(), "start burst_nodelay_sequence", UVM_LOW)
		super.body();
	endtask

endclass

// order_data_seq
class order_data_seq extends uvm_sequence #(transaction_in);
	`uvm_object_utils(order_data_seq)

	function new (string name = "order_data_seq");
		super.new(name);
	endfunction

	virtual task body();
		transaction_in req;
		
		`uvm_info(get_type_name(), "start order_data_seq", UVM_LOW)

		for (int in_1 = 10; in_1 < 30; in_1++) begin
			for (int in_2 = 0; in_2 < 20; in_2++) begin
				`uvm_create(req)
				
				if (!req.randomize() with {
					data0 == local::in_1;
					data1 == local::in_2;
					ndelay == 1;
				})
					`uvm_fatal(get_type_name(), "req randomize failed")
					
				`uvm_send(req)
			end
		end
	endtask

endclass

`endif