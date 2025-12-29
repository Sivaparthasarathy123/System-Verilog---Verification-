// Monitor block

class monitor;
  virtual f_adder add; // virtualizing the full_adder interface
  
  mailbox montoscb; // Declaring the mailbox
  
  function new (virtual f_adder add, mailbox montoscb);
    this.add = add;    //declaring the handle
    this.montoscb = montoscb;   // declaring mailbox
  endfunction
  
  task main;
    
    transaction trans;
    
    repeat (3) begin
      #1;
      
      trans = new(); // creating new object
    
      // Transaction the input variables from virtual interface to monitor
      trans.a     = add.a;
      trans.b     = add.b;
      trans.cin   = add.cin;
      trans.sum   = add.sum;
      trans.carry = add.carry;
      
      montoscb.put(trans);
      
      //trans.display("values in Monitor");
      #4;
    end
    
  endtask
  
endclass
