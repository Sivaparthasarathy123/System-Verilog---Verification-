//Driver block
class driver;
  virtual f_adder add;
  mailbox gentodrv;

  function new(virtual f_adder add, mailbox gentodrv);
    this.add = add;
    this.gentodrv = gentodrv;
  endfunction

  task main;
     transaction trans;
    
    repeat(3) begin
     
      gentodrv.get(trans);
      #1;
      add.a   <= trans.a;
      add.b   <= trans.b;
      add.cin <= trans.cin;
      #5;
    end
  endtask
endclass
