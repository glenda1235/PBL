`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2025 08:23:47 AM
// Design Name: 
// Module Name: tb_genius
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

module tb_genius;

    reg clk, rst;
    wire [1:0] rand_out;
    reg [1:0] player_input;
    wire [1:0] mem_out;
    reg [1:0] addr;
    reg input_ready;
    wire write_en, score_inc, gen_enable, error_led;
    wire correct;
    wire [7:0] score;
    wire [6:0] seg;

    logic [1:0] seq_gerada[0:3];
    logic [1:0] seq_jogador[0:3];

    // Instâncias dos módulos
    prng prng_inst(
        .clk(clk),
        .rst(rst),
        .rand_out(rand_out)
    );

    memory_sequence mem_inst(
        .clk(clk),
        .rst(rst),
        .value_in(rand_out),
        .write_en(write_en),
        .addr(addr),
        .value_out(mem_out)
    );

    comparator cmp_inst(
        .seq_mem(mem_out),
        .player_input(player_input),
        .correct(correct)
    );

    score_counter score_inst(
        .clk(clk),
        .rst(rst),
        .correct(score_inc),
        .score(score)
    );

    seven_segment_display seg_inst(
        .score(score),
        .seg(seg)
    );

    // FSM Controller
    fsm_controller fsm_inst(
        .clk(clk),
        .rst(rst),
        .input_ready(input_ready),
        .cmp_result(correct),
        .gen_enable(gen_enable),
        .mem_write(write_en),
        .score_inc(score_inc),
        .error_led(error_led)
    );

    // Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Simulação
    initial begin
        $display("Iniciando simulação do jogo Genius com FSM");

        rst = 1;
        input_ready = 0;
        addr = 0;
        player_input = 0;

        #10;
        rst = 0;

        // Etapa 1: Gerar e armazenar sequência pseudoaleatória
        repeat (4) begin
            @(posedge clk);
            input_ready = 1;
            @(posedge clk);
            input_ready = 0;
            seq_gerada[addr] = rand_out;
            addr = addr + 1;
        end

        addr = 0;

        // Etapa 2: Jogador tenta repetir a sequência
        repeat (4) begin
            @(posedge clk);
            player_input = seq_gerada[addr]; // jogador tenta repetir
            seq_jogador[addr] = player_input;
            input_ready = 1;
            @(posedge clk);
            input_ready = 0;
            addr = addr + 1;
        end

        #20;

        $write("Sequência gerada: ");
        foreach (seq_gerada[i]) $write("%0d ", seq_gerada[i]);
        $write("\nSequência do jogador: ");
        foreach (seq_jogador[i]) $write("%0d ", seq_jogador[i]);
        if (error_led)
            $display("\nResultado: Vitória");
        else
          $display("\nResultado: Derrota");

        $display("Pontuação final: %d", score);
        $finish;
    end

endmodule
