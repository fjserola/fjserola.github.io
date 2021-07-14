`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/12 14:05:03
// Design Name: 
// Module Name: pc
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
`define reset 32'h0000_3000

module pc(rst,clk,NPC,PC);
    input rst;//reset 0
    input clk;//clock 
    input [31:0] NPC;//next PC
    output reg [31:0] PC;
        always @(posedge clk,posedge rst) begin
            if(rst)
                PC <= `reset;
            else
                PC <= NPC;
        end
endmodule
