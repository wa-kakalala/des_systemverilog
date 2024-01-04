module tb_des_ip();
import show_info_pkg::*;

logic        clk_in         ;
logic        rst_n_in       ;
logic [63:0] data_in        ;
logic        data_in_valid  ;
logic [31:0] left_data_out  ;
logic [31:0] right_data_out ;
logic        data_out_valid ;

des_ip des_ip_inst(
    .clk_in         (clk_in       ),
    .rst_n_in       (rst_n_in     ),
    .data_in        (data_in      ),
    .data_in_valid  (data_in_valid),

    .left_data_out  (left_data_out ),
    .right_data_out (right_data_out),
    .data_out_valid (data_out_valid)
);

initial begin
    clk_in = 1'b0;
    forever #5 clk_in = ~clk_in;
end

initial begin
    rst_n_in = 1'b0;
    data_in  = 'b0;
    data_in_valid = 'b0;
end

logic [63:0] data_ref[$] = {
    64'b1010101010101010101010101010101010101010101010101010101010101010,
    64'b0111001100010001011111110000101110010111100111010100111001001110,
    64'b1111001010000111101000100010101001001001011101011000011011010000
};

logic [63:0] score_board[$] = {
    64'b1111111111111111111111111111111100000000000000000000000000000000,
    64'b0011000000000101111011001101110111000101001101111111010000111111,
    64'b1100011100101101000110000100111110110001101000010110001000110010
};

task test(input int idx);
    @(posedge clk_in);
    data_in <= data_ref[idx]  ;
    data_in_valid <= 1'b1;
endtask

initial begin
    @(posedge clk_in);
    rst_n_in <= 1'b1;

    for( int idx = 0;idx <data_ref.size();idx++ ) begin
        test(idx);
        while( 1 ) begin
            @(posedge clk_in);
            data_in_valid <= 1'b0;
            if( data_out_valid == 1'b1) begin
                break;
            end
        end

        if( {left_data_out,right_data_out} != score_board[idx]) begin
            show_fail();
            $finish();
        end 
    end
    show_pass();
    $finish();

end
endmodule