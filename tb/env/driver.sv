`ifndef DRIVER__SV
`define DRIVER__SV

class my_driver extends uvm_driver#(transaction_in);
		`uvm_component_utils(my_driver)
		
    virtual interface_in vif;
 
    function new(string name = "my_driver", uvm_component parent);
        super.new(name, parent);
    endfunction
 
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(virtual interface_in)::get(this, "", "vif", vif))
            `uvm_fatal("DRV", "virtual interface must be set for vif!!!")
    endfunction
 
    extern task main_phase(uvm_phase phase);
    extern task drive_one_pkt(transaction_in tr);
endclass
 
task my_driver::main_phase(uvm_phase phase);
    vif.data0 	<= 8'b0;
    vif.data1 	<= 8'b0;
    vif.valid_i <= 1'b0;
		
    while(!vif.rst_n)
        @(posedge vif.clk);
				
    while(1) begin
        seq_item_port.get_next_item(req);
        drive_one_pkt(req);
        seq_item_port.item_done();
    end
endtask
 
task my_driver::drive_one_pkt(transaction_in tr);

    `uvm_info("DRV", "begin to drive one pkt", UVM_HIGH);

    @(vif.cb_drv);
    vif.cb_drv.data1 		<= tr.data1;
    vif.cb_drv.data0 		<= tr.data0;
    vif.cb_drv.valid_i 	<= 1'b1;
		
    @(posedge vif.clk);
    vif.cb_drv.valid_i 	<= 1'b0;
		
    repeat(tr.ndelay) @(posedge vif.clk);

    `uvm_info("DRV", "end drive one pkt", UVM_HIGH);
endtask

`endif
