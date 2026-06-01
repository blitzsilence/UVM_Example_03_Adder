`ifndef INTERFACE__SV
`define INTERFACE__SV

interface interface_in(input clk, input rst_n);
    logic [8:0] data0;
    logic [8:0] data1;
    logic       valid_i;
        
    clocking cb_drv @(posedge clk);
        default input #1ns output #1ns;
        output data0, data1, valid_i;
    endclocking
        
    clocking cb_mon @(posedge clk);
        default input #1ns output #1ns;
        input data0, data1, valid_i;
    endclocking

endinterface

interface interface_out(input clk, input rst_n);
    logic [9:0] result;
    logic       valid_o;
    
    clocking cb_drv @(posedge clk);
        default input #1ns output #1ns;
        input result, valid_o;
    endclocking
    
    clocking cb_mon @(posedge clk);
        default input #1ns output #1ns;
        input result, valid_o;
    endclocking
endinterface  
 
`endif


