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


module mips(clk,rst,PC);
    input clk;
    input rst;
    output [31:0] PC;

    wire Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,ExtOp;
    wire [2:0]ALUOp;
    wire [5:0] op;

    datapath Datapath(clk,rst,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,ExtOp,op,PC);
    control Control(op,RegDst,Jump,Branch,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,ExtOp);
endmodule
