class dram_cov #(type T=dram_seq_item) extends uvm_subscriber #(T);
`uvm_component_utils(dram_cov)
T pkt;


covergroup cg;	//@(posedge intf.clk);
  address : coverpoint pkt.add {
    bins low    = {[0:20]};
    bins med    = {[21:42]};
    bins high   = {[43:63]};
  }
  data : coverpoint  pkt.data_in {
    bins low    = {[0:50]};
    bins med    = {[51:150]};
    bins high   = {[151:255]};
  }
endgroup

function new (string name = "dram_cov", uvm_component parent);
      super.new (name, parent);
  cg = new();
endfunction

	  
  function void write (T t);
	pkt = t;
	cg.sample();
endfunction
  
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cg.get_coverage),UVM_MEDIUM)
  endfunction

endclass