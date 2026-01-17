// Transaction - Single Port RAM
class ram_transaction;
    rand bit w_en;
    rand bit [2:0] addr;
    rand bit [7:0] data_in;
    bit [7:0] data_out;

    constraint addr_range { addr inside {[0:7]}; }
endclass
