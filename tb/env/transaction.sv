`ifndef TRANSACTION__SV
`define TRANSACTION__SV

// Transaction_in
class transaction_in extends uvm_sequence_item;
    rand bit[8:0] data0;
    rand bit[8:0] data1;
    rand int      ndelay;

    `uvm_object_utils_begin(transaction_in)
        `uvm_field_int(data0, UVM_ALL_ON)
        `uvm_field_int(data1, UVM_ALL_ON)
    `uvm_object_utils_end

    constraint data_cstr{
        data0 inside {[0:255]};
        data1 inside {[0:255]};
        ndelay inside {[0:50]};
    }
		
    function new(string name = "transaction_in");
        super.new(name);
    endfunction
endclass

// Transaction_out
class transaction_out extends uvm_sequence_item;
    rand bit[9:0] result;

    `uvm_object_utils_begin(transaction_out)
        `uvm_field_int(result, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "transaction_out");
        super.new(name);
    endfunction

endclass

`endif
