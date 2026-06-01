`ifndef SEQUENCER__SV
`define SEQUENCER__SV

class my_sequencer extends uvm_sequencer #(transaction_in);
    `uvm_component_utils(my_sequencer)
		
    function new(string name, uvm_component parent);
       super.new(name, parent);
    endfunction 
endclass

`endif
