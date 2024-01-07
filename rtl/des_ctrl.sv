/**************************************
@ filename    : des_ctrl.sv
@ author      : yyrwkk
@ create time : 2024/01/07 14:52:59
@ version     : v1.0.0
**************************************/
module des_ctrl (
    input logic         clk_in                   ,
    input logic         rst_n_in                 ,

    input logic         encrypt_in_valid         ,
    input logic         mode_in                  ,

    input logic  [55:0] sub_key_in               ,
    input logic         sub_key_in_valid         ,
    input logic         check_error_in           ,

    input logic         data_in_valid            ,
    input logic  [31:0] right_data_in            ,
    input logic  [31:0] left_data_in             ,

    input logic         xor32_data_in_valid      ,
    input logic  [31:0] xor32_data_in            ,

    output logic [55:0] sub_key_out              ,
    output logic [3:0]  sub_key_idx_out          ,
    output logic        sub_key_out_valid        ,

    output logic [63:0] inv_data_out             , 
    output logic        inv_data_out_valid       ,
    output logic        encrypt_ready

);
typedef enum { 
    S_IDLE ,
    S_CHECK,
    S_EXT  ,
    S_XOR48,
    S_SCOMP,
    S_P    ,
    S_XOR32,
    S_ITER ,
    S_INVIP
} fsm_state_e;

fsm_state_e curr_state;
fsm_state_e next_state;

logic [3:0]  iter;
logic        mode;
logic [55:0] sub_key;

/**
* @ bref: 寄存mode_in信号 
*/
always_ff @( posedge clk_in or negedge rst_n_in) begin
    if( !rst_n_in ) begin
        mode <= 'b0;
    end else if(encrypt_in_valid) begin
        mode <= mode_in;
    end else begin
        mode <= mode;
    end
end

/**
* @ bref: 寄存sub_key_in 信号
*/
always_ff @( posedge clk_in or negedge rst_n_in) begin
    if( !rst_n_in ) begin
        sub_key <= 'b0;
    end else if(sub_key_in_valid) begin
        sub_key <= sub_key_in;
    end else begin
        sub_key <= sub_key;
    end
end


/**
* @ bref: 三段式状态机的第一段
*/
always_ff @(posedge clk_in or negedge rst_n_in ) begin
    if( !rst_n_in ) begin
        curr_state <= S_IDLE;
    end else begin
        curr_state <= next_state;
    end
end

/**
* @ bref: 三段式状态机的第二段
*/
always_comb begin
    if( !rst_n_in ) begin
        next_state = S_IDLE;
    end else begin
        case( curr_state ) 
        S_IDLE : begin
            if( encrypt_in_valid ) begin
                next_state = S_CHECK;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_CHECK: begin
            if( sub_key_in_valid ) begin
                if( !check_error_in ) begin
                    next_state = S_EXT;
                end else begin
                    next_state = S_IDLE;
                end
            end else begin
                next_state = S_CHECK;
            end 
        end
        S_EXT  : begin
            next_state = S_XOR48;
        end
        S_XOR48: begin
            next_state = S_SCOMP;
        end
        S_SCOMP: begin
            next_state = S_P;
        end
        S_P    : begin
            next_state = S_XOR32;
        end
        S_XOR32: begin
            next_state = S_ITER;
        end
        S_ITER : begin
            if( iter == 4'hf ) begin
                next_state = S_INVIP;
            end else begin
                next_state = S_EXT;
            end
        end
        S_INVIP: begin
            next_state = S_IDLE;
        end
        default: begin
            next_state = S_IDLE;
        end
        endcase
    end
end

/**
* @ bref: 三段式状态机的第三段
* @ note：使用next_state 可以节省一个时钟周期
*/
always_ff @(posedge clk_in or negedge rst_n_in ) begin
    if( !rst_n_in ) begin
        iter <= 4'b0;
        encrypt_ready <= 1'b1;
    end else begin
        iter <= iter;
        encrypt_ready <= 1'b0;

        case( next_state ) 
        S_IDLE : begin
            iter <= 'b0;
            encrypt_ready <= 'b1;
        end
        S_CHECK: begin

        end
        S_EXT  : begin
        end
        S_XOR48: begin
        end
        S_SCOMP: begin
        end
        S_P    : begin
        end
        S_XOR32: begin
        end
        S_ITER : begin
        end
        S_INVIP: begin
        end
        default: begin
        end
        endcase
    end
end


    
endmodule