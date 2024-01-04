module des_scomp(
    input  logic        clk_in          ,
    input  logic        rst_n_in        ,
    input  logic [47:0] s_data_in       ,
    input  logic        s_data_in_valid ,

    output logic [31:0] scomp_out       ,
    output logic        scomp_out_valid 
);

logic [3:0] s_table_1 [0:63];
logic [3:0] s_table_2 [0:63];
logic [3:0] s_table_3 [0:63];
logic [3:0] s_table_4 [0:63];
logic [3:0] s_table_5 [0:63];
logic [3:0] s_table_6 [0:63];
logic [3:0] s_table_7 [0:63];
logic [3:0] s_table_8 [0:63];

initial begin
    $readmemh("./s_table_dat/s_table_1.dat",s_table_1);
    $readmemh("./s_table_dat/s_table_2.dat",s_table_2);
    $readmemh("./s_table_dat/s_table_3.dat",s_table_3);
    $readmemh("./s_table_dat/s_table_4.dat",s_table_4);
    $readmemh("./s_table_dat/s_table_5.dat",s_table_5);
    $readmemh("./s_table_dat/s_table_6.dat",s_table_6);
    $readmemh("./s_table_dat/s_table_7.dat",s_table_7);
    $readmemh("./s_table_dat/s_table_8.dat",s_table_8);
end

logic [31:0] scomp_out_reg      ;
logic        scomp_out_valid_reg;

always_ff @(posedge clk_in or negedge rst_n_in) begin
    if( ! rst_n_in ) begin
        scomp_out_reg <= 'b0;
        scomp_out_valid_reg <= 1'b0;
    end else if( s_data_in_valid ) begin
        scomp_out_valid_reg <= 1'b1;
        {scomp_out_reg[0] ,scomp_out_reg[1] ,scomp_out_reg[2] ,scomp_out_reg[3]} <= s_table_1[{s_data_in[0] ,s_data_in[5] ,s_data_in[1] ,s_data_in[2] ,s_data_in[3] ,s_data_in[4]}] ;
        {scomp_out_reg[4] ,scomp_out_reg[5] ,scomp_out_reg[6] ,scomp_out_reg[7]} <= s_table_2[{s_data_in[6] ,s_data_in[11],s_data_in[7] ,s_data_in[8] ,s_data_in[9] ,s_data_in[10]}];
        {scomp_out_reg[8] ,scomp_out_reg[9] ,scomp_out_reg[10],scomp_out_reg[11]}<= s_table_3[{s_data_in[12],s_data_in[17],s_data_in[13],s_data_in[14],s_data_in[15],s_data_in[16]}];
        {scomp_out_reg[12],scomp_out_reg[13],scomp_out_reg[14],scomp_out_reg[15]}<= s_table_4[{s_data_in[18],s_data_in[23],s_data_in[19],s_data_in[20],s_data_in[21],s_data_in[22]}];
        {scomp_out_reg[16],scomp_out_reg[17],scomp_out_reg[18],scomp_out_reg[19]}<= s_table_5[{s_data_in[24],s_data_in[29],s_data_in[25],s_data_in[26],s_data_in[27],s_data_in[28]}];
        {scomp_out_reg[20],scomp_out_reg[21],scomp_out_reg[22],scomp_out_reg[23]}<= s_table_6[{s_data_in[30],s_data_in[35],s_data_in[31],s_data_in[32],s_data_in[33],s_data_in[34]}];
        {scomp_out_reg[24],scomp_out_reg[25],scomp_out_reg[26],scomp_out_reg[27]}<= s_table_7[{s_data_in[36],s_data_in[41],s_data_in[37],s_data_in[38],s_data_in[39],s_data_in[40]}];
        {scomp_out_reg[28],scomp_out_reg[29],scomp_out_reg[30],scomp_out_reg[31]}<= s_table_8[{s_data_in[42],s_data_in[47],s_data_in[43],s_data_in[44],s_data_in[45],s_data_in[46]}];
    end else begin
        scomp_out_reg <= scomp_out_reg;
        scomp_out_valid_reg <= 1'b0;
    end
end

assign scomp_out = scomp_out_reg;
assign scomp_out_valid = scomp_out_valid_reg;

endmodule