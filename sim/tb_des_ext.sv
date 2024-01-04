module tb_des_ext();
import show_info_pkg::*;

logic        clk_in             ;
logic        rst_n_in           ;
logic [31:0] ext_data_in        ;
logic        ext_data_in_valid  ;
logic [47:0] ext_data_out       ;
logic        ext_data_out_valid ;

des_ext des_ext_inst(
    .clk_in             (clk_in            ),
    .rst_n_in           (rst_n_in          ),
    .ext_data_in        (ext_data_in       ),
    .ext_data_in_valid  (ext_data_in_valid ),

    .ext_data_out       (ext_data_out      ),
    .ext_data_out_valid (ext_data_out_valid)
);

logic [31:0] ext_data_in_ref[$] = {
    32'b10010001100110010010000110101001,
    32'b00101100010001010010110000100000,
    32'b00000000000111001111001100000010
};

logic [47:0] ext_data_out_ref[$] = {
    48'b110010100011110011110010100100000011110101010011,
    48'b000101011000001000001010100101011000000100000000,
    48'b000000000000000011111001011110100110100000000100
};

task test(input int idx);
    @(posedge clk_in);
    ext_data_in <= ext_data_in_ref[idx];
    ext_data_in_valid <= 1'b1;
endtask

initial begin
    clk_in = 1'b0;
    forever #5 clk_in = ~clk_in;
end

initial begin
    rst_n_in = 'b0;
    ext_data_in = 'b0;
    ext_data_in_valid = 1'b0;
end

initial begin
    @(posedge clk_in);
    rst_n_in = 1'b1;

    for(int idx =0;idx<ext_data_in_ref.size();idx++) begin
        test(idx);
        while(1) begin
            @(posedge clk_in);
            ext_data_in_valid = 1'b0;
            if( ext_data_out_valid == 1'b1) begin
                break;
            end
        end
        if( ext_data_out != ext_data_out_ref[idx] ) begin
            show_fail();
            $finish();
        end
    end

    show_pass();
    $finish();
end

endmodule