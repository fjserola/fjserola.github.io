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

    wire hazard;
    wire RegDst,ALUSrc,MemtoReg,RegWrite,ExtOp;
    wire [3:0] Branch;
    wire [1:0] Jump;
    wire [1:0] MemWrite;
    wire [2:0] MemRead;
    wire [4:0] ALUOp;
    wire [5:0] op;
    wire [4:0] rt;

    datapath Datapath(clk,rst,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,ExtOp,MemRead,op,rt,hazard);
    control Control(hazard,op,rt,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,ExtOp,MemRead);
endmodule
