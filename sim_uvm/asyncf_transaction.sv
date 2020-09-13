`ifndef ASYNCF_TRANSACTION__SV
`define ASYNCF_TRANSACTION__SV

class asyncf_transaction extends uvm_sequence_item;

   rand bit[7:0] data;

   `uvm_object_utils_begin(asyncf_transaction)
      `uvm_field_int(data, UVM_ALL_ON)
   `uvm_object_utils_end

   function new(string name = "asyncf_transaction");
      super.new();
   endfunction

endclass
`endif
