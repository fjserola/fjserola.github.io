`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/15 09:59:08
// Design Name: 
// Module Name: mips
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


module mips(clk,rst);
    input clk;
    input rst;

    wire RegDst,ALUSrc,MemtoReg,RegWrite,ExtOp;
    wire [1:0] Branch,Jump,MemWrite;
    wire [2:0] MemRead;
    wire [3:0] ALUOp;
    wire [5:0] op;

    datapath Datapath(clk,rst,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,ExtOp,MemRead,op);
    control Control(op,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,ExtOp,MemRead);
endmodule
