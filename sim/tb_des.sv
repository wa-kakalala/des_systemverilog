/**************************************
@ filename    : tb_des.sv
@ author      : yyrwkk
@ create time : 2024/01/07 18:33:12
@ version     : v1.0.0
**************************************/
module tb_des(if_des if_des_inst);

import show_info_pkg::*;

initial begin
    if_des_inst.data_in          = 'b0;
    if_des_inst.key_in           = 'b0;
    if_des_inst.mode_in          = 'b0;
    if_des_inst.verify_in        = 'b0;
    if_des_inst.encrypt_in_valid = 'b0;
end


/**
* @ bref : 产生加密数据和加密密钥
* @ param: data_type -> 0 数据 1-> 密钥 
*/
function automatic logic[63:0] create_des_data(input logic data_type);
    create_des_data[63:32] = {$random()};
    create_des_data[31:0] = {$random()} ;
    if( data_type == 1'b1) begin
        create_des_data[7] = ~(^create_des_data[6:0]  );
        create_des_data[15]= ~(^create_des_data[14:8] );
        create_des_data[23]= ~(^create_des_data[22:16]);
        create_des_data[31]= ~(^create_des_data[30:24]);
        create_des_data[39]= ~(^create_des_data[38:32]);
        create_des_data[47]= ~(^create_des_data[46:40]);
        create_des_data[55]= ~(^create_des_data[54:48]);
        create_des_data[63]= ~(^create_des_data[62:56]);
    end
endfunction

/**
* @ bref : 进行des加密或者解密
* @ param: des_data 加密数据
*          des_key  加密密钥
*          des_type ->0 加密 1 -> 解密 
*/
task automatic des_start(ref logic[63:0] des_data,ref logic[63:0] des_key,input logic des_type);
    @(posedge if_des_inst.clk_in);
    if_des_inst.key_in            <= des_key    ; 
    if_des_inst.data_in           <= des_data   ; 
    if_des_inst.verify_in         <= 1'b1       ;
    if_des_inst.mode_in           <= des_type   ;
    if_des_inst.encrypt_in_valid  <= 1'b1       ;
    @(posedge if_des_inst.clk_in);
    if_des_inst.encrypt_in_valid  <= 1'b0       ;
endtask



logic [63:0] data_des;
logic [63:0] key_des ;

initial begin

    for(int i=0;i<10;i++) begin
        $display("-*-*-*- Round %2d Begin -*-*-*-",i);
        while(1) begin
            @(posedge if_des_inst.clk_in);
            if( if_des_inst.encrypt_ready == 1'b1 ) begin
                break;
            end
        end
        data_des = create_des_data(1'b0);
        key_des  = create_des_data(1'b1);
        
        $display("encryption:");
        $display("\t- data: %x",data_des);
        $display("\t- key : %x",key_des);
        des_start(data_des,key_des,1'b0); // 加密
        @(posedge if_des_inst.encrypt_out_valid);
        $display("\t- res : %x",if_des_inst.encrypt_out);

        while(1) begin
            @(posedge if_des_inst.clk_in);
            if( if_des_inst.encrypt_ready == 1'b1 ) begin
                break;
            end
        end

        $display("decryption:");
        $display("\t- data: %x",if_des_inst.encrypt_out);
        $display("\t- key : %x",key_des);
        des_start(if_des_inst.encrypt_out,key_des,1'b1); // 解密
        @(posedge if_des_inst.encrypt_out_valid);
        $display("\t- res : %x",if_des_inst.encrypt_out);
        if( if_des_inst.encrypt_out != data_des )begin
            show_fail();
            $finish;
        end
        $display("-*-*-*- Round %2d  End  -*-*-*-\n",i);
    end

    show_pass();
    repeat(200)@(posedge if_des_inst.clk_in);
    $finish();
end


endmodule