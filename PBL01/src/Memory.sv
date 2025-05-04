module Memory(
    input logic clk,
    input logic mem_wr,
    input logic mem_rd,
    input logic [3:0] index_wr,
    input logic [3:0] index_rd,
    input logic [1:0] data_in,
    output logic [1:0] data_out
);
    logic [1:0] mem [15:0];

    always_ff @(posedge clk) begin
        if (mem_wr)
            mem[index_wr] <= data_in;
    end

    assign data_out = (mem_rd) ? mem[index_rd] : 2'b00;
endmodule