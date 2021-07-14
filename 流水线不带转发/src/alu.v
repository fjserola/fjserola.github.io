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
`define ALU_add     4'b0001
`define ALU_sub     4'b0010
`define ALU_and     4'b0011
`define ALU_or      4'b0100
`define ALU_xor     4'b0101
`define ALU_lui     4'b0110
`define ALU_slt     4'b0111
`define ALU_sltu    4'b1000
`define ALU_nor     4'b1001
`define ALU_sll     4'b1010
`define ALU_srl     4'b1011
`define ALU_sra     4'b1100



module ALU(A,B,ALUctr,C,zero,sll);
    input [31:0] A,B;
    input [3:0] ALUctr;
    input [4:0] sll;//inst [10:6]
    output zero;
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
            `ALU_slt    : C=(fsA<fsB) ? 32'd1 : 32'd0;
            `ALU_sltu   : C=(A<B) ? 32'd1 : 32'd0;
            `ALU_nor    : C=~(A|B);
            `ALU_sll    : C=B<<sll;
            `ALU_srl    : C=B>>sll;
            `ALU_sra    : C=(B[31]==0) ? (B>>sll) : (~((~B)>>sll));
        endcase
    end
    assign zero = (C==32'b0);
endmodule
