// Scoreboard - Dual Port RAM
class scoreboard #(DEPTH, WIDTH);

  mailbox mon2scb;
  bit [WIDTH-1:0] local_mem [DEPTH];

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
   bit [WIDTH-1:0] expected_a;
   bit [WIDTH-1:0] expected_b;

  event ended;

  task main();
    ram_transaction trans;

    repeat (15) begin
      mon2scb.get(trans);

     // expected data_out 
      expected_a = local_mem[trans.addr_a];
      expected_b = local_mem[trans.addr_b];

      // Check read values
      if (trans.w_en_a) begin
        if (trans.data_out_a !== expected_a)
          $error("PORT A READ FAIL: Exp=%0h Got=%0h Addr=%0d",
                 expected_a, trans.data_out_a, trans.addr_a);
        else
          $display("PORT A READ PASS Addr=%0d Data=%0h", trans.addr_a, trans.data_out_a);
      end

      if (trans.w_en_b) begin
        if (trans.data_out_b !== expected_b)
          $error("PORT B READ FAIL: Exp=%0h Got=%0h Addr=%0d",
                 expected_b, trans.data_out_b, trans.addr_b);
        else
          $display("PORT B READ PASS Addr=%0d Data=%0h", trans.addr_b, trans.data_out_b);
      end

      // Update memory - write after read
      if (trans.w_en_a && trans.w_en_b && trans.addr_a == trans.addr_b) begin
          local_mem[trans.addr_a] = trans.data_in_b;  // B takes place
          $display("COLLISION: A & B write Addr=%0d → B takes place Data=%0h",
                 trans.addr_a, trans.data_in_b);
      end
      else begin
        if (trans.w_en_a) begin
          local_mem[trans.addr_a] = trans.data_in_a;
          $display("PORT A WRITE Addr=%0d Data=%0h", trans.addr_a, trans.data_in_a);
        end
        if (trans.w_en_b) begin
          local_mem[trans.addr_b] = trans.data_in_b;
          $display("PORT B WRITE Addr=%0d Data=%0h", trans.addr_b, trans.data_in_b);
        end
      end
      trans.display("--- Scoreboard Class ---\n");
      ->ended;
    end
  endtask

endclass
