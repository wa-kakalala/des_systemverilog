/**************************************
@ filename    : des_p.sv
@ author      : yyrwkk
@ create time : 2024/01/07 05:08:04
@ version     : v1.0.0
**************************************/
module des_p(
    input  logic        clk_in         ,
    input  logic        rst_n_in       ,
    input  logic [31:0] pdata_in       ,
    input  logic        pdata_in_valid ,

    output logic [31:0] pdata_out      ,
    output logic        pdata_out_valid
);


logic [31:0] pdata_out_reg      ;
logic        pdata_out_valid_reg;

always_ff @(posedge clk_in or negedge rst_n_in) begin
    if( !rst_n_in ) begin
        pdata_out_reg <= 'b0;
        pdata_out_valid_reg <= 'b0;
    end else if( pdata_in_valid ) begin
        pdata_out_valid_reg <= 1'b1;
        pdata_out_reg <= {
            pdata_in[24], pdata_in[ 3], pdata_in[10], pdata_in[21], pdata_in[ 5], pdata_in[29], pdata_in[12], pdata_in[18],
            pdata_in[ 8], pdata_in[ 2], pdata_in[26], pdata_in[31], pdata_in[13], pdata_in[23], pdata_in[ 7], pdata_in[ 1],
            pdata_in[ 9], pdata_in[30], pdata_in[17], pdata_in[ 4], pdata_in[25], pdata_in[22], pdata_in[14], pdata_in[ 0],
            pdata_in[16], pdata_in[27], pdata_in[11], pdata_in[28], pdata_in[20], pdata_in[19], pdata_in[ 6], pdata_in[15]
        };
    end else begin
        pdata_out_reg <= pdata_out_reg;
        pdata_out_valid_reg <= 'b0;
    end
end

assign pdata_out = pdata_out_reg;
assign pdata_out_valid = pdata_out_valid_reg;
endmodule