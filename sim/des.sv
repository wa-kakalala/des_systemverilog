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

logic [55:0] sub_key            ;
logic        sub_key_valid      ;
logic        sub_key_err        ;
        
logic [31:0] left_data          ;
logic [31:0] right_data         ;
logic        data_valid         ;

logic [55:0] sub_key_ctrl       ;
logic [3 :0] sub_key_idx_ctrl   ;
logic        sub_key_valid_ctrl ;

logic [47:0] encrypt_key        ;
logic        encrypt_key_valid  ;

logic [31:0] ext_data_ctrl      ;      
logic        ext_data_valid_ctrl;

logic [47:0] ext_data           ;
logic        ext_data_valid     ;

logic [47:0] xor48_data         ;
logic        xor48_data_valid   ;

logic [31:0] scomp_data         ;
logic        scomp_data_valid   ;

logic [31:0] pdata_out          ;
logic        pdata_out_valid    ;

logic [31:0] xor32_data         ;
logic        xor32_data_valid   ;

logic [63:0] inv_data           ; 
logic        inv_data_valid     ;

logic [31:0] xor32_left_data_ctrl      ;
logic        xor32_left_data_valid_ctrl;

/**
* @ bref: key校验 + 去除校验位
*/
des_key_check des_key_check_inst(
    .clk_in             (clk_in           ),
    .rst_n_in           (rst_n_in         ),
    .origin_key_in      (key_in           ),
    .verify_in          (verify_in        ),
    .origin_key_in_valid( encrypt_in_valid
                        &encrypt_ready    ),

    .sub_key_out        (sub_key          ),
    .sub_key_out_valid  (sub_key_valid    ),
    .sub_key_err_out    (sub_key_err      )
);

/**
* @ bref: 初始置换
*/
des_ip des_ip_inst(
    .clk_in         (clk_in           ),
    .rst_n_in       (rst_n_in         ),
    .data_in        (data_in          ),
    .data_in_valid  ( encrypt_in_valid
                     &encrypt_ready   ),

    .left_data_out  (left_data        ),
    .right_data_out (right_data       ),
    .data_out_valid (data_valid       )
);

/**
* @ bref: 选择扩展
*/
des_ext des_ext_inst(
   .clk_in             (clk_in             ),
   .rst_n_in           (rst_n_in           ),
   .ext_data_in        (ext_data_ctrl      ),
   .ext_data_in_valid  (ext_data_valid_ctrl),

   .ext_data_out       (ext_data           ),
   .ext_data_out_valid (ext_data_valid     )
);

/**
* @ bref: 产生加密密钥
*/
des_key des_key_inst (
    .clk_in           (clk_in            ),
    .rst_n_in         (rst_n_in          ),
    .sub_key_in       (sub_key_ctrl      ),
    .sub_key_idx_in   (sub_key_idx_ctrl  ),
    .sub_key_in_valid (sub_key_valid_ctrl),

    .key_out          (encrypt_key       ),
    .key_out_valid    (encrypt_key_valid )
);

/**
* @ bref: 和加密密钥进行异或，加密
*/
des_xor48 des_xor48_inst(
    .clk_in             (clk_in              ),
    .rst_n_in           (rst_n_in            ),
    .ext_data_in        (ext_data            ),
    .key_data_in        (encrypt_key         ),
    .data_in_valid      (  ext_data_valid 
                         & encrypt_key_valid ),

    .xor_data_out       (xor48_data          ),
    .xor_data_out_valid (xor48_data_valid    )
);

/**
* @ bref: 选择压缩，48bit -> 32bit
*/
des_scomp des_scomp_inst(
    .clk_in          (clk_in          ),
    .rst_n_in        (rst_n_in        ),
    .s_data_in       (xor48_data      ),
    .s_data_in_valid (xor48_data_valid),

    .scomp_out       (scomp_data      ),
    .scomp_out_valid (scomp_data_valid)
);

/**
* @ bref: p置换
*/
des_p des_p_inst(
    .clk_in         (clk_in          ),
    .rst_n_in       (rst_n_in        ),
    .pdata_in       (scomp_data      ),
    .pdata_in_valid (scomp_data_valid),

    .pdata_out      (pdata_out       ),
    .pdata_out_valid(pdata_out_valid )
);

/**
* @ bref: s运算后的数据和左侧数据异或
*/
des_xor32 des_xor32_inst(
    .clk_in             (clk_in                     ),
    .rst_n_in           (rst_n_in                   ),
    .right_data_in      (pdata_out                  ),
    .left_data_in       (xor32_left_data_ctrl       ),
    .data_in_valid      ( pdata_out_valid
                         &xor32_left_data_valid_ctrl),
    .xor_data_out       (xor32_data                 ),
    .xor_data_out_valid (xor32_data_valid           )
);

/**
* @ bref: 逆初始置换运算
*/
des_invip des_invip_inst(
    .clk_in           (clk_in           ),
    .rst_n_in         (rst_n_in         ),
    .data_in          (inv_data         ),
    .data_in_valid    (inv_data_valid   ),

    .encrypt_out      (encrypt_out      ),
    .encrypt_out_valid(encrypt_out_valid)
);

/**
* @bref: des控制模块
*/
des_ctrl des_ctrl_inst ( 
    .clk_in                   (clk_in                    ),
    .rst_n_in                 (rst_n_in                  ),
         
    .encrypt_in_valid         (encrypt_in_valid          ),
    .mode_in                  (mode_in                   ),
         
    .sub_key_in               (sub_key                   ),
    .sub_key_in_valid         (sub_key_valid             ),
    .check_error_in           (sub_key_err               ),
         
    .data_in_valid            (data_valid                ),
    .right_data_in            (right_data                ),
    .left_data_in             (left_data                 ),
         
    .xor32_data_in_valid      (xor32_data_valid          ),
    .xor32_data_in            (xor32_data                ),
        
    .sub_key_out              (sub_key_ctrl              ),
    .sub_key_idx_out          (sub_key_idx_ctrl          ),
    .sub_key_out_valid        (sub_key_valid_ctrl        ),

    .xor32_left_data_out      (xor32_left_data_ctrl      ),
    .xor32_left_data_out_valid(xor32_left_data_valid_ctrl),

    .inv_data_out             (inv_data                  ), 
    .inv_data_out_valid       (inv_data_valid            ),
       
    .ext_data_out             (ext_data_ctrl             ), 
    .ext_data_out_valid       (ext_data_valid_ctrl       ),
       
    .encrypt_ready            (encrypt_ready             )
);

endmodule