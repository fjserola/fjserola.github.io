`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/17 23:10:45
// Design Name: 
// Module Name: BranchCtr
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


module BranchCtr(rfRead1,rfRead2,zero,gz,lz);
    input [31:0] rfRead1,rfRead2;
    output reg zero,gz,lz;

    wire [31:0] C;
    assign C = rfRead1-rfRead2;
    always @(*) begin
        zero = (C==0) ? 1:0;
        gz   = (rfRead1>0)? 1:0;
        lz   = (rfRead1<0)? 1:0;
    end
endmodule
