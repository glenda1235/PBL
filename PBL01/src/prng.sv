`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2025 08:28:33 AM
// Design Name: 
// Module Name: prng
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

module prng (
    input clk,
    input rst,
    output reg [1:0] rand_out  // <- novo nome
);

    reg [2:0] lfsr;

    always @(posedge clk or posedge rst) begin
        if (rst)
            lfsr <= 3'b001; // valor inicial não-nulo
        else begin
            // LFSR bit a bit
            lfsr[2] <= lfsr[1];
            lfsr[1] <= lfsr[0];
            lfsr[0] <= lfsr[2] ^ lfsr[0]; // feedback
        end
    end

    always @(*) begin
        rand_out = lfsr[1:0]; // saída de 2 bits pseudo-aleatórios
    end

endmodule
module prng (
    input clk,
    input rst,
    output reg [1:0] rand_out  // <- novo nome
);

    reg [2:0] lfsr;

    always @(posedge clk or posedge rst) begin
        if (rst)
            lfsr <= 3'b001; // valor inicial não-nulo
        else begin
            // LFSR bit a bit
            lfsr[2] <= lfsr[1];
            lfsr[1] <= lfsr[0];
            lfsr[0] <= lfsr[2] ^ lfsr[0]; // feedback
        end
    end

    always @(*) begin
        rand_out = lfsr[1:0]; // saída de 2 bits pseudo-aleatórios
    end

endmodule
