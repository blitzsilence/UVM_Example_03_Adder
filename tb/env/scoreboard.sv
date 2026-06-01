`ifndef SCOREBOARD__SV
`define SCOREBOARD__SV

class my_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(my_scoreboard)
    
    transaction_out  expect_queue[$];
    uvm_blocking_get_port #(transaction_out)  exp_port;
    uvm_blocking_get_port #(transaction_out)  act_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction 

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
endclass 
 
function void my_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);

    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
endfunction 
 
task my_scoreboard::main_phase(uvm_phase phase);
    transaction_out  expect_tr,  actual_tr, temp_tr;
    bit result;
  
    super.main_phase(phase);

    fork 
        while (1) begin
            exp_port.get(expect_tr);
            expect_queue.push_back(expect_tr);
        end
        while (1) begin
            act_port.get(actual_tr);

            if(expect_queue.size() > 0) begin
                temp_tr = expect_queue.pop_front();
                result = actual_tr.compare(temp_tr);

                if(result) begin 
                    `uvm_info("SCB", "Compare PASSED", UVM_LOW);
                end
                else begin
                    `uvm_error("SCB", "Compare FAILED");
										`uvm_info("TRACE", $sformatf("%m\nThe expect pkt is:\n%s", temp_tr.sprint()), UVM_HIGH)
										`uvm_info("TRACE", $sformatf("%m\nThe actual pkt is:\n%s", actual_tr.sprint()), UVM_HIGH)
                end
            end
            else begin
                `uvm_error("SCB", "Expect queue is empty");
								`uvm_info("TRACE", $sformatf("%m\nThe unexpected pkt is:\n%s", actual_tr.sprint()), UVM_HIGH)
            end 
        end
    join
endtask

`endif