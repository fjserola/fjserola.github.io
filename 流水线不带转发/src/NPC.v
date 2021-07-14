`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 19:20:37
// Design Name: 
// Module Name: NPC
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
`define bno  2'b00
`define beq  2'b01
`define bne  2'b10
//Branch

//j class
`define jno  2'b00
`define j    2'b01
`define jal  2'b10
//j class

module NPC(Branch,zero,Jump,jr,BranchAddr,PCAdd4,JumpAddr,JalAddr,JrAddr,NPC);
    input [1:0] Branch;
    input zero;
    input [1:0] Jump;
    input jr;
    input [31:0] BranchAddr;
    input [31:0] PCAdd4;
    input [31:0] JumpAddr;
    input [31:0] JalAddr;
    input [31:0] JrAddr;

    output reg [31:0] NPC;

    always @(*) begin
        NPC = PCAdd4;
        if(Branch==`beq && zero==0)
            NPC = BranchAddr;
        else if(Branch==`bne && zero==1)
            NPC = BranchAddr;
        
        if(Jump==`j)
            NPC = JumpAddr;
        else if(Jump==`jal)
            NPC = JalAddr;
        
        if(jr==1)
            NPC = JrAddr;
    end

endmodule
