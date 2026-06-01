`ifndef AGENT__SV
`define AGENT__SV

// Agent_in
class agent_in extends uvm_agent ;
    `uvm_component_utils(agent_in)
    
		my_sequencer    sqr;
    my_driver       drv;
    monitor_in      mon;
    
    uvm_analysis_port #(transaction_in)  ap;
    
    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction 
    
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
 endclass 

 function void agent_in::build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if (is_active == UVM_ACTIVE) begin
       sqr = my_sequencer::type_id::create("sqr", this);
       drv = my_driver::type_id::create("drv", this);
    end

    mon = monitor_in::type_id::create("mon", this);
 endfunction 
 
 function void agent_in::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (is_active == UVM_ACTIVE) begin
       drv.seq_item_port.connect(sqr.seq_item_export);
    end

    ap = mon.ap;
 endfunction

// Agent_out
class agent_out extends uvm_agent ;
    `uvm_component_utils(agent_out)
    
		monitor_out      mon;
    uvm_analysis_port #(transaction_out)  ap;
    
    function new(string name = "agent_out", uvm_component parent);
       super.new(name, parent);
    endfunction 
    
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
 endclass 
 
 function void agent_out::build_phase(uvm_phase phase);
    super.build_phase(phase);

    mon = monitor_out::type_id::create("mon", this);
 endfunction 
 
 function void agent_out::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    ap = mon.ap;
 endfunction

 `endif
