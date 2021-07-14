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


module MEMWB(clk,RegWrite,WriteData,rt_Or_rd,
            RegWrite_inMEMWB,WriteData_inMEMWB,rt_Or_rd_inMEMWB);
    input clk;
    input RegWrite;
    input [31:0] WriteData;
    input [4:0] rt_Or_rd;

    output reg RegWrite_inMEMWB;
    output reg [31:0] WriteData_inMEMWB;
    output reg [4:0] rt_Or_rd_inMEMWB;

    always @(posedge clk) begin
        RegWrite_inMEMWB = RegWrite;
        WriteData_inMEMWB = WriteData;
        rt_Or_rd_inMEMWB = rt_Or_rd;
    end
endmodule
