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

//ALUOp
`define ADD   4'b0000//addi,addiu,lw,sw,lh,lhu,lb,lbu
`define RType 4'b0001
`define OR    4'b0010//ori
`define AND   4'b0011//andi
`define SUB   4'b0100//beq,bne
`define XOR   4'b0101//xori
`define SLT   4'b0110//slt,slti
`define SLTU  4'b0111//sltu.sltiu
`define LUI   4'b1000//lui
`define Rand  4'b1111//XXXX

module ALUctr(fun,ALUOp,ALUctr,jr);
    input [5:0] fun;
    input [3:0] ALUOp;
    output reg [3:0] ALUctr;
    output reg jr;

    always @(fun or ALUOp) begin
        jr = 0;
        if(ALUOp==`RType)begin
            case (fun)
                6'b100000 :  ALUctr = `ALU_add;//add
                6'b100001 :  ALUctr = `ALU_add;//addu no overflow
                6'b100010 :  ALUctr = `ALU_sub;//sub
                6'b100011 :  ALUctr = `ALU_sub;//subu no overflow
                6'b100100 :  ALUctr = `ALU_and;//and
                6'b100101 :  ALUctr = `ALU_or; //or
                6'b100111 :  ALUctr = `ALU_nor;//nor
                6'b100110 :  ALUctr = `ALU_xor;//xor
                6'b101010 :  ALUctr = `ALU_slt;//slt
                6'b101011 :  ALUctr = `ALU_sltu;//sltu
                //addi 1
                //addiu 1
                //andi 1
                //ori 1
                //xori 1
                //slti 1
                //sltiu 1
                //lui 1
                6'b000000 :  ALUctr = `ALU_sll;//sll
                6'b000010 :  ALUctr = `ALU_srl;//srl
                6'b000011 :  ALUctr = `ALU_sra;//sra
                //lw 1
                //lh 1
                //lhu 1
                //lb 1
                //lbu 1
                //sw 1
                //sh
                //sb
                //beq
                //bne
                //j
                //jal
                6'b001000 : begin
                    ALUctr = `ALU_add;//jr
                    jr     = 1;
                end
            endcase     
        end

        else if (ALUOp==`ADD) begin//addi,addiu,lw,sw,lh,lhu,lb,lbu
            ALUctr = `ALU_add;
        end

        else if (ALUOp==`OR) begin//ori
            ALUctr = `ALU_or;
        end

        else if (ALUOp==`AND) begin//andi
            ALUctr = `ALU_and;
        end

        else if (ALUOp==`SUB) begin//beq
            ALUctr = `ALU_sub;
        end

        else if (ALUOp==`XOR) begin//xori
            ALUctr = `ALU_xor;
        end

        else if (ALUOp==`SLT) begin//slti,slt
            ALUctr = `ALU_slt;
        end

        else if (ALUOp==`SLTU) begin//sltiu,sltu
            ALUctr = `ALU_sltu;
        end

        else if (ALUOp==`LUI) begin//lui
            ALUctr = `ALU_lui;
        end


    end
endmodule
