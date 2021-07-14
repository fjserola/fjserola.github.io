`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/20 19:23:31
// Design Name: 
// Module Name: IDEX
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


module IDEX(clk,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,MemRead,
            PCAdd4,rfReadData1,rfReadData2,extend32,rt,rd,sa,Inst26,
            PCAdd4_inIDEX,rfReadData1_inIDEX,rfReadData2_inIDEX,extend32_inIDEX,rt_inIDEX,rd_inIDEX,sa_inIDEX,Inst26_inIDEX,
            Branch_inIDEX,Jump_inIDEX,RegDst_inIDEX,ALUSrc_inIDEX,ALUOp_inIDEX,MemtoReg_inIDEX,RegWrite_inIDEX,MemWrite_inIDEX,MemRead_inIDEX
           );
    input clk;
    
    input [1:0] Branch;
    input [1:0] Jump;
    input RegDst;      
    input ALUSrc;      
    input [3:0] ALUOp; 
    input MemtoReg;    
    input RegWrite;    
    // input ExtOp;       
    input [1:0] MemWrite; 
    input [2:0] MemRead;
    
    input [31:0] PCAdd4;
    input [31:0] rfReadData1;
    input [31:0] rfReadData2;
    input [31:0] extend32;
    input [4:0] rt;
    input [4:0] rd;
    input [4:0] sa;
    input [25:0] Inst26;

    output reg [31:0] PCAdd4_inIDEX;
    output reg [31:0] rfReadData1_inIDEX;
    output reg [31:0] rfReadData2_inIDEX;
    output reg [31:0] extend32_inIDEX;
    output reg [4:0]  rt_inIDEX;
    output reg [4:0]  rd_inIDEX;
    output reg [4:0]  sa_inIDEX;
    output reg [25:0] Inst26_inIDEX;

    output reg [1:0] Branch_inIDEX;
    output reg [1:0] Jump_inIDEX;
    output reg RegDst_inIDEX;
    output reg ALUSrc_inIDEX;
    output reg [3:0] ALUOp_inIDEX;
    output reg MemtoReg_inIDEX;
    output reg RegWrite_inIDEX;
    // output reg ExtOp_inIDEX;
    output reg [1:0] MemWrite_inIDEX; 
    output reg [2:0] MemRead_inIDEX;

    always @(posedge clk) begin
        PCAdd4_inIDEX = PCAdd4; 
        rfReadData1_inIDEX = rfReadData1; 
        rfReadData2_inIDEX = rfReadData2; 
        extend32_inIDEX = extend32; 
        rt_inIDEX = rt; 
        rd_inIDEX = rd; 
        sa_inIDEX = sa; 
        Inst26_inIDEX = Inst26; 
        Branch_inIDEX = Branch; 
        Jump_inIDEX = Jump; 
        RegDst_inIDEX = RegDst; 
        ALUSrc_inIDEX = ALUSrc; 
        ALUOp_inIDEX = ALUOp; 
        MemtoReg_inIDEX = MemtoReg; 
        RegWrite_inIDEX = RegWrite; 
        // ExtOp_inIDEX = ExtOp; 
        MemWrite_inIDEX = MemWrite; 
        MemRead_inIDEX = MemRead; 
    end
endmodule
