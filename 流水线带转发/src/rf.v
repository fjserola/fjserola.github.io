`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/12 18:57:14
// Design Name: 
// Module Name: rf
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


module rf(clk,rst,WriteAble,ReadAddr_1,ReadAddr_2,WriteAddr,WriteData,ReadData_1,ReadData_2,rf31Write,pcadd4);
    input clk;//clock
    input rst;//reset
    input WriteAble;//Reg Write when 1 can write, 0 can't write
    input [4:0] ReadAddr_1,ReadAddr_2,WriteAddr;// rs rt rd
    input [31:0] WriteData;//the data write in rd
    input rf31Write;
    input [31:0] pcadd4;

    output reg [31:0] ReadData_1,ReadData_2;//rs rt read out data

    reg [31:0] rf [31:0]; //rf 32-bit * 32 array
    integer  i;

    // wire [31:0] pcadd8 = pcadd4+4;

    always @(negedge clk) begin
        if(rst)begin
            for(i=0;i<32;i=i+1)
                rf[i] <= 0;
        end

        if(WriteAble&&WriteAddr!=0) begin
            rf[WriteAddr] <= WriteData;
        end

        if(rf31Write)
            rf[31] = pcadd4;
    end

    always @(*) begin
        ReadData_1 = (ReadAddr_1 != 0)?rf[ReadAddr_1]:32'b0;//Read Data 1
        ReadData_2 = (ReadAddr_2 != 0)?rf[ReadAddr_2]:32'b0;//Read Data 2
    end


endmodule
