`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/12 20:53:14
// Design Name: 
// Module Name: alu
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
//ALUctr
`define ALU_add     5'b00001
`define ALU_sub     5'b00010
`define ALU_and     5'b00011
`define ALU_or      5'b00100
`define ALU_xor     5'b00101
`define ALU_lui     5'b00110
`define ALU_slt     5'b00111
`define ALU_sltu    5'b01000
`define ALU_nor     5'b01001
`define ALU_sll     5'b01010
`define ALU_srl     5'b01011
`define ALU_sra     5'b01100
`define ALU_sllv    5'b01101
`define ALU_srlv    5'b01110
`define ALU_srav    5'b01111 



module ALU(A,B,ALUctr,C,zero,rs,sa);
    input [31:0] A,B;
    input [4:0] ALUctr;
    input [4:0] rs;
    input [4:0] sa;//inst [10:6]
    output zero;
    // output gz;
    // output lz;
    output reg [31:0] C;

    wire [31:0] OR = {1'b1,31'b0};
    wire [31:0] fsA = A^OR;
    wire [31:0] fsB = B^OR;
    
    always @(*) begin
        case(ALUctr)
            `ALU_add    : C=A+B;
            `ALU_sub    : C=A-B;
            `ALU_and    : C=A&B;
            `ALU_or     : C=A|B;
            `ALU_xor    : C=A^B;
            `ALU_lui    : C=B<<16;
            `ALU_slt    : C=(fsA<fsB) ? 32'b1 : 32'b0;
            `ALU_sltu   : C=(A<B) ? 32'b1 : 32'b0;
            `ALU_nor    : C=~(A|B);
            `ALU_sll    : C=B<<sa;
            `ALU_srl    : C=B>>sa;
            `ALU_sra    : C=(B[31]==0) ? (B>>sa) : (~((~B)>>sa));
            `ALU_sllv   : C=B<<rs;
            `ALU_srlv   : C=B>>rs;
            `ALU_srav   : C=(B[31]==0) ? B>>rs : (~((~B)>>rs));
        endcase
    end
    assign zero = (C==32'b0);
    // assign gz = A>0? 1 : 0;
    // assign lz = A<0? 1 : 0;
endmodule
