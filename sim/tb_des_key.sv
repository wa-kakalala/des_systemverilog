module tb_des_key();
import show_info_pkg::*;
///////////////////////////////////////
logic  [63:0] origin_key_in       ;
logic         verify_in           ;  
logic         origin_key_in_valid ;  

logic [55:0] sub_key_out          ;
logic        sub_key_out_valid    ;  
logic        sub_key_err_out      ;
///////////////////////////////////////
logic         clk_in            ;  
logic         rst_n_in          ;  
logic  [55:0] sub_key_in        ;  
logic  [3: 0] sub_key_idx_in    ;  
logic         sub_key_in_valid  ;  
logic  [47:0] key_out           ; 
logic         key_out_valid     ; 

des_key_check des_key_check_inst(
    .clk_in             (clk_in             ),
    .rst_n_in           (rst_n_in           ),
    .origin_key_in      (origin_key_in      ),
    .verify_in          (verify_in          ),
    .origin_key_in_valid(origin_key_in_valid),

    .sub_key_out        (sub_key_out      ),
    .sub_key_out_valid  (sub_key_out_valid),
    .sub_key_err_out    (sub_key_err_out  )
);

des_key des_key_inst (
    .clk_in           (clk_in           ),
    .rst_n_in         (rst_n_in         ),
    .sub_key_in       (sub_key_in       ),
    .sub_key_idx_in   (sub_key_idx_in   ),
    .sub_key_in_valid (sub_key_in_valid ),

    .key_out          (key_out      ),
    .key_out_valid    (key_out_valid)
);

logic [63:0] key_ref = 64'b0101010101010101010101010101010101010101010101010101010101010101;

logic [47:0] key_score_board [$] = {
    48'b101101110010110101011110101010101011011001101000,
    48'b101100110010110100011110001010111011111001101000,
    48'b001100111110010110101010000110110101111010101100,
    48'b011010101100000111101011110110110101100010011101,
    48'b110010101101000011101101110101011100100111010101,
    48'b110011011101011011100101110101001100001111110111,
    48'b111011010001111001010101111011101010001101110011,
    48'b101101010011111000011100001011101010111101100010,
    48'b101101010111111100011000001011101011111000100110,
    48'b001101110110100110011011011010100111111000001100,
    48'b001110100110100110101011011100110101110100001101,
    48'b010110101101001110100011010101010101100110011111,
    48'b010011101001001011110111110101010110000111011011,
    48'b110011001011111001110100101101011010010111110011,
    48'b110101011011111101010100101011001011011011110010,
    48'b111101010010111101010110101010101011011001111010
};

task automatic get_key(input logic [3:0] key_idx, input logic [55:0] key);
    @(posedge clk_in); #1;
    sub_key_idx_in = key_idx;
    sub_key_in = key;
    sub_key_in_valid = 1'b1;
endtask

initial begin
    clk_in = 0;
    forever #5 clk_in = ~clk_in;
end

initial begin
    rst_n_in = 1'b0;
    sub_key_in = 'b0;
    sub_key_idx_in = 'b0;
    sub_key_in_valid = 1'b0;
    origin_key_in = 'b0;
    verify_in = 'b0;
    origin_key_in_valid = 'b0;
end

initial begin
    @(posedge clk_in); #1;
    rst_n_in = 1'b1;
    @(posedge clk_in); #1;
    origin_key_in = key_ref;
    verify_in = 1'b0;
    origin_key_in_valid = 1'b1;
    @(posedge sub_key_out_valid); #1;
    for( int i=0;i<key_score_board.size();i++) begin
        get_key(i,sub_key_out);
        while (1) begin
            @(posedge clk_in ); #1;
            if(key_out_valid == 1 ) begin
                break;
            end
        end
        if( key_out != key_score_board[i]) begin
            show_fail();
            $finish();
        end else begin
            $display("%d -> ok",i);
        end
    end

    show_pass();
    $finsh();
end

endmodule