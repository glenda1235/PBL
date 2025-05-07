`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2025 08:30:05 AM
// Design Name: 
// Module Name: memory_sequence
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


module memory_sequence (
    input clk,
    input rst,
    input [1:0] value_in,
    input write_en,
    input [1:0] addr,
    output reg [1:0] value_out
);
    reg [1:0] mem [0:3];

    integer i;

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 4; i = i + 1)
                mem[i] <= 2'b00;
            value_out <= 2'b00;
        end else begin
            if (write_en)
                mem[addr] <= value_in;
            value_out <= mem[addr]; // leitura síncrona
        end
    end
endmodule

