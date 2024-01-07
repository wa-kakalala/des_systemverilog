interface if_des(
    input logic clk_in,
    input logic rst_n_in
);

logic  [63:0] data_in          ;
logic  [63:0] key_in           ;
logic         mode_in          ;
logic         verify_in        ;
logic         encrypt_in_valid ;
logic  [63:0] encrypt_out      ;
logic         encrypt_out_valid;
logic         encrypt_ready    ;
logic         encrypt_err      ;

endinterface