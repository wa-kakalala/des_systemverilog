/**************************************
@ filename    : des_ext.sv
@ author      : yyrwkk
@ create time : 2024/01/07 05:07:35
@ version     : v1.0.0
**************************************/
module des_ext(
    input  logic        clk_in             ,
    input  logic        rst_n_in           ,
    input  logic [31:0] ext_data_in        ,
    input  logic        ext_data_in_valid  ,

    output logic [47:0] ext_data_out       ,
    output logic        ext_data_out_valid 
);

logic [47:0] ext_data_out_reg      ;
logic        ext_data_out_valid_reg;

always_ff @(posedge clk_in or negedge rst_n_in) begin
    if( !rst_n_in ) begin
        ext_data_out_reg <= 'b0;
        ext_data_out_valid_reg <= 1'b0;
    end else if( ext_data_in_valid ) begin
        ext_data_out_valid_reg <= 1'b1;
        ext_data_out_reg <= {
            ext_data_in[ 0], ext_data_in[31], ext_data_in[30], ext_data_in[29], ext_data_in[28], ext_data_in[27], ext_data_in[28], ext_data_in[27], 
            ext_data_in[26], ext_data_in[25], ext_data_in[24], ext_data_in[23], ext_data_in[24], ext_data_in[23], ext_data_in[22], ext_data_in[21], 
            ext_data_in[20], ext_data_in[19], ext_data_in[20], ext_data_in[19], ext_data_in[18], ext_data_in[17], ext_data_in[16], ext_data_in[15], 
            ext_data_in[16], ext_data_in[15], ext_data_in[14], ext_data_in[13], ext_data_in[12], ext_data_in[11], ext_data_in[12], ext_data_in[11], 
            ext_data_in[10], ext_data_in[ 9], ext_data_in[ 8], ext_data_in[ 7], ext_data_in[ 8], ext_data_in[ 7], ext_data_in[ 6], ext_data_in[ 5], 
            ext_data_in[ 4], ext_data_in[ 3], ext_data_in[ 4], ext_data_in[ 3], ext_data_in[ 2], ext_data_in[ 1], ext_data_in[ 0], ext_data_in[31]
        };
    end else begin
        ext_data_out_reg <= ext_data_out_reg;
        ext_data_out_valid_reg <= 1'b0;
    end
end

assign ext_data_out = ext_data_out_reg;
assign ext_data_out_valid = ext_data_out_valid_reg;

endmodule