# UVM_Example_Adder

#### Intro

UVM testbench environment practice for a simple adder DUT


#### Verification Environment
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
    │   ├── Makefile
    │   └── runlist
    │ 
    └── tb
        ├── env
        │   ├── agent.sv
        │   ├── env.sv
        │   ├── monitor.sv
        │   ├── ref_model.sv
        │   ├── scoreboard.sv
        │   ├── sequencer.sv
        │   ├── sequencer.sv
        │   └── transaction.sv
        │ 
        ├── interface
        │   └── interface.sv
        │
        ├── package
        │   └── env_pkg.sv
        │ 
        ├── testcase
        │   ├── base_test.sv
        │   ├── my_case1.sv
        │   └── my_case1.sv
        │        
        └── top
            ├── tb_top.sv
            ├── rtl.f
            └── tb.f
```

#### Makefile excution
make comp 

make all TESTNAME=basetest

make sim TESTNAME=my_case0

make sim TESTNAME=my_case1


#### UVM testbench topology
```
------------------------------------------------------------------
Name                       Type                        Size  Value
------------------------------------------------------------------
uvm_test_top               base_test                   -     @465 
  env                      my_env                      -     @473 
    i_agt                  agent_in                    -     @604 
      drv                  my_driver                   -     @922 
        rsp_port           uvm_analysis_port           -     @939 
        seq_item_port      uvm_seq_item_pull_port      -     @930 
      mon                  monitor_in                  -     @948 
        ap                 uvm_analysis_port           -     @958 
      sqr                  my_sequencer                -     @799 
        rsp_export         uvm_analysis_export         -     @807 
        seq_item_export    uvm_seq_item_pull_imp       -     @913 
        arbitration_queue  array                       0     -    
        lock_queue         array                       0     -    
        num_last_reqs      integral                    32    'd1  
        num_last_rsps      integral                    32    'd1  
    i_agt_mdl_fifo         uvm_tlm_analysis_fifo #(T)  -     @636 
      analysis_export      uvm_analysis_imp            -     @680 
      get_ap               uvm_analysis_port           -     @671 
      get_peek_export      uvm_get_peek_imp            -     @653 
      put_ap               uvm_analysis_port           -     @662 
      put_export           uvm_put_imp                 -     @644 
    mdl                    my_model                    -     @620 
      ap                   uvm_analysis_port           -     @976 
      port                 uvm_blocking_get_port       -     @967 
    mdl_scb_fifo           uvm_tlm_analysis_fifo #(T)  -     @689 
      analysis_export      uvm_analysis_imp            -     @733 
      get_ap               uvm_analysis_port           -     @724 
      get_peek_export      uvm_get_peek_imp            -     @706 
      put_ap               uvm_analysis_port           -     @715 
      put_export           uvm_put_imp                 -     @697 
    o_agt                  agent_out                   -     @612 
      mon                  monitor_out                 -     @989 
        ap                 uvm_analysis_port           -     @998 
    o_agt_scb_fifo         uvm_tlm_analysis_fifo #(T)  -     @742 
      analysis_export      uvm_analysis_imp            -     @786 
      get_ap               uvm_analysis_port           -     @777 
      get_peek_export      uvm_get_peek_imp            -     @759 
      put_ap               uvm_analysis_port           -     @768 
      put_export           uvm_put_imp                 -     @750 
    scb                    my_scoreboard               -     @628 
      act_port             uvm_blocking_get_port       -     @1016
      exp_port             uvm_blocking_get_port       -     @1007
  v_sqr                    virtual_sequencer           -     @481 
    rsp_export             uvm_analysis_export         -     @489 
    seq_item_export        uvm_seq_item_pull_imp       -     @595 
    arbitration_queue      array                       0     -    
    lock_queue             array                       0     -    
    num_last_reqs          integral                    32    'd1  
    num_last_rsps          integral                    32    'd1  
------------------------------------------------------------------
```



