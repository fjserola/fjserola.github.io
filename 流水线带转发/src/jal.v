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


//this module creates the control "rf31Write"
//rf31Write :rf[31]<=pc+8 

//Branch
`define bno     4'b0000
`define beq     4'b0001
`define bne     4'b0010
`define bgez    4'b0011
`define bgtz    4'b0100
`define bgezal  4'b0101
`define blez    4'b0110
`define bltz    4'b0111
`define bltzal  4'b1000
//Branch

//j IType
`define jno  2'b00
`define j    2'b01
`define jal  2'b10

//jr RType
`define jrno     2'b00
`define jr      2'b01
`define jalr    2'b10


module jal(jal,jr,branch,rf31Write);
    input [1:0] jal;
    input [1:0] jr;
    input [3:0] branch;

    output reg rf31Write = 0;

    always @(*) begin
        if(jal==`jal
        || jr ==`jalr
        || branch == `bgezal
        || branch == `bltzal
        )
        rf31Write = 1;
        else rf31Write = 0;
    end
endmodule
