`ifndef BASE_SEQUENCE__SV
`define BASE_SEQUENCE__SV

class base_sequence extends uvm_sequence #(transaction_in);
	`uvm_object_utils(base_sequence)

	rand int data0  = -1;
	rand int data1  = -1;
	rand int ndelay = -1;
	rand int ntrans = 10;
	
	constraint cstr_base {
			soft data0  == -1;
			soft data1  == -1;
			soft ndelay == 1;
					 ntrans inside {[1:50]};	// at least 1 transaction
	}

	function new(string name = "base_sequence");
		super.new(name);
		`uvm_info("TRACE", $sformatf("%m"), UVM_HIGH)
	endfunction

	virtual task body();
		transaction_in req;
		
		`uvm_info("SEQ", $sformatf("send %0d transaction(s)", ntrans), UVM_LOW)

		repeat(ntrans) begin
			`uvm_create(req)

			if (!req.randomize() with {
					local::data0 >= 0 -> data0 == local::data0;
					local::data1 >= 0 -> data1 == local::data1;
					local::ndelay >= 0 -> ndelay == local::ndelay;
			})
					`uvm_fatal(get_type_name(), "req randomize failed")

			`uvm_send(req)
		end
	endtask

endclass


`endif