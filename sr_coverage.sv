class sr_coverage extends uvm_subscriber #(sr_sequence_item);
  
//  uvm_analysis_imp#(seq_item, f_subscriber) item_got_export2;
  
  `uvm_component_utils(sr_coverage)
    sr_sequence_item req;
    int i;
  real cov;

    covergroup cg;
        s   : coverpoint req.s;  
        r    : coverpoint req.r;
      
        q         : coverpoint req.q;
        qbar        : coverpoint req.qbar;
        
      cross s , r;
    option.per_instance= 1;
    option.comment     = "dut_cov";
    option.name        = "dut_cov";
    option.auto_bin_max= 4;

    endgroup: cg
        
  function new(string name="sr_coverage", uvm_component parent);
        super.new(name, parent);
  
     req = sr_sequence_item::type_id::create("req");
        cg = new();
    endfunction: new

  function void write(sr_sequence_item t);
        req = t;
        i++;
        cg.sample();
      $display("coverage=%f", cg.get_inst_coverage);
    endfunction: write
  
    function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov=cg.get_coverage();
  endfunction
  
   function void report_phase(uvm_phase phase);
    super.report_phase(phase);
     `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_MEDIUM);
  endfunction


endclass