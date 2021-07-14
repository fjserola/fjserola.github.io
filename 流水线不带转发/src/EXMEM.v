`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/20 19:39:23
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(clk,Branch_inIDEX,Jump_inIDEX,,MemtoReg_inIDEX,RegWrite_inIDEX,MemWrite_inIDEX,MemRead_inIDEX,zero,jr,
            PCAdd4_AddExten32,DataAddr,rfReadData2_inIDEX,JumpArr,rd_Or_rt,JalAddr,pcaddr8,
            Branch_inEXMEM,Jump_inEXMEM,MemtoReg_inEXMEM,RegWrite_inEXMEM,MemWrite_inEXMEM,MemRead_inEXMEM,zero_inEXMEM,jr_inEXMEM,
            PCAdd4_AddExten32_inEXMEM,DataAddr_inEXMEM,rfReadData2_inEXMEM,JumpArr_inEXMEM,rd_Or_rt_inEXMEM,JalAddr_inEXMEM,pcaddr8_inEXMEM
            );
    input clk;
    input [1:0] Branch_inIDEX;
    input [1:0] Jump_inIDEX;
    input MemtoReg_inIDEX;
    input RegWrite_inIDEX;
    input [1:0] MemWrite_inIDEX;
    input [2:0] MemRead_inIDEX;
	input zero;
    input jr;
    input [31:0] PCAdd4_AddExten32;
    input [31:0] DataAddr;
    input [31:0] rfReadData2_inIDEX;
    input [31:0] JumpArr;
    input [4:0] rd_Or_rt;
    input [31:0] JalAddr;
    input [31:0] pcaddr8;

    output reg [1:0] Branch_inEXMEM;
    output reg [1:0] Jump_inEXMEM;
    output reg MemtoReg_inEXMEM;
    output reg RegWrite_inEXMEM;
    output reg [1:0] MemWrite_inEXMEM;
    output reg [2:0] MemRead_inEXMEM;
	output reg zero_inEXMEM;
    output reg jr_inEXMEM;
    output reg [31:0] PCAdd4_AddExten32_inEXMEM;
    output reg [31:0] DataAddr_inEXMEM;
    output reg [31:0] rfReadData2_inEXMEM;
    output reg [31:0] JumpArr_inEXMEM;
    output reg [4:0] rd_Or_rt_inEXMEM;
    output reg [31:0] JalAddr_inEXMEM;
    output reg [31:0] pcaddr8_inEXMEM;
 
    always @(posedge clk) begin
        Branch_inEXMEM = Branch_inIDEX;
        Jump_inEXMEM = Jump_inIDEX;
        MemtoReg_inEXMEM = MemtoReg_inIDEX;
        RegWrite_inEXMEM = RegWrite_inIDEX;
        MemWrite_inEXMEM = MemWrite_inIDEX;
        MemRead_inEXMEM = MemRead_inIDEX;
        zero_inEXMEM = zero;
        jr_inEXMEM = jr;
        PCAdd4_AddExten32_inEXMEM = PCAdd4_AddExten32;
        DataAddr_inEXMEM = DataAddr;
        rfReadData2_inEXMEM = rfReadData2_inIDEX;
        JumpArr_inEXMEM = JumpArr;
        rd_Or_rt_inEXMEM = rd_Or_rt;
        JalAddr_inEXMEM = JalAddr;
        pcaddr8_inEXMEM = pcaddr8;
    end
endmodule
