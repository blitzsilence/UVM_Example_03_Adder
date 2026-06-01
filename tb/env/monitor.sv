`ifndef MONITOR_SV_
`define MONITOR_SV_

// Monitor_in
class monitor_in extends uvm_monitor;
    `uvm_component_utils(monitor_in)
		
    virtual interface_in vif;
    uvm_analysis_port #(transaction_in)  ap;
    
    function new(string name = "monitor_in", uvm_component parent);
       super.new(name, parent);
    endfunction
 	
		extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern virtual task collect_one_pkt(transaction_in tr);
endclass

function void monitor_in::build_phase(uvm_phase phase);
	 super.build_phase(phase);

	 if(!uvm_config_db #(virtual interface_in)::get(this, "", "vif", vif))
			`uvm_fatal("MON_I", "virtual interface must be set for vif!!!")
	 
	 ap = new("ap", this);
endfunction

task monitor_in::main_phase(uvm_phase phase);
    transaction_in tr;

    while(1) begin
       tr = new("tr");
       collect_one_pkt(tr);
       ap.write(tr);
    end
endtask
 
task monitor_in::collect_one_pkt(transaction_in tr);
    
    @(posedge vif.clk iff(vif.valid_i));
    `uvm_info("MON_I", "begin to collect one pkt", UVM_HIGH);

    tr.data0 = vif.data0;
    tr.data1 = vif.data1;
    `uvm_info("MON_I", $sformatf("collect one pkt: \n%s", tr.sprint()), UVM_LOW);
endtask

// Monitor_out
class monitor_out extends uvm_monitor;
    `uvm_component_utils(monitor_out)
		
    virtual interface_out vif;
    uvm_analysis_port #(transaction_out)  ap;
    
    function new(string name = "monitor_out", uvm_component parent);
       super.new(name, parent);
    endfunction
 
		extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    extern virtual task collect_one_pkt(transaction_out tr);
endclass
 
function void monitor_out::build_phase(uvm_phase phase);
	 super.build_phase(phase);

	 if(!uvm_config_db #(virtual interface_out)::get(this, "", "vif", vif))
			`uvm_fatal("MON_O", "virtual interface must be set for vif!!!")
	 
	 ap = new("ap", this);
endfunction 

task monitor_out::main_phase(uvm_phase phase);
    transaction_out tr;

    while(1) begin
       tr = new("tr");
       collect_one_pkt(tr);
       ap.write(tr);
    end
endtask
 
task monitor_out::collect_one_pkt(transaction_out tr);
    
    @(posedge vif.clk iff(vif.valid_o));
    `uvm_info("MON_O", "begin to collect one pkt", UVM_HIGH);

    tr.result = vif.result;
    `uvm_info("MON_O", $sformatf("collect one pkt: \n%s", tr.sprint()), UVM_LOW);
endtask

`endif
