module des_ip(
    input  logic        clk_in         ,
    input  logic        rst_n_in       ,
    input  logic [63:0] data_in        ,
    input  logic        data_in_valid  ,

    output logic [31:0] left_data_out  ,
    output logic [31:0] right_data_out ,
    output logic        data_out_valid 
);

logic [31:0] left_data_out_reg  ;
logic [31:0] right_data_out_reg ;
logic        data_out_valid_reg ;

always_ff @ (posedge clk_in or negedge rst_n_in) begin
    if( !rst_n_in ) begin
        left_data_out_reg <= 'b0;
        right_data_out_reg<= 'b0;
        data_out_valid_reg<= 1'b0;
    end else if( data_in_valid ) begin
        data_out_valid_reg <= 1'b1;
        right_data_out_reg <= {
            data_in[ 6], data_in[14], data_in[22], data_in[30], data_in[38], data_in[46], data_in[54], data_in[62], 
            data_in[ 4], data_in[12], data_in[20], data_in[28], data_in[36], data_in[44], data_in[52], data_in[60],
            data_in[ 2], data_in[10], data_in[18], data_in[26], data_in[34], data_in[42], data_in[50], data_in[58],
            data_in[ 0], data_in[ 8], data_in[16], data_in[24], data_in[32], data_in[40], data_in[48], data_in[56]
        };
        left_data_out_reg <= {
            data_in[ 7], data_in[15], data_in[23], data_in[31], data_in[39], data_in[47], data_in[55], data_in[63],
            data_in[ 5], data_in[13], data_in[21], data_in[29], data_in[37], data_in[45], data_in[53], data_in[61],
            data_in[ 3], data_in[11], data_in[19], data_in[27], data_in[35], data_in[43], data_in[51], data_in[59],
            data_in[ 1], data_in[ 9], data_in[17], data_in[25], data_in[33], data_in[41], data_in[49], data_in[57]
        };
    end else begin
        left_data_out_reg  <= left_data_out_reg;
        right_data_out_reg <= right_data_out_reg;
        data_out_valid_reg <= 1'b0;
    end
end

assign left_data_out = left_data_out_reg  ;
assign right_data_out = right_data_out_reg;
assign data_out_valid = data_out_valid_reg;
endmodule


