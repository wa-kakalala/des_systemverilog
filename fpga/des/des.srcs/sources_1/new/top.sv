`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: wkk
// Create Date: 2024/01/09 16:38:33
// Module Name: top
//////////////////////////////////////////////////////////////////////////////////
module top(
    input  logic   clk_in   ,
    input  logic   rst_n_in ,
    input  logic   key_in   ,
    
    output logic   nc
);
   
logic        encrypt_in_valid  ;    
                               
logic [63:0] encrypt_out       ;    
logic        encrypt_out_valid ;    
logic        encrypt_ready     ;    
logic        encrypt_err       ;   
    
logic key_in_reg_1;
logic key_in_reg_2;

always_ff @(posedge clk_in or negedge rst_n_in ) begin
    if( !rst_n_in ) begin
        key_in_reg_1 <= 1'b0;
        key_in_reg_2 <= 1'b0;
    end else begin
        key_in_reg_1 <= key_in;
        key_in_reg_2 <= key_in_reg_1;
    end
end
    
des des_inst(
    .clk_in           (clk_in                     ),
    .rst_n_in         (rst_n_in                   ),
    .data_in          ({8{8'b10001001}}           ),
    .key_in           ({8{8'b01010100}}           ),
    .mode_in          (1'b0                       ),
    .verify_in        (1'b1                       ),
    .encrypt_in_valid ( key_in_reg_1^key_in_reg_2 ),
    
    .encrypt_out      (encrypt_out                ),
    .encrypt_out_valid(encrypt_out_valid          ),
    .encrypt_ready    (encrypt_ready              ),
    .encrypt_err      (encrypt_err                )
);

ila_des ila_des_inst (
	.clk   (clk_in           ), // input wire clk
	
	.probe0(encrypt_out      ), // input wire [63:0]  probe0  
	.probe1(encrypt_out_valid), // input wire [0:0]  probe1 
	.probe2(encrypt_err      ) // input wire [0:0]  probe2
);
endmodule
