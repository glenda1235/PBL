`include "genius_pkg.sv"

module top_genius_game (
    input logic clk,
    input logic rst,
    input logic start,
    input logic [1:0] mode_button,
    input logic [1:0] difficult_button,
    input logic [1:0] speed_button,
    input logic [1:0] player_input,
    output logic [3:0] leds,
    output logic [6:0] display
);

    logic [1:0] mode, difficult, speed;
    logic [1:0] player_input_color;
    logic [1:0] random_out, sequence_item;
    logic [3:0] sequence_index, match_index;
    logic mem_wr, mem_rd;
    logic rst_sequence, rst_match;
    logic enable_led, update_score;

    GRN grn (
        .clk(clk),
        .rst(rst),
        .random_out(random_out)
    );

    Mux mux (
        .sel_from_grn(start),
        .input_grn(random_out),
        .input_player(player_input),
        .mux_out(sequence_item)
    );

    Memory memory (
        .clk(clk),
        .mem_wr(mem_wr),
        .mem_rd(mem_rd),
        .index_wr(sequence_index),
        .index_rd(match_index),
        .data_in(sequence_item),
        .data_out(sequence_item)
    );

    Controller controller (
        .clk(clk),
        .rst(rst),
        .start(start),
        .mode(mode_button),
        .difficult(difficult_button),
        .speed(speed_button),
        .player_input(player_input),
        .sequence_item(sequence_item),
        .match_index(match_index),
        .sequence_index(sequence_index),
        .mem_wr(mem_wr),
        .mem_rd(mem_rd),
        .enable_led(enable_led),
        .rst_sequence(rst_sequence),
        .rst_match(rst_match),
        .update_score(update_score)
    );

    Led_Driver led_driver (
        .clk(clk),
        .enable(enable_led),
        .sequence(sequence_item),
        .leds(leds)
    );

    Score_Driver score_driver (
        .clk(clk),
        .update(update_score),
        .score(match_index),
        .display(display)
    );

endmodule