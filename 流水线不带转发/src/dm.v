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

`define lw   3'b000
`define lh   3'b001
`define lhu  3'b010
`define lb   3'b011
`define lbu  3'b100

`define sno  2'b00
`define sh   2'b01
`define sb   2'b10
`define sw   2'b11

//BigEndianCPU
module dm_4k(clk,rst,DataAddr,WriteData,ReadData,MemWrite,MemRead);
    input clk;//clock
    input rst;
    input [1:0] MemWrite;//memory write enable
    input [31:0] DataAddr;//address bus
    input [31:0] WriteData;//32-bit input data
    input [2:0] MemRead;
    output reg [31:0] ReadData;//32-bit memory output

    reg [31:0] dm[1023:0];

    integer i;
    reg [31:0] data;
    wire [7:0] d0,d1,d2,d3;

    always @(posedge clk) begin //posedge write
        if(rst) for(i=0;i<1024;i=i+1)dm[i] = 0;
        //BigEndianCPU
        if(MemWrite==`sw)
            dm[DataAddr[11:2]] <= WriteData;
        else if(MemWrite==`sh)
            dm[DataAddr[11:2]] <= {WriteData[15:0],16'b0};
        else if(MemWrite==`sb)
            dm[DataAddr[11:2]] <= {WriteData[7:0],24'b0};
        //BigEndianCPU
        /*LittleEndianCPU
        if(sw)
            dm[DataAddr[11:2]] <= WriteData;
        else if(sh)
            dm[DataAddr[11:2]] <= {WriteData[31:16],16'b0};
        else if(sb)
            dm[DataAddr[11:2]] <= {WriteData[31:24],24'b0};
        LittleEndianCPU*/
        data = dm[DataAddr[11:2]];
        //BigEndianCPU
        if(MemRead==`lw)
            ReadData = data;
        else if(MemRead==`lb)
            ReadData = {{24{data[31]}},data[31:24]};
        else if(MemRead==`lbu)
            ReadData = {24'b0,data[31:24]};
        else if(MemRead==`lh)
            ReadData = {{16{data[31]}},data[31:16]};
        else if(MemRead==`lhu)
            ReadData = {16'b0,data[31:16]};
        //BigEndianCPU
    end

    /*LittleEndianCPU
        case (MemRead) 
    lw  : assign ReadData = data;
    lb  : assign ReadData = {24{data[7]},data[7:0]}
    lbu : assign ReadData = {24'b0,data[7:0]}
    lh  : assign ReadData = {16{data[15]},data[15:0]}
    lhu : assign ReadData = {16'b0,data[15:0]}
    LittleEndianCPU*/

endmodule
