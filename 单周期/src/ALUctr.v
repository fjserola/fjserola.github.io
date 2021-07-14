`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 12:54:29
// Design Name: 
// Module Name: ALUctr
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

module ALUctr(fun,ALUOp,ALUctr);
    input [5:0] fun;
    input [2:0] ALUOp;
    output reg [2:0] ALUctr;

    always @(fun or ALUOp) begin
        if(ALUOp==3'b001)begin
            case (fun)
                6'b100000 :  ALUctr = `ALU_add;//add
                //addiu
                //addi
                6'b100010 :  ALUctr = `ALU_sub;//sub
                6'b100100 :  ALUctr = `ALU_and;//and
                6'b100101 :  ALUctr = `ALU_or; //or
                //ori
                6'b100110 :  ALUctr = `ALU_xor;//xor
                //lui
                6'b101010 :  ALUctr = `ALU_slt;//slt
                //lw
                //sw
                //beq
                //j
            endcase     
        end

        else if (ALUOp==3'b010) begin//010(ori)
            ALUctr = `ALU_or;
        end

        else if (ALUOp==3'b000) begin
            ALUctr = `ALU_add;
        end

        else if (ALUOp==3'b100) begin
            ALUctr = `ALU_sub;
        end

        else if (ALUOp==3'b111) begin
            ALUctr = `ALU_lui;
        end

    end
endmodule
