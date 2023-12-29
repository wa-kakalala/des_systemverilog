module des_key (
    input logic         clk_in           ,
    input logic         rst_n_in         ,
    input logic  [63:0] key_in           ,
    input logic  [3: 0] key_idx_in       ,
    input logic         key_in_valid     ,

    output logic [47:0] key_out          ,
    output logic        key_out_valid    
);


logic [47:0]  key_out_reg       ;
logic         key_out_valid_reg ;

always_ff @( posedge clk_in or negedge rst_n_in) begin
    if( !rst_n_in ) begin
        key_out_reg <= 'b0;
        key_out_valid_reg <= 'b0;
    end else if( key_in_valid ) begin
        key_out_valid_reg <= 1'b1;
        case( key_idx_in ) 
        4'd0: begin
            key_out_reg = {
                key_in[12], key_in[15], key_in[ 9], key_in[22], key_in[27], key_in[ 3], key_in[ 1], key_in[26], 
                key_in[13], key_in[ 4], key_in[19], key_in[ 8], key_in[21], key_in[17], key_in[10], key_in[ 2], 
                key_in[24], key_in[ 6], key_in[14], key_in[ 5], key_in[25], key_in[18], key_in[11], key_in[ 0], 
                key_in[39], key_in[50], key_in[29], key_in[35], key_in[45], key_in[53], key_in[28], key_in[38], 
                key_in[49], key_in[43], key_in[31], key_in[46], key_in[42], key_in[47], key_in[37], key_in[54], 
                key_in[32], key_in[51], key_in[44], key_in[40], key_in[48], key_in[34], key_in[55], key_in[30]
            };
        end
        4'd1: begin
            key_out_reg ={
                key_in[11], key_in[14], key_in[ 8], key_in[21], key_in[26], key_in[ 2], key_in[ 0], key_in[25], 
                key_in[12], key_in[ 3], key_in[18], key_in[ 7], key_in[20], key_in[16], key_in[ 9], key_in[ 1], 
                key_in[23], key_in[ 5], key_in[13], key_in[ 4], key_in[24], key_in[17], key_in[10], key_in[27], 
                key_in[38], key_in[49], key_in[28], key_in[34], key_in[44], key_in[52], key_in[55], key_in[37], 
                key_in[48], key_in[42], key_in[30], key_in[45], key_in[41], key_in[46], key_in[36], key_in[53], 
                key_in[31], key_in[50], key_in[43], key_in[39], key_in[47], key_in[33], key_in[54], key_in[29]
            };
        end
        4'd2: begin
            key_out_reg ={
                key_in[ 9], key_in[12], key_in[ 6], key_in[19], key_in[24], key_in[ 0], key_in[26], key_in[23], 
                key_in[10], key_in[ 1], key_in[16], key_in[ 5], key_in[18], key_in[14], key_in[ 7], key_in[27],
                key_in[21], key_in[ 3], key_in[11], key_in[ 2], key_in[22], key_in[15], key_in[ 8], key_in[25],
                key_in[36], key_in[47], key_in[54], key_in[32], key_in[42], key_in[50], key_in[53], key_in[35],
                key_in[46], key_in[40], key_in[28], key_in[43], key_in[39], key_in[44], key_in[34], key_in[51],
                key_in[29], key_in[48], key_in[41], key_in[37], key_in[45], key_in[31], key_in[52], key_in[55]
            };
        end
        4'd3: begin
            key_out_reg ={
                key_in[ 7], key_in[10], key_in[ 4], key_in[17], key_in[22], key_in[26], key_in[24], key_in[21], 
                key_in[ 8], key_in[27], key_in[14], key_in[ 3], key_in[16], key_in[12], key_in[ 5], key_in[25],
                key_in[19], key_in[ 1], key_in[ 9], key_in[ 0], key_in[20], key_in[13], key_in[ 6], key_in[23],
                key_in[34], key_in[45], key_in[52], key_in[30], key_in[40], key_in[48], key_in[51], key_in[33],
                key_in[44], key_in[38], key_in[54], key_in[41], key_in[37], key_in[42], key_in[32], key_in[49],
                key_in[55], key_in[46], key_in[39], key_in[35], key_in[43], key_in[29], key_in[50], key_in[53]
            };
        end
        4'd4: begin
            key_out_reg ={
                key_in[ 5], key_in[ 8], key_in[ 2], key_in[15], key_in[20], key_in[24], key_in[22], key_in[19], 
                key_in[ 6], key_in[25], key_in[12], key_in[ 1], key_in[14], key_in[10], key_in[ 3], key_in[23],
                key_in[17], key_in[27], key_in[ 7], key_in[26], key_in[18], key_in[11], key_in[ 4], key_in[21],
                key_in[32], key_in[43], key_in[50], key_in[28], key_in[38], key_in[46], key_in[49], key_in[31],
                key_in[42], key_in[36], key_in[52], key_in[39], key_in[35], key_in[40], key_in[30], key_in[47],
                key_in[53], key_in[44], key_in[37], key_in[33], key_in[41], key_in[55], key_in[48], key_in[51]
            };
        end
        4'd5: begin
            key_out_reg ={
                key_in[ 3], key_in[ 6], key_in[ 0], key_in[13], key_in[18], key_in[22], key_in[20], key_in[17], 
                key_in[ 4], key_in[23], key_in[10], key_in[27], key_in[12], key_in[ 8], key_in[ 1], key_in[21],
                key_in[15], key_in[25], key_in[ 5], key_in[24], key_in[16], key_in[ 9], key_in[ 2], key_in[19],
                key_in[30], key_in[41], key_in[48], key_in[54], key_in[36], key_in[44], key_in[47], key_in[29],
                key_in[40], key_in[34], key_in[50], key_in[37], key_in[33], key_in[38], key_in[28], key_in[45],
                key_in[51], key_in[42], key_in[35], key_in[31], key_in[39], key_in[53], key_in[46], key_in[49]
            };
        end
        4'd6: begin
            key_out_reg ={
                key_in[ 1], key_in[ 4], key_in[26], key_in[11], key_in[16], key_in[20], key_in[18], key_in[15], 
                key_in[ 2], key_in[21], key_in[ 8], key_in[25], key_in[10], key_in[ 6], key_in[27], key_in[19],
                key_in[13], key_in[23], key_in[ 3], key_in[22], key_in[14], key_in[ 7], key_in[ 0], key_in[17],
                key_in[28], key_in[39], key_in[46], key_in[52], key_in[34], key_in[42], key_in[45], key_in[55],
                key_in[38], key_in[32], key_in[48], key_in[35], key_in[31], key_in[36], key_in[54], key_in[43],
                key_in[49], key_in[40], key_in[33], key_in[29], key_in[37], key_in[51], key_in[44], key_in[47]
            };
        end
        4'd7: begin
            key_out_reg ={
                key_in[27], key_in[ 2], key_in[24], key_in[ 9], key_in[14], key_in[18], key_in[16], key_in[13], 
                key_in[ 0], key_in[19], key_in[ 6], key_in[23], key_in[ 8], key_in[ 4], key_in[25], key_in[17],
                key_in[11], key_in[21], key_in[ 1], key_in[20], key_in[12], key_in[ 5], key_in[26], key_in[15],
                key_in[54], key_in[37], key_in[44], key_in[50], key_in[32], key_in[40], key_in[43], key_in[53],
                key_in[36], key_in[30], key_in[46], key_in[33], key_in[29], key_in[34], key_in[52], key_in[41],
                key_in[47], key_in[38], key_in[31], key_in[55], key_in[35], key_in[49], key_in[42], key_in[45]
            };
        end
        4'd8: begin
            key_out_reg ={
                key_in[26], key_in[ 1], key_in[23], key_in[ 8], key_in[13], key_in[17], key_in[15], key_in[12], 
                key_in[27], key_in[18], key_in[ 5], key_in[22], key_in[ 7], key_in[ 3], key_in[24], key_in[16],
                key_in[10], key_in[20], key_in[ 0], key_in[19], key_in[11], key_in[ 4], key_in[25], key_in[14],
                key_in[53], key_in[36], key_in[43], key_in[49], key_in[31], key_in[39], key_in[42], key_in[52],
                key_in[35], key_in[29], key_in[45], key_in[32], key_in[28], key_in[33], key_in[51], key_in[40],
                key_in[46], key_in[37], key_in[30], key_in[54], key_in[34], key_in[48], key_in[41], key_in[44]
            };
        end
        4'd9: begin
            key_out_reg ={
                key_in[24], key_in[27], key_in[21], key_in[ 6], key_in[11], key_in[15], key_in[13], key_in[10], 
                key_in[25], key_in[16], key_in[ 3], key_in[20], key_in[ 5], key_in[ 1], key_in[22], key_in[14],
                key_in[ 8], key_in[18], key_in[26], key_in[17], key_in[ 9], key_in[ 2], key_in[23], key_in[12],
                key_in[51], key_in[34], key_in[41], key_in[47], key_in[29], key_in[37], key_in[40], key_in[50],
                key_in[33], key_in[55], key_in[43], key_in[30], key_in[54], key_in[31], key_in[49], key_in[38],
                key_in[44], key_in[35], key_in[28], key_in[52], key_in[32], key_in[46], key_in[39], key_in[42]
            };
        end
        4'd10: begin
            key_out_reg ={
                key_in[22], key_in[25], key_in[19], key_in[ 4], key_in[ 9], key_in[13], key_in[11], key_in[ 8], 
                key_in[23], key_in[14], key_in[ 1], key_in[18], key_in[ 3], key_in[27], key_in[20], key_in[12],
                key_in[ 6], key_in[16], key_in[24], key_in[15], key_in[ 7], key_in[ 0], key_in[21], key_in[10],
                key_in[49], key_in[32], key_in[39], key_in[45], key_in[55], key_in[35], key_in[38], key_in[48],
                key_in[31], key_in[53], key_in[41], key_in[28], key_in[52], key_in[29], key_in[47], key_in[36],
                key_in[42], key_in[33], key_in[54], key_in[50], key_in[30], key_in[44], key_in[37], key_in[40]
            };
        end
        4'd11: begin
            key_out_reg ={
                key_in[20], key_in[23], key_in[17], key_in[ 2], key_in[ 7], key_in[11], key_in[ 9], key_in[ 6], 
                key_in[21], key_in[12], key_in[27], key_in[16], key_in[ 1], key_in[25], key_in[18], key_in[10],
                key_in[ 4], key_in[14], key_in[22], key_in[13], key_in[ 5], key_in[26], key_in[19], key_in[ 8],
                key_in[47], key_in[30], key_in[37], key_in[43], key_in[53], key_in[33], key_in[36], key_in[46],
                key_in[29], key_in[51], key_in[39], key_in[54], key_in[50], key_in[55], key_in[45], key_in[34],
                key_in[40], key_in[31], key_in[52], key_in[48], key_in[28], key_in[42], key_in[35], key_in[38]
            };
        end
        4'd12: begin
            key_out_reg ={
                key_in[18], key_in[21], key_in[15], key_in[ 0], key_in[ 5], key_in[ 9], key_in[ 7], key_in[ 4], 
                key_in[19], key_in[10], key_in[25], key_in[14], key_in[27], key_in[23], key_in[16], key_in[ 8],
                key_in[ 2], key_in[12], key_in[20], key_in[11], key_in[ 3], key_in[24], key_in[17], key_in[ 6],
                key_in[45], key_in[28], key_in[35], key_in[41], key_in[51], key_in[31], key_in[34], key_in[44],
                key_in[55], key_in[49], key_in[37], key_in[52], key_in[48], key_in[53], key_in[43], key_in[32],
                key_in[38], key_in[29], key_in[50], key_in[46], key_in[54], key_in[40], key_in[33], key_in[36]
            };
        end
        4'd13: begin
            key_out_reg ={
                key_in[16], key_in[19], key_in[13], key_in[26], key_in[ 3], key_in[ 7], key_in[ 5], key_in[ 2], 
                key_in[17], key_in[ 8], key_in[23], key_in[12], key_in[25], key_in[21], key_in[14], key_in[ 6],
                key_in[ 0], key_in[10], key_in[18], key_in[ 9], key_in[ 1], key_in[22], key_in[15], key_in[ 4],
                key_in[43], key_in[54], key_in[33], key_in[39], key_in[49], key_in[29], key_in[32], key_in[42],
                key_in[53], key_in[47], key_in[35], key_in[50], key_in[46], key_in[51], key_in[41], key_in[30],
                key_in[36], key_in[55], key_in[48], key_in[44], key_in[52], key_in[38], key_in[31], key_in[34]
            };
        end
        4'd14: begin
            key_out_reg ={
                key_in[14], key_in[17], key_in[11], key_in[24], key_in[ 1], key_in[ 5], key_in[ 3], key_in[ 0], 
                key_in[15], key_in[ 6], key_in[21], key_in[10], key_in[23], key_in[19], key_in[12], key_in[ 4],
                key_in[26], key_in[ 8], key_in[16], key_in[ 7], key_in[27], key_in[20], key_in[13], key_in[ 2],
                key_in[41], key_in[52], key_in[31], key_in[37], key_in[47], key_in[55], key_in[30], key_in[40],
                key_in[51], key_in[45], key_in[33], key_in[48], key_in[44], key_in[49], key_in[39], key_in[28],
                key_in[34], key_in[53], key_in[46], key_in[42], key_in[50], key_in[36], key_in[29], key_in[32]
        };
        end
        4'd15: begin
            key_out_reg ={
                key_in[13], key_in[16], key_in[10], key_in[23], key_in[ 0], key_in[ 4], key_in[ 2], key_in[27], 
                key_in[14], key_in[ 5], key_in[20], key_in[ 9], key_in[22], key_in[18], key_in[11], key_in[ 3],
                key_in[25], key_in[ 7], key_in[15], key_in[ 6], key_in[26], key_in[19], key_in[12], key_in[ 1],
                key_in[40], key_in[51], key_in[30], key_in[36], key_in[46], key_in[54], key_in[29], key_in[39],
                key_in[50], key_in[44], key_in[32], key_in[47], key_in[43], key_in[48], key_in[38], key_in[55],
                key_in[33], key_in[52], key_in[45], key_in[41], key_in[49], key_in[35], key_in[28], key_in[31]
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