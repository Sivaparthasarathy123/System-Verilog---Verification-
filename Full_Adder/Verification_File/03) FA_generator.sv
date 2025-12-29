//generator block
class generator;
  transaction trans;
  
  //creating mailbox
  mailbox gentodrv;
  
  function new (mailbox gentodrv);
    this.gentodrv = gentodrv;
  endfunction
  
  task main;
    
    repeat (3) begin
      
      trans = new(); // creating new object
      
      trans.randomize(); // randomize the value
      
     // $display("Randomized inputs = a=%0d b=%0d cin=%0d", trans.a, trans.b, trans.cin);

      gentodrv.put(trans); //put the transaction values into mailbox
     
      end
    
  endtask
endclass
