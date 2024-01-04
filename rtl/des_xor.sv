module des_xor(
    input  logic        clk_in             ,
    input  logic        rst_n_in           ,
    input  logic [47:0] ext_data_in        ,
    input  logic [47:0] key_data_in        ,
    input  logic        data_in_valid      ,

    output logic [47:0] xor_data_out       ,
    output logic        xor_data_out_valid 
);

logic [47:0] xor_data_out_reg      ;
logic        xor_data_out_valid_reg;

always_ff @(posedge clk_in or negedge rst_n_in) begin
    if( !rst_n_in)begin
        xor_data_out_reg <= 'b0;
        xor_data_out_valid_reg <= 'b0;
    end else if( data_in_valid ) begin
        xor_data_out_reg <= ext_data_in ^ key_data_in;
        xor_data_out_valid_reg <= 1'b1;
    end else begin
        xor_data_out_reg <= xor_data_out_reg;
        xor_data_out_valid_reg <= 'b0;
    end
end

assign xor_data_out = xor_data_out_reg;
assign xor_data_out_valid = xor_data_out_valid_reg;
endmodule