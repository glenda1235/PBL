module Controller(
    input logic clk,
    input logic rst,
    input logic start,
    input logic [1:0] mode,
    input logic [1:0] difficult,
    input logic [1:0] speed,
    input logic [1:0] player_input,
    input logic [1:0] sequence_item,
    output logic [3:0] match_index,
    output logic [3:0] sequence_index,
    output logic mem_wr,
    output logic mem_rd,
    output logic enable_led,
    output logic rst_sequence,
    output logic rst_match,
    output logic update_score
);
    //apenas estados sequenciais
    typedef enum logic [2:0] {
        IDLE, GEN, DISP, INPUT, CHECK, DONE
    } state_t;

    state_t state, next;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next;
    end

    always_comb begin
        next = state;
        mem_wr = 0;
        mem_rd = 0;
        enable_led = 0;
        rst_sequence = 0;
        rst_match = 0;
        update_score = 0;

        case (state)
            IDLE: if (start) next = GEN;
            GEN: begin
                mem_wr = 1;
                next = DISP;
            end
            DISP: begin
                enable_led = 1;
                next = INPUT;
            end
            INPUT: begin
                mem_rd = 1;
                next = CHECK;
            end
            CHECK: begin
                update_score = (player_input == sequence_item);
                next = DONE;
            end
            DONE: next = IDLE;
        endcase
    end
endmodule