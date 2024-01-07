module des (
    input logic         clk_in           ,
    input logic         rst_n_in         ,
    input logic  [63:0] data_in          ,
    input logic  [63:0] key_in           ,
    input logic         mode_in          ,
    input logic         verify_in        ,
    input logic         encrypt_in_valid ,

    output logic [63:0] encrypt_out      ,
    output logic        encrypt_out_valid,
    output logic        encrypt_ready    ,
    output logic        encrypt_err
);

logic [55:0] sub_key      ;
logic        sub_key_valid;
logic        sub_key_err  ;

/**
* @ bref: key校验 + 去除校验位
*/
des_key_check des_key_check_inst(
    .clk_in             (clk_in          ),
    .rst_n_in           (rst_n_in        ),
    .origin_key_in      (key_in          ),
    .verify_in          (verify_in       ),
    .origin_key_in_valid(encrypt_in_valid),

    .sub_key_out        (sub_key         ),
    .sub_key_out_valid  (sub_key_valid   ),
    .sub_key_err_out    (sub_key_err     )
);

/**
* @bref: des控制模块
*/
des_ctrl des_ctrl_inst (
    .clk_in                   (clk_in          ),
    .rst_n_in                 (rst_n_in        ),

    .encrypt_in_valid         (encrypt_in_valid),
    .mode_in                  (mode_in         ),

    .sub_key_in               (sub_key         ),
    .sub_key_in_valid         (sub_key_valid   ),
    .check_error_in           (sub_key_err     ),

    .data_in_valid            (),
    .right_data_in            (),
    .left_data_in             (),

    .xor32_data_in_valid      (),
    .xor32_data_in            (),

    .sub_key_out              (),
    .sub_key_idx_out          (),
    .sub_key_out_valid        (),

    .inv_data_out             (), 
    .inv_data_out_valid       (),
    .encrypt_ready            (encrypt_ready  )
);

endmodule