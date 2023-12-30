module des_key (
    input logic         clk_in           ,
    input logic         rst_n_in         ,
    input logic  [55:0] sub_key_in       ,
    input logic  [3: 0] sub_key_idx_in   ,
    input logic         sub_key_in_valid ,

    output logic [47:0] key_out          ,
    output logic        key_out_valid    
);


logic [47:0]  key_out_reg       ;
logic         key_out_valid_reg ;

always_ff @( posedge clk_in or negedge rst_n_in) begin
    if( !rst_n_in ) begin
        key_out_reg <= 'b0;
        key_out_valid_reg <= 'b0;
    end else if( sub_key_in_valid ) begin
        key_out_valid_reg <= 1'b1;
        case( sub_key_idx_in ) 
        4'd0: begin
            key_out_reg = {
                sub_key_in[30], sub_key_in[55], sub_key_in[34], sub_key_in[48], sub_key_in[40], sub_key_in[44], sub_key_in[51], sub_key_in[32], 
                sub_key_in[54], sub_key_in[37], sub_key_in[47], sub_key_in[42], sub_key_in[46], sub_key_in[31], sub_key_in[43], sub_key_in[49],
                sub_key_in[38], sub_key_in[28], sub_key_in[53], sub_key_in[45], sub_key_in[35], sub_key_in[29], sub_key_in[50], sub_key_in[39],
                sub_key_in[ 0], sub_key_in[11], sub_key_in[18], sub_key_in[25], sub_key_in[ 5], sub_key_in[14], sub_key_in[ 6], sub_key_in[24],
                sub_key_in[ 2], sub_key_in[10], sub_key_in[17], sub_key_in[21], sub_key_in[ 8], sub_key_in[19], sub_key_in[ 4], sub_key_in[13],
                sub_key_in[26], sub_key_in[ 1], sub_key_in[ 3], sub_key_in[27], sub_key_in[22], sub_key_in[ 9], sub_key_in[15], sub_key_in[12]
            };
        end
        4'd1: begin
            key_out_reg ={
                sub_key_in[29], sub_key_in[54], sub_key_in[33], sub_key_in[47], sub_key_in[39], sub_key_in[43], sub_key_in[50], sub_key_in[31], 
                sub_key_in[53], sub_key_in[36], sub_key_in[46], sub_key_in[41], sub_key_in[45], sub_key_in[30], sub_key_in[42], sub_key_in[48],
                sub_key_in[37], sub_key_in[55], sub_key_in[52], sub_key_in[44], sub_key_in[34], sub_key_in[28], sub_key_in[49], sub_key_in[38],
                sub_key_in[27], sub_key_in[10], sub_key_in[17], sub_key_in[24], sub_key_in[ 4], sub_key_in[13], sub_key_in[ 5], sub_key_in[23],
                sub_key_in[ 1], sub_key_in[ 9], sub_key_in[16], sub_key_in[20], sub_key_in[ 7], sub_key_in[18], sub_key_in[ 3], sub_key_in[12],
                sub_key_in[25], sub_key_in[ 0], sub_key_in[ 2], sub_key_in[26], sub_key_in[21], sub_key_in[ 8], sub_key_in[14], sub_key_in[11]
            };
        end
        4'd2: begin
            key_out_reg ={
                sub_key_in[55], sub_key_in[52], sub_key_in[31], sub_key_in[45], sub_key_in[37], sub_key_in[41], sub_key_in[48], sub_key_in[29],
                sub_key_in[51], sub_key_in[34], sub_key_in[44], sub_key_in[39], sub_key_in[43], sub_key_in[28], sub_key_in[40], sub_key_in[46],
                sub_key_in[35], sub_key_in[53], sub_key_in[50], sub_key_in[42], sub_key_in[32], sub_key_in[54], sub_key_in[47], sub_key_in[36],
                sub_key_in[25], sub_key_in[ 8], sub_key_in[15], sub_key_in[22], sub_key_in[ 2], sub_key_in[11], sub_key_in[ 3], sub_key_in[21],
                sub_key_in[27], sub_key_in[ 7], sub_key_in[14], sub_key_in[18], sub_key_in[ 5], sub_key_in[16], sub_key_in[ 1], sub_key_in[10],
                sub_key_in[23], sub_key_in[26], sub_key_in[ 0], sub_key_in[24], sub_key_in[19], sub_key_in[ 6], sub_key_in[12], sub_key_in[ 9]
            };
        end
        4'd3: begin
            key_out_reg ={
                sub_key_in[53], sub_key_in[50], sub_key_in[29], sub_key_in[43], sub_key_in[35], sub_key_in[39], sub_key_in[46], sub_key_in[55], 
                sub_key_in[49], sub_key_in[32], sub_key_in[42], sub_key_in[37], sub_key_in[41], sub_key_in[54], sub_key_in[38], sub_key_in[44],
                sub_key_in[33], sub_key_in[51], sub_key_in[48], sub_key_in[40], sub_key_in[30], sub_key_in[52], sub_key_in[45], sub_key_in[34],
                sub_key_in[23], sub_key_in[ 6], sub_key_in[13], sub_key_in[20], sub_key_in[ 0], sub_key_in[ 9], sub_key_in[ 1], sub_key_in[19],
                sub_key_in[25], sub_key_in[ 5], sub_key_in[12], sub_key_in[16], sub_key_in[ 3], sub_key_in[14], sub_key_in[27], sub_key_in[ 8],
                sub_key_in[21], sub_key_in[24], sub_key_in[26], sub_key_in[22], sub_key_in[17], sub_key_in[ 4], sub_key_in[10], sub_key_in[ 7]
            };
        end
        4'd4: begin
            key_out_reg ={
                sub_key_in[51], sub_key_in[48], sub_key_in[55], sub_key_in[41], sub_key_in[33], sub_key_in[37], sub_key_in[44], sub_key_in[53], 
                sub_key_in[47], sub_key_in[30], sub_key_in[40], sub_key_in[35], sub_key_in[39], sub_key_in[52], sub_key_in[36], sub_key_in[42],
                sub_key_in[31], sub_key_in[49], sub_key_in[46], sub_key_in[38], sub_key_in[28], sub_key_in[50], sub_key_in[43], sub_key_in[32],
                sub_key_in[21], sub_key_in[ 4], sub_key_in[11], sub_key_in[18], sub_key_in[26], sub_key_in[ 7], sub_key_in[27], sub_key_in[17],
                sub_key_in[23], sub_key_in[ 3], sub_key_in[10], sub_key_in[14], sub_key_in[ 1], sub_key_in[12], sub_key_in[25], sub_key_in[ 6],
                sub_key_in[19], sub_key_in[22], sub_key_in[24], sub_key_in[20], sub_key_in[15], sub_key_in[ 2], sub_key_in[ 8], sub_key_in[ 5]
            };
        end
        4'd5: begin
            key_out_reg ={
                sub_key_in[49], sub_key_in[46], sub_key_in[53], sub_key_in[39], sub_key_in[31], sub_key_in[35], sub_key_in[42], sub_key_in[51], 
                sub_key_in[45], sub_key_in[28], sub_key_in[38], sub_key_in[33], sub_key_in[37], sub_key_in[50], sub_key_in[34], sub_key_in[40],
                sub_key_in[29], sub_key_in[47], sub_key_in[44], sub_key_in[36], sub_key_in[54], sub_key_in[48], sub_key_in[41], sub_key_in[30],
                sub_key_in[19], sub_key_in[ 2], sub_key_in[ 9], sub_key_in[16], sub_key_in[24], sub_key_in[ 5], sub_key_in[25], sub_key_in[15],
                sub_key_in[21], sub_key_in[ 1], sub_key_in[ 8], sub_key_in[12], sub_key_in[27], sub_key_in[10], sub_key_in[23], sub_key_in[ 4],
                sub_key_in[17], sub_key_in[20], sub_key_in[22], sub_key_in[18], sub_key_in[13], sub_key_in[ 0], sub_key_in[ 6], sub_key_in[ 3]
            };
        end
        4'd6: begin
            key_out_reg ={
                sub_key_in[47], sub_key_in[44], sub_key_in[51], sub_key_in[37], sub_key_in[29], sub_key_in[33], sub_key_in[40], sub_key_in[49], 
                sub_key_in[43], sub_key_in[54], sub_key_in[36], sub_key_in[31], sub_key_in[35], sub_key_in[48], sub_key_in[32], sub_key_in[38],
                sub_key_in[55], sub_key_in[45], sub_key_in[42], sub_key_in[34], sub_key_in[52], sub_key_in[46], sub_key_in[39], sub_key_in[28],
                sub_key_in[17], sub_key_in[ 0], sub_key_in[ 7], sub_key_in[14], sub_key_in[22], sub_key_in[ 3], sub_key_in[23], sub_key_in[13],
                sub_key_in[19], sub_key_in[27], sub_key_in[ 6], sub_key_in[10], sub_key_in[25], sub_key_in[ 8], sub_key_in[21], sub_key_in[ 2],
                sub_key_in[15], sub_key_in[18], sub_key_in[20], sub_key_in[16], sub_key_in[11], sub_key_in[26], sub_key_in[ 4], sub_key_in[ 1]
            };
        end
        4'd7: begin
            key_out_reg ={
                sub_key_in[45], sub_key_in[42], sub_key_in[49], sub_key_in[35], sub_key_in[55], sub_key_in[31], sub_key_in[38], sub_key_in[47], 
                sub_key_in[41], sub_key_in[52], sub_key_in[34], sub_key_in[29], sub_key_in[33], sub_key_in[46], sub_key_in[30], sub_key_in[36],
                sub_key_in[53], sub_key_in[43], sub_key_in[40], sub_key_in[32], sub_key_in[50], sub_key_in[44], sub_key_in[37], sub_key_in[54],
                sub_key_in[15], sub_key_in[26], sub_key_in[ 5], sub_key_in[12], sub_key_in[20], sub_key_in[ 1], sub_key_in[21], sub_key_in[11],
                sub_key_in[17], sub_key_in[25], sub_key_in[ 4], sub_key_in[ 8], sub_key_in[23], sub_key_in[ 6], sub_key_in[19], sub_key_in[ 0],
                sub_key_in[13], sub_key_in[16], sub_key_in[18], sub_key_in[14], sub_key_in[ 9], sub_key_in[24], sub_key_in[ 2], sub_key_in[27]
            };
        end
        4'd8: begin
            key_out_reg ={
                sub_key_in[44], sub_key_in[41], sub_key_in[48], sub_key_in[34], sub_key_in[54], sub_key_in[30], sub_key_in[37], sub_key_in[46], 
                sub_key_in[40], sub_key_in[51], sub_key_in[33], sub_key_in[28], sub_key_in[32], sub_key_in[45], sub_key_in[29], sub_key_in[35],
                sub_key_in[52], sub_key_in[42], sub_key_in[39], sub_key_in[31], sub_key_in[49], sub_key_in[43], sub_key_in[36], sub_key_in[53],
                sub_key_in[14], sub_key_in[25], sub_key_in[ 4], sub_key_in[11], sub_key_in[19], sub_key_in[ 0], sub_key_in[20], sub_key_in[10],
                sub_key_in[16], sub_key_in[24], sub_key_in[ 3], sub_key_in[ 7], sub_key_in[22], sub_key_in[ 5], sub_key_in[18], sub_key_in[27],
                sub_key_in[12], sub_key_in[15], sub_key_in[17], sub_key_in[13], sub_key_in[ 8], sub_key_in[23], sub_key_in[ 1], sub_key_in[26]
            };
        end
        4'd9: begin
            key_out_reg ={
                sub_key_in[42], sub_key_in[39], sub_key_in[46], sub_key_in[32], sub_key_in[52], sub_key_in[28], sub_key_in[35], sub_key_in[44], 
                sub_key_in[38], sub_key_in[49], sub_key_in[31], sub_key_in[54], sub_key_in[30], sub_key_in[43], sub_key_in[55], sub_key_in[33],
                sub_key_in[50], sub_key_in[40], sub_key_in[37], sub_key_in[29], sub_key_in[47], sub_key_in[41], sub_key_in[34], sub_key_in[51],
                sub_key_in[12], sub_key_in[23], sub_key_in[ 2], sub_key_in[ 9], sub_key_in[17], sub_key_in[26], sub_key_in[18], sub_key_in[ 8],
                sub_key_in[14], sub_key_in[22], sub_key_in[ 1], sub_key_in[ 5], sub_key_in[20], sub_key_in[ 3], sub_key_in[16], sub_key_in[25],
                sub_key_in[10], sub_key_in[13], sub_key_in[15], sub_key_in[11], sub_key_in[ 6], sub_key_in[21], sub_key_in[27], sub_key_in[24]
            };
        end
        4'd10: begin
            key_out_reg ={
                sub_key_in[40], sub_key_in[37], sub_key_in[44], sub_key_in[30], sub_key_in[50], sub_key_in[54], sub_key_in[33], sub_key_in[42], 
                sub_key_in[36], sub_key_in[47], sub_key_in[29], sub_key_in[52], sub_key_in[28], sub_key_in[41], sub_key_in[53], sub_key_in[31],
                sub_key_in[48], sub_key_in[38], sub_key_in[35], sub_key_in[55], sub_key_in[45], sub_key_in[39], sub_key_in[32], sub_key_in[49],
                sub_key_in[10], sub_key_in[21], sub_key_in[ 0], sub_key_in[ 7], sub_key_in[15], sub_key_in[24], sub_key_in[16], sub_key_in[ 6],
                sub_key_in[12], sub_key_in[20], sub_key_in[27], sub_key_in[ 3], sub_key_in[18], sub_key_in[ 1], sub_key_in[14], sub_key_in[23],
                sub_key_in[ 8], sub_key_in[11], sub_key_in[13], sub_key_in[ 9], sub_key_in[ 4], sub_key_in[19], sub_key_in[25], sub_key_in[22]
            };
        end
        4'd11: begin
            key_out_reg ={
                sub_key_in[38], sub_key_in[35], sub_key_in[42], sub_key_in[28], sub_key_in[48], sub_key_in[52], sub_key_in[31], sub_key_in[40], 
                sub_key_in[34], sub_key_in[45], sub_key_in[55], sub_key_in[50], sub_key_in[54], sub_key_in[39], sub_key_in[51], sub_key_in[29],
                sub_key_in[46], sub_key_in[36], sub_key_in[33], sub_key_in[53], sub_key_in[43], sub_key_in[37], sub_key_in[30], sub_key_in[47],
                sub_key_in[ 8], sub_key_in[19], sub_key_in[26], sub_key_in[ 5], sub_key_in[13], sub_key_in[22], sub_key_in[14], sub_key_in[ 4],
                sub_key_in[10], sub_key_in[18], sub_key_in[25], sub_key_in[ 1], sub_key_in[16], sub_key_in[27], sub_key_in[12], sub_key_in[21],
                sub_key_in[ 6], sub_key_in[ 9], sub_key_in[11], sub_key_in[ 7], sub_key_in[ 2], sub_key_in[17], sub_key_in[23], sub_key_in[20]
            };
        end
        4'd12: begin
            key_out_reg ={
                sub_key_in[36], sub_key_in[33], sub_key_in[40], sub_key_in[54], sub_key_in[46], sub_key_in[50], sub_key_in[29], sub_key_in[38], 
                sub_key_in[32], sub_key_in[43], sub_key_in[53], sub_key_in[48], sub_key_in[52], sub_key_in[37], sub_key_in[49], sub_key_in[55],
                sub_key_in[44], sub_key_in[34], sub_key_in[31], sub_key_in[51], sub_key_in[41], sub_key_in[35], sub_key_in[28], sub_key_in[45],
                sub_key_in[ 6], sub_key_in[17], sub_key_in[24], sub_key_in[ 3], sub_key_in[11], sub_key_in[20], sub_key_in[12], sub_key_in[ 2],
                sub_key_in[ 8], sub_key_in[16], sub_key_in[23], sub_key_in[27], sub_key_in[14], sub_key_in[25], sub_key_in[10], sub_key_in[19],
                sub_key_in[ 4], sub_key_in[ 7], sub_key_in[ 9], sub_key_in[ 5], sub_key_in[ 0], sub_key_in[15], sub_key_in[21], sub_key_in[18]
            };
        end
        4'd13: begin
            key_out_reg ={
                sub_key_in[34], sub_key_in[31], sub_key_in[38], sub_key_in[52], sub_key_in[44], sub_key_in[48], sub_key_in[55], sub_key_in[36], 
                sub_key_in[30], sub_key_in[41], sub_key_in[51], sub_key_in[46], sub_key_in[50], sub_key_in[35], sub_key_in[47], sub_key_in[53],
                sub_key_in[42], sub_key_in[32], sub_key_in[29], sub_key_in[49], sub_key_in[39], sub_key_in[33], sub_key_in[54], sub_key_in[43],
                sub_key_in[ 4], sub_key_in[15], sub_key_in[22], sub_key_in[ 1], sub_key_in[ 9], sub_key_in[18], sub_key_in[10], sub_key_in[ 0],
                sub_key_in[ 6], sub_key_in[14], sub_key_in[21], sub_key_in[25], sub_key_in[12], sub_key_in[23], sub_key_in[ 8], sub_key_in[17],
                sub_key_in[ 2], sub_key_in[ 5], sub_key_in[ 7], sub_key_in[ 3], sub_key_in[26], sub_key_in[13], sub_key_in[19], sub_key_in[16]
            };
        end
        4'd14: begin
            key_out_reg ={
                sub_key_in[32], sub_key_in[29], sub_key_in[36], sub_key_in[50], sub_key_in[42], sub_key_in[46], sub_key_in[53], sub_key_in[34], 
                sub_key_in[28], sub_key_in[39], sub_key_in[49], sub_key_in[44], sub_key_in[48], sub_key_in[33], sub_key_in[45], sub_key_in[51],
                sub_key_in[40], sub_key_in[30], sub_key_in[55], sub_key_in[47], sub_key_in[37], sub_key_in[31], sub_key_in[52], sub_key_in[41],
                sub_key_in[ 2], sub_key_in[13], sub_key_in[20], sub_key_in[27], sub_key_in[ 7], sub_key_in[16], sub_key_in[ 8], sub_key_in[26],
                sub_key_in[ 4], sub_key_in[12], sub_key_in[19], sub_key_in[23], sub_key_in[10], sub_key_in[21], sub_key_in[ 6], sub_key_in[15],
                sub_key_in[ 0], sub_key_in[ 3], sub_key_in[ 5], sub_key_in[ 1], sub_key_in[24], sub_key_in[11], sub_key_in[17], sub_key_in[14]
            };
        end
        4'd15: begin
            key_out_reg ={
                sub_key_in[31], sub_key_in[28], sub_key_in[35], sub_key_in[49], sub_key_in[41], sub_key_in[45], sub_key_in[52], sub_key_in[33],
                sub_key_in[55], sub_key_in[38], sub_key_in[48], sub_key_in[43], sub_key_in[47], sub_key_in[32], sub_key_in[44], sub_key_in[50],
                sub_key_in[39], sub_key_in[29], sub_key_in[54], sub_key_in[46], sub_key_in[36], sub_key_in[30], sub_key_in[51], sub_key_in[40],
                sub_key_in[ 1], sub_key_in[12], sub_key_in[19], sub_key_in[26], sub_key_in[ 6], sub_key_in[15], sub_key_in[ 7], sub_key_in[25],
                sub_key_in[ 3], sub_key_in[11], sub_key_in[18], sub_key_in[22], sub_key_in[ 9], sub_key_in[20], sub_key_in[ 5], sub_key_in[14],
                sub_key_in[27], sub_key_in[ 2], sub_key_in[ 4], sub_key_in[ 0], sub_key_in[23], sub_key_in[10], sub_key_in[16], sub_key_in[13]
            };
        end
        default: begin
            key_out_reg <= 'b0;
            key_out_valid_reg <= 'b0;
        end
        endcase
    end else begin
        key_out_reg <= key_out_reg;
        key_out_valid_reg <= 'b0;
    end
end

assign key_out = key_out_reg             ;
assign key_out_valid = key_out_valid_reg ;

endmodule