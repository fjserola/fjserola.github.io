`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/12 20:52:52
// Design Name: 
// Module Name: dm_4k
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


module dm_4k(clk,rst,DataAddr,WriteData,ReadData,MemWrite);
    input clk;//clock
    input rst;
    input MemWrite;//memory write enable
    input [31:0] DataAddr;//address bus
    input [31:0] WriteData;//32-bit input data
    output [31:0] ReadData;//32-bit memory output

    reg [31:0] dm[1023:0];

    integer i;

    always @(posedge clk) begin //posedge write
        if(rst) for(i=0;i<1024;i=i+1)dm[i] = 0;
        if(MemWrite)
            dm[DataAddr[11:2]] <= WriteData;
    end

    assign ReadData = dm[DataAddr[11:2]];

endmodule
