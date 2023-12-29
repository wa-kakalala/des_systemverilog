module tb_des_key();

logic         clk_in        ;  
logic         rst_n_in      ;  
logic  [63:0] key_in        ;  
logic  [3: 0] key_idx_in    ;  
logic         key_in_valid  ;  
logic  [47:0] key_out       ; 
logic         key_out_valid ; 

des_key des_key_inst (
    .clk_in           (clk_in       ),
    .rst_n_in         (rst_n_in     ),
    .key_in           (key_in       ),
    .key_idx_in       (key_idx_in   ),
    .key_in_valid     (key_in_valid ),

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

task automatic get_key(input logic [3:0] key_idx, input logic [64:0] key);
    @(posedge clk_in); #1;
    key_idx_in = key_idx;
    key_in = key;
    key_in_valid = 1'b1;
endtask

task automatic show_pass();
begin: pass
    $display("pwd: %m");
    $display(".----------------.  .----------------.  .----------------.  .----------------. " ); 
    $display("| .--------------. || .--------------. || .--------------. || .--------------. |");
    $display("| |   ______     | || |      __      | || |    _______   | || |    _______   | |");
    $display("| |  |_   __ \   | || |     /  \     | || |   /  ___  |  | || |   /  ___  |  | |");
    $display("| |    | |__) |  | || |    / /\ \    | || |  |  (__ \_|  | || |  |  (__ \_|  | |");
    $display("| |    |  ___/   | || |   / ____ \   | || |   '.___`-.   | || |   '.___`-.   | |");
    $display("| |   _| |_      | || | _/ /    \ \_ | || |  |`\____) |  | || |  |`\____) |  | |");
    $display("| |  |_____|     | || ||____|  |____|| || |  |_______.'  | || |  |_______.'  | |");
    $display("| |              | || |              | || |              | || |              | |");
    $display("| '--------------' || '--------------' || '--------------' || '--------------' |");
    $display("'----------------'  '----------------'  '----------------'  '----------------' " );   
    $display("time: %t",$time );
end
endtask

task automatic show_fail();
begin: fail
    $display("pwd: %m");
    $display(".----------------.  .----------------.  .----------------.  .----------------. " ); 
    $display("| .--------------. || .--------------. || .--------------. || .--------------. |");
    $display("| |  _________   | || |      __      | || |     _____    | || |   _____      | |");
    $display("| | |_   ___  |  | || |     /  \     | || |    |_   _|   | || |  |_   _|     | |");
    $display("| |   |  _|      | || |   / ____ \   | || |      | |     | || |    | |   _   | |");
    $display("| |  _| |_       | || | _/ /    \ \_ | || |     _| |_    | || |   _| |__/ |  | |");
    $display("| | |_____|      | || ||____|  |____|| || |    |_____|   | || |  |________|  | |");
    $display("| |              | || |              | || |              | || |              | |");
    $display("| '--------------' || '--------------' || '--------------' || '--------------' |");
    $display("'----------------'  '----------------'  '----------------'  '----------------' " );
    $display("time: %t",$time );
end
endtask

initial begin
    clk_in = 0;
    forever #5 clk_in = ~clk_in;
end

initial begin
    rst_n_in = 1'b0;
    key_in = 64'b0;
    key_idx_in = 16'b0;
    key_in_valid = 1'b0;
end

initial begin
    @(posedge clk_in); #1;
    rst_n_in = 1'b1;
    for( int i=0;i<key_score_board.size();i++) begin
        get_key(i,key_ref);
        @(posedge key_out_valid); #1;
        if( key_out != key_score_board[i]) begin
            show_fail();
            $finish();
        end
    end

    show_pass();
    $finsh();
end

endmodule