`timescale 1ns / 1ps

module top_genius_game_tb;

  logic clk = 0;
  logic rst = 0;
  logic start = 0;
  logic [1:0] player_input;
  logic [3:0] led_seq;
  logic win;
  logic defeat;

  //clock: 10ns period
  always #5 clk = ~clk;

  // DUT
  top_genius_game dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .player_input(player_input),
    .led_seq(led_seq),
    .win(win),
    .defeat(defeat)
  );

  //procedimento de teste
  initial begin
    $display("=== Iniciando Simulação ===");

    // Reset inicial
    rst = 1;
    #20;
    rst = 0;

    //start jogo
    #10;
    start = 1;
    #10;
    start = 0;

    //aguarda a sequência ser mostrada
    repeat (100) @(posedge clk);

    //simula entradas do jogador com delay entre cada uma
    //simulação do jogador acertando 3 jogadas)
    for (int i = 0; i < 3; i++) begin
      player_input = dut.mem.seq[i];
      @(posedge clk);
      #40;
    end

    //esspera o estado final
    repeat (100) @(posedge clk);

    //verifica resultado
    if (win)
      $display("Jogador venceu!");
    else if (defeat)
      $display("Jogador perdeu!");
    else
      $display("Nenhum resultado.");

    $finish;
  end

endmodule
