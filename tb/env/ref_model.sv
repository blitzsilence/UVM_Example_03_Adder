`ifndef REF_MODEL__SV
`define REF_MODEL__SV

class my_model extends uvm_component;
    `uvm_component_utils(my_model)

    uvm_blocking_get_port #(transaction_in)  port;
    uvm_analysis_port #(transaction_out)  ap;
 
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction 

    extern function void build_phase(uvm_phase phase);
    extern virtual  task main_phase(uvm_phase phase);
endclass 

function void my_model::build_phase(uvm_phase phase);
    super.build_phase(phase);

    port = new("port", this);
    ap = new("ap", this);
endfunction
 
task my_model::main_phase(uvm_phase phase);
    transaction_in tr;
    transaction_out out_tr;

    super.main_phase(phase);

    while(1) begin
        port.get(tr);
        out_tr = new("new_tr");

        out_tr.result = tr.data0 + tr.data1;
        `uvm_info("MDL", "get one transaction, copy and print it:", UVM_LOW)
        out_tr.print();
        
        ap.write(out_tr);
    end
endtask

`endif
