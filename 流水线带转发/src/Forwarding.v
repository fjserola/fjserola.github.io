`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/18 00:02:27
// Design Name: 
// Module Name: Forwarding
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

module Forwarding(rs_inIDEX,rt_inIDEX,RegWrite_inEXMEM,RegWrite_inMEMWB,rd_Or_rt_inEXMEM,rt_Or_rd_inMEMWB,ForwardA,ForwardB);
    input [4:0] rs_inIDEX;
    input [4:0] rt_inIDEX;
    input RegWrite_inEXMEM;
    input RegWrite_inMEMWB;
    input [4:0] rd_Or_rt_inEXMEM;
    input [4:0] rt_Or_rd_inMEMWB;

    output reg [1:0] ForwardA;
    output reg [1:0] ForwardB;

    always @(*) begin
        ForwardA =2'b0;
		ForwardB =2'b0;

		if( RegWrite_inEXMEM == 1
        &&  rd_Or_rt_inEXMEM != 0
        &&  rd_Or_rt_inEXMEM == rs_inIDEX)//C1(a) = 1
        begin
            ForwardA = 2'b01;
        end

        if( RegWrite_inEXMEM == 1
        &&  rd_Or_rt_inEXMEM != 0
        &&  rd_Or_rt_inEXMEM == rt_inIDEX)//C1(b) = 1
        begin
            ForwardB = 2'b01;
        end

        if( RegWrite_inMEMWB == 1
        &&  rt_Or_rd_inMEMWB != 0
        &&  rd_Or_rt_inEXMEM != rs_inIDEX
        &&  rt_Or_rd_inMEMWB == rs_inIDEX)//C2(a) = 1
        begin
            ForwardA = 2'b10;
        end

        if( RegWrite_inMEMWB == 1
        &&  rt_Or_rd_inMEMWB != 0
        &&  rd_Or_rt_inEXMEM != rt_inIDEX
        &&  rt_Or_rd_inMEMWB == rt_inIDEX)//C2(b) = 1
        begin
            ForwardB = 2'b10;
        end
    end
endmodule
