`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/16 11:32:44
// Design Name: 
// Module Name: jal
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

`define jal  2'b10
module jal(jal,DataAddr_inEXMEM,pcaddr8_inEXMEM,rd_Or_rt_inEXMEM,DataAddr_inJAL,rd_Or_rt_inJAL);
    input [1:0]     jal;
    input [31:0]    DataAddr_inEXMEM;
    input [31:0]    pcaddr8_inEXMEM;
    input [4:0]     rd_Or_rt_inEXMEM;

    output reg [31:0]   DataAddr_inJAL;
    output reg [31:0]   rd_Or_rt_inJAL;

    always @(*) begin
        if(jal==`jal)
        begin
            DataAddr_inJAL = pcaddr8_inEXMEM;
            rd_Or_rt_inJAL = 5'b11111;
        end
        else begin
            DataAddr_inJAL = DataAddr_inEXMEM;
            rd_Or_rt_inJAL = rd_Or_rt_inEXMEM;
        end
    end
endmodule
