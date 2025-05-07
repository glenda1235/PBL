`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2025 08:29:37 AM
// Design Name: 
// Module Name: score_counter
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


module score_counter (
    input clk,
    input rst,
    input correct,
  output reg [7:0] score
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            score <= 0;
        else if (correct)
            score <= score + 5;
    end
endmodule

