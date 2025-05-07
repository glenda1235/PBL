`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2025 08:25:51 AM
// Design Name: 
// Module Name: fsm_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module fsm_controller (
    input logic clk,
    input logic rst,
    input logic input_ready,      // jogador apertou botão
    input logic cmp_result,       // resultado do comparador
    output logic gen_enable,      // ativa o PRNG
    output logic mem_write,       // escreve nova sequência
    output logic score_inc,       // incrementa o score
    output logic error_led,        // pisca quando jogador erra
  	output logic win_led  
 
);
    typedef enum logic [2:0] {
        IDLE,
        GEN,
        SHOW_SEQ,
        PLAYER_TURN,
        CHECK,
        WIN,
        ERROR
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        // valores padrão
        gen_enable = 0;
        mem_write = 0;
        score_inc = 0;
        error_led = 0;
        next_state = state;

        case (state)
            IDLE: next_state = GEN;

            GEN: begin
                gen_enable = 1;
                mem_write = 1;
                next_state = SHOW_SEQ;
            end

            SHOW_SEQ: next_state = PLAYER_TURN;

            PLAYER_TURN: if (input_ready) next_state = CHECK;

            CHECK: begin
                if (cmp_result)
                    next_state = WIN;
                else
                    next_state = ERROR;
            end

            WIN: begin
                score_inc = 1;
                next_state = GEN;
            end

            ERROR: begin
                error_led = 1;
                next_state = IDLE;
            end
        endcase
    end
endmodule

