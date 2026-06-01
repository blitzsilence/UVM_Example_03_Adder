# UVM_Example_Adder

## Intro

UVM testbench environment practice for a simple adder DUT

Testcase: random_data_delay_test, burst_data_test, order_data_test

## Verification Environment
```
    Project_root
    │
    ├── README.md
    │    
    ├── doc
    │   └── xxxx
    │
    ├── rtl
    │   └── dut.sv
    │
    ├── sim
    │   └── Makefile
    │ 
    └── tb
        ├── env
        │   ├── agent.sv
        │   ├── driver.sv        
        │   ├── env.sv
        │   ├── monitor.sv
        │   ├── ref_model.sv
        │   ├── scoreboard.sv
        │   ├── sequencer.sv
        │   └── transaction.sv
        │ 
        ├── interface
        │   └── interface.sv
        │
        ├── package
        │   └── env_pkg.sv
        │
        ├── sequence
        │   ├── base_sequence.sv
        │   └── sequence_lib.sv
        │
        ├── testcase
        │   ├── base_test.sv
        │   └── test_lib.sv
        │        
        └── top
            ├── rtl.f
            ├── tb.f
            └── tb_top.sv
```

## Makefile excution
make comp 

make sim TESTNAME=basetest

make sim TESTNAME=random_data_delay_test

make sim TESTNAME=burst_data_test

make sim TESTNAME=order_data_test


## UVM testbench topology
```
------------------------------------------------------------------
Name                       Type                        Size  Value
------------------------------------------------------------------
uvm_test_top               base_test                   -     @465 
  env                      my_env                      -     @473 
    i_agt                  agent_in                    -     @481 
      drv                  my_driver                   -     @799 
        rsp_port           uvm_analysis_port           -     @816 
        seq_item_port      uvm_seq_item_pull_port      -     @807 
      mon                  monitor_in                  -     @825 
        ap                 uvm_analysis_port           -     @835 
      sqr                  my_sequencer                -     @676 
        rsp_export         uvm_analysis_export         -     @684 
        seq_item_export    uvm_seq_item_pull_imp       -     @790 
        arbitration_queue  array                       0     -    
        lock_queue         array                       0     -    
        num_last_reqs      integral                    32    'd1  
        num_last_rsps      integral                    32    'd1  
    i_agt_mdl_fifo         uvm_tlm_analysis_fifo #(T)  -     @513 
      analysis_export      uvm_analysis_imp            -     @557 
      get_ap               uvm_analysis_port           -     @548 
      get_peek_export      uvm_get_peek_imp            -     @530 
      put_ap               uvm_analysis_port           -     @539 
      put_export           uvm_put_imp                 -     @521 
    mdl                    my_model                    -     @497 
      ap                   uvm_analysis_port           -     @853 
      port                 uvm_blocking_get_port       -     @844 
    mdl_scb_fifo           uvm_tlm_analysis_fifo #(T)  -     @566 
      analysis_export      uvm_analysis_imp            -     @610 
      get_ap               uvm_analysis_port           -     @601 
      get_peek_export      uvm_get_peek_imp            -     @583 
      put_ap               uvm_analysis_port           -     @592 
      put_export           uvm_put_imp                 -     @574 
    o_agt                  agent_out                   -     @489 
      mon                  monitor_out                 -     @866 
        ap                 uvm_analysis_port           -     @875 
    o_agt_scb_fifo         uvm_tlm_analysis_fifo #(T)  -     @619 
      analysis_export      uvm_analysis_imp            -     @663 
      get_ap               uvm_analysis_port           -     @654 
      get_peek_export      uvm_get_peek_imp            -     @636 
      put_ap               uvm_analysis_port           -     @645 
      put_export           uvm_put_imp                 -     @627 
    scb                    my_scoreboard               -     @505 
      act_port             uvm_blocking_get_port       -     @893 
      exp_port             uvm_blocking_get_port       -     @884 
------------------------------------------------------------------
```



