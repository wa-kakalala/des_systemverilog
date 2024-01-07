/**************************************
@ filename    : top.sv
@ author      : yyrwkk
@ create time : 2024/01/07 18:33:18
@ version     : v1.0.0
**************************************/
module top();

logic         clk_in           ;
logic         rst_n_in         ;

initial begin
    clk_in = 1'b0;
    forever #5 clk_in = ~clk_in;
end

initial begin
    rst_n_in = 1'b0;
end

initial begin
    @(posedge clk_in);
    rst_n_in <= 1'b1;
end

if_des if_des_inst(clk_in,rst_n_in);
tb_des(if_des_inst);
des des_inst (
    .clk_in           (clk_in                       ),
    .rst_n_in         (rst_n_in                     ),
    .data_in          (if_des_inst.data_in          ),
    .key_in           (if_des_inst.key_in           ),
    .mode_in          (if_des_inst.mode_in          ),
    .verify_in        (if_des_inst.verify_in        ),
    .encrypt_in_valid (if_des_inst.encrypt_in_valid ),

    .encrypt_out      (if_des_inst.encrypt_out      ),
    .encrypt_out_valid(if_des_inst.encrypt_out_valid),
    .encrypt_ready    (if_des_inst.encrypt_ready    ),
    .encrypt_err      (if_des_inst.encrypt_err      )
);

endmodule