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


module IDEX(clk,RegDst,ALUSrc,ALUctr,MemtoReg,RegWrite,MemWrite,MemRead,
            rfReadData1,rfReadData2,extend32,rs,rt,rd,sa,
            rfReadData1_inIDEX,rfReadData2_inIDEX,extend32_inIDEX,rs_inIDEX,rt_inIDEX,rd_inIDEX,sa_inIDEX,
            RegDst_inIDEX,ALUSrc_inIDEX,ALUctr_inIDEX,MemtoReg_inIDEX,RegWrite_inIDEX,MemWrite_inIDEX,MemRead_inIDEX
           );
    input clk;
    
    input RegDst;      
    input ALUSrc;      
    input [4:0] ALUctr; 
    input MemtoReg;    
    input RegWrite;      
    input [1:0] MemWrite; 
    input [2:0] MemRead;
    
    input [31:0] rfReadData1;
    input [31:0] rfReadData2;
    input [31:0] extend32;
    input [4:0] rs;
    input [4:0] rt;
    input [4:0] rd;
    input [4:0] sa;

    output reg [31:0] rfReadData1_inIDEX;
    output reg [31:0] rfReadData2_inIDEX;
    output reg [31:0] extend32_inIDEX;
    output reg [4:0]  rs_inIDEX;
    output reg [4:0]  rt_inIDEX;
    output reg [4:0]  rd_inIDEX;
    output reg [4:0]  sa_inIDEX;

    output reg RegDst_inIDEX;
    output reg ALUSrc_inIDEX;
    output reg [4:0] ALUctr_inIDEX;
    output reg MemtoReg_inIDEX;
    output reg RegWrite_inIDEX;
    output reg [1:0] MemWrite_inIDEX; 
    output reg [2:0] MemRead_inIDEX;

    always @(posedge clk) begin
        rfReadData1_inIDEX = rfReadData1; 
        rfReadData2_inIDEX = rfReadData2; 
        extend32_inIDEX = extend32; 
        rs_inIDEX = rs;
        rt_inIDEX = rt; 
        rd_inIDEX = rd; 
        sa_inIDEX = sa; 
        RegDst_inIDEX = RegDst; 
        ALUSrc_inIDEX = ALUSrc; 
        ALUctr_inIDEX = ALUctr; 
        MemtoReg_inIDEX = MemtoReg; 
        RegWrite_inIDEX = RegWrite; 
        MemWrite_inIDEX = MemWrite; 
        MemRead_inIDEX = MemRead; 
    end
endmodule
