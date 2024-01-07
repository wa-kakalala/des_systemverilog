/**************************************
@ filename    : tb_des.sv
@ author      : yyrwkk
@ create time : 2024/01/07 18:33:12
@ version     : v1.0.0
**************************************/
module tb_des(if_des if_des_inst);

initial begin
    if_des_inst.data_in          = 'b0;
    if_des_inst.key_in           = 'b0;
    if_des_inst.mode_in          = 'b0;
    if_des_inst.verify_in        = 'b0;
    if_des_inst.encrypt_in_valid = 'b0;
end

initial begin
    while(1) begin
        @(posedge if_des_inst.clk_in);
        if( if_des_inst.encrypt_ready == 1'b1 ) begin
            break;
        end
    end

    @(posedge if_des_inst.clk_in);
    if_des_inst.key_in <= {8{8'b0000_0001}};
    if_des_inst.key_in           <= 'b0 ;
    if_des_inst.verify_in        <= 1'b1;
    if_des_inst.mode_in          <= 'b0 ;
    if_des_inst.encrypt_in_valid <= 1'b1;

    repeat(10)@(posedge if_des_inst.clk_in);
    $finish();
end


endmodule