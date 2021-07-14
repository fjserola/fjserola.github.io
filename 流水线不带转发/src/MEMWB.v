`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/20 19:39:40
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(clk,MemtoReg,RegWrite,dmReadData,rfReadData1_Add_MUX,rt_Or_rd,
            MemtoReg_inMEMWB,RegWrite_inMEMWB,dmReadData_inMEMWB,rfReadData1_Add_MUX_inMEMWB,rt_Or_rd_inMEMWB);
    input clk;
    input MemtoReg;
    input RegWrite;
    input [31:0] dmReadData;
    input [31:0] rfReadData1_Add_MUX;
    input [4:0] rt_Or_rd;

    output reg MemtoReg_inMEMWB;
    output reg RegWrite_inMEMWB;
    output reg [31:0] dmReadData_inMEMWB;
    output reg [31:0] rfReadData1_Add_MUX_inMEMWB;
    output reg [4:0] rt_Or_rd_inMEMWB;

    always @(posedge clk) begin
        MemtoReg_inMEMWB = MemtoReg;        
        RegWrite_inMEMWB = RegWrite;
        dmReadData_inMEMWB = dmReadData;
        rfReadData1_Add_MUX_inMEMWB = rfReadData1_Add_MUX;  
        rt_Or_rd_inMEMWB = rt_Or_rd;     
    end
endmodule
