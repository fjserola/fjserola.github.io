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
`define ALU_add     3'b001
`define ALU_sub     3'b010
`define ALU_and     3'b011
`define ALU_or      3'b100
`define ALU_xor     3'b101
`define ALU_lui     3'b110
`define ALU_slt     3'b111

module ALU(A,B,ALUctr,C,zero);
    input [31:0] A,B;
    input [2:0] ALUctr;
    output zero;
    output reg [31:0] C;

    always @(*) begin
        case(ALUctr)
            `ALU_add    : C=A+B;
            `ALU_sub    : C=A-B;
            `ALU_and    : C=A&B;
            `ALU_or     : C=A|B;
            `ALU_xor    : C=A^B;
            `ALU_lui    : C=B<<16;
            `ALU_slt    : C=(A<B)?32'd1:32'd0;//A<B->1,A>B->0
        endcase
    end
    assign zero = (C==32'b0);
endmodule
