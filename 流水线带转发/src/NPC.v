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

module NPC(Branch,zero,gz,lz,Jump,jr,PCAdd4,BranchAddr,JumpAddr,JrAddr,NPC,IFFlush);
    input [3:0] Branch;
    input zero;
    input gz;
    input lz;
    input [1:0] Jump;
    input [1:0] jr;
    input [31:0] BranchAddr;
    input [31:0] PCAdd4;
    input [31:0] JumpAddr;
    input [31:0] JrAddr;

    output reg [31:0] NPC;
    output reg IFFlush;

    always @(*) begin
        NPC = PCAdd4;
        IFFlush = 0;
        if( (Branch==`beq && zero==1)//beq
          ||(Branch==`bne && zero==0)//bne
          ||(Branch==`bgez&&(zero==1 || gz==1))//bgez
          ||(Branch==`bgtz&&(zero==0 &&gz==1))//bgtz
          ||(Branch==`bgezal&&(zero==1 || gz==1))//bgezal
          ||(Branch==`blez&&(zero==1 || lz==1))//blez
          ||(Branch==`bltz&&(zero==0 && lz==1))//bltz
          ||(Branch==`bltzal&&(zero==0 && lz==1))//bltzal
          )begin
            NPC = BranchAddr;
            IFFlush = 1;             
          end

        if(Jump==`j || Jump==`jal)
        begin
            NPC = JumpAddr;
            IFFlush = 1; 
        end
        
        if(jr==`jr || jr==`jalr)
        begin
            NPC = JrAddr;
            IFFlush = 1; 
        end
    end

endmodule
