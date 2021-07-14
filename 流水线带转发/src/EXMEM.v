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


module EXMEM(clk,MemtoReg_inIDEX,RegWrite_inIDEX,MemWrite_inIDEX,MemRead_inIDEX,
            DataAddr,rfReadData2_inIDEX,rd_Or_rt,
            MemtoReg_inEXMEM,RegWrite_inEXMEM,MemWrite_inEXMEM,MemRead_inEXMEM,
            DataAddr_inEXMEM,rfReadData2_inEXMEM,rd_Or_rt_inEXMEM
            );
    input clk;
    input MemtoReg_inIDEX;
    input RegWrite_inIDEX;
    input [1:0] MemWrite_inIDEX;
    input [2:0] MemRead_inIDEX;
    input [31:0] DataAddr;
    input [31:0] rfReadData2_inIDEX;
    input [4:0] rd_Or_rt;

    output reg MemtoReg_inEXMEM;
    output reg RegWrite_inEXMEM;
    output reg [1:0] MemWrite_inEXMEM;
    output reg [2:0] MemRead_inEXMEM;
    output reg [31:0] DataAddr_inEXMEM;
    output reg [31:0] rfReadData2_inEXMEM;
    output reg [4:0] rd_Or_rt_inEXMEM;
 
    always @(posedge clk) begin
        MemtoReg_inEXMEM = MemtoReg_inIDEX;
        RegWrite_inEXMEM = RegWrite_inIDEX;
        MemWrite_inEXMEM = MemWrite_inIDEX;
        MemRead_inEXMEM = MemRead_inIDEX;
        DataAddr_inEXMEM = DataAddr;
        rfReadData2_inEXMEM = rfReadData2_inIDEX;
        rd_Or_rt_inEXMEM = rd_Or_rt;
    end
endmodule
