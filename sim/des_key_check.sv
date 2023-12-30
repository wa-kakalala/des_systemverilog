module des_key_check(
    input logic         clk_in             ,
    input logic         rst_n_in           ,
    input logic  [63:0] origin_key_in      ,
    input logic         verify_in          ,
    input logic         origin_key_in_valid,

    output logic [55:0] sub_key_out        ,
    output logic        sub_key_out_valid  ,
    output logic        sub_key_err_out    
);

logic [55:0] sub_key_out_reg      ;
logic        sub_key_out_valid_reg;
logic        sub_key_err_out_reg  ;

always_ff @(posedge clk_in or negedge rst_n_in) begin
    if( !rst_n_in ) begin
        sub_key_out_reg <= 'b0;
        sub_key_out_valid_reg <= 'b0;
    end else if( origin_key_in_valid ) begin
        sub_key_out_valid_reg <= 1'b1;
        sub_key_out_reg ={
            origin_key_in[ 3], origin_key_in[11], origin_key_in[19], origin_key_in[27], origin_key_in[ 4], origin_key_in[12], origin_key_in[20], origin_key_in[28], 
            origin_key_in[36], origin_key_in[44], origin_key_in[52], origin_key_in[60], origin_key_in[ 5], origin_key_in[13], origin_key_in[21], origin_key_in[29],
            origin_key_in[37], origin_key_in[45], origin_key_in[53], origin_key_in[61], origin_key_in[ 6], origin_key_in[14], origin_key_in[22], origin_key_in[30],
            origin_key_in[ 2], origin_key_in[46], origin_key_in[54], origin_key_in[62], origin_key_in[35], origin_key_in[43], origin_key_in[51], origin_key_in[59],
            origin_key_in[ 2], origin_key_in[10], origin_key_in[18], origin_key_in[26], origin_key_in[34], origin_key_in[42], origin_key_in[50], origin_key_in[58],
            origin_key_in[ 1], origin_key_in[ 9], origin_key_in[17], origin_key_in[25], origin_key_in[33], origin_key_in[41], origin_key_in[49], origin_key_in[57],
            origin_key_in[ 0], origin_key_in[ 8], origin_key_in[16], origin_key_in[24], origin_key_in[32], origin_key_in[40], origin_key_in[48], origin_key_in[56]
        };
    end else begin
        sub_key_out_reg <= sub_key_out_reg;
        sub_key_out_valid_reg <= 'b0;
    end
end

always_ff @(posedge clk_in or negedge rst_n_in) begin
    if( !rst_n_in ) begin
        sub_key_err_out_reg <= 'b0;
    end else if( origin_key_in_valid ) begin
        if( verify_in ) begin  // need to check odd parity
            sub_key_err_out_reg = ~(^origin_key_in[63:56] & ^origin_key_in[55:48] & ^origin_key_in[47:40] & ^origin_key_in[39:32]
                                   &^origin_key_in[31:24] & ^origin_key_in[23:16] & ^origin_key_in[15: 8] & ^origin_key_in[7:0 ]);
        end else begin
            sub_key_err_out_reg = 'b0;
        end
    end else begin
        sub_key_err_out_reg <= 'b0;
    end
end

assign sub_key_out = sub_key_out_reg;
assign sub_key_out_valid = (sub_key_err_out_reg == 1'b1 ) ? 1'b0 : sub_key_out_valid_reg;
assign sub_key_err_out = sub_key_err_out_reg;

endmodule