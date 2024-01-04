module tb_des_scomp();

logic        clk_in           ;
logic        rst_n_in         ;
logic [47:0] s_data_in        ;
logic        s_data_in_valid  ;
logic [31:0] scomp_out        ;
logic        scomp_out_valid  ;

des_scomp des_scomp_inst(
    .clk_in          (clk_in         ),
    .rst_n_in        (rst_n_in       ),
    .s_data_in       (s_data_in      ),
    .s_data_in_valid (s_data_in_valid),

    .scomp_out       (scomp_out      ),
    .scomp_out_valid (scomp_out_valid)
);

logic [47:0] data_ref [$] = {
    48'b010010000110111001010111110100001000101110010111,
    48'b010011000110111000010111010100011000001110010111,
    48'b110011001010011010100011011000010110001101010011,
    48'b100101011000001011100010101000010110010101100010,
    48'b001101011001001111100100101011111111010000101010,
    48'b001100101001010111101100101011101111111000001000,
    48'b000100100101110101011100100101001001111010001100,
    48'b010010100111110100010101010101001001001010011101,
    48'b010010100011110000010001010101001000001111011001,
    48'b110010000010101010010010000100000100001111110011,
    48'b110001010010101010100010000010010110000011110010,
    48'b101001011001000010101010001011110110010001100000,
    48'b101100011101000111111110101011110101110000100100,
    48'b001100111111110101111101110011111001100000001100,
    48'b001010101111110001011101110101101000101100001101,
    48'b000010100110110001011111110100001000101110000101
};

logic [31:0] res_ref [$] = {
    32'b10011010001111001111100111010101,
    32'b01101010010011000110011110100101,
    32'b00111001001001101100001010110011,
    32'b00100111001010101101001000100101,
    32'b01111011110100101010001110000011,
    32'b11011011101110111010010011101011,
    32'b01101000101001100101001001011101,
    32'b10010111001110111101001001001101,
    32'b10011001111101001101100101000001,
    32'b10101100101110100000011001001101,
    32'b10000011101110101000001010100110,
    32'b01111011000011111100110101110000,
    32'b11100111100001101010100110110111,
    32'b11010011101010110010000011001101,
    32'b11001100110000011000000000010100,
    32'b01010100110001111111100111011011    
};

initial begin
    clk_in = 1'b0;
    forever #5 clk_in = ~clk_in;
end 

initial begin
    s_data_in = 'b0;
    s_data_in_valid = 'b0;
end

initial begin
    @(posedge clk_in);
    rst_n_in = 1'b1;
    @(posedge clk_in);
    s_data_in <= data_ref[0];
    s_data_in_valid <= 1'b1;
    @(posedge clk_in);
    s_data_in_valid <= 1'b0;

    repeat(10) @(posedge clk_in);
    $finish();

end

endmodule