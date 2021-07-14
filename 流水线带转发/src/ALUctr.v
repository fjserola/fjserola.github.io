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

//ALUOp
`define ADD   5'b00000//addi,addiu,lw,sw,lh,lhu,lb,lbu
`define RType 5'b00001
`define OR    5'b00010//ori
`define AND   5'b00011//andi
`define SUB   5'b00100//beq,bne
`define XOR   5'b00101//xori
`define SLT   5'b00110//slt,slti
`define SLTU  5'b00111//sltu.sltiu
`define LUI   5'b01000//lui
`define Rand  5'b11111//XXXXX

//jr
`define jrno     2'b00
`define jr      2'b01
`define jalr    2'b10

module ALUctr(fun,ALUOp,ALUctr,jr);
    input [5:0] fun;
    input [4:0] ALUOp;
    output reg [4:0] ALUctr;
    output reg [1:0] jr;

    always @(fun or ALUOp) begin
        jr = `jrno;
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
                //addi 
                //addiu 
                //andi 
                //ori 
                //xori 
                //slti 
                //sltiu 
                //lui 
                6'b000000 :  ALUctr = `ALU_sll;//sll
                6'b000100 :  ALUctr = `ALU_sllv;//sllv
                6'b000010 :  ALUctr = `ALU_srl;//srl
                6'b000110 :  ALUctr = `ALU_srlv;//srlv
                6'b000011 :  ALUctr = `ALU_sra;//sra
                6'b000111 :  ALUctr = `ALU_srav;//srav
                //lw
                //lh 
                //lhu 
                //lb 
                //lbu 
                //sw 
                //sh
                //sb
                //beq
                //bne
                //j
                //jal
                6'b001000 : begin
                    ALUctr = `ALU_add;//jr
                    jr     = `jr;
                end
                6'b001001 : begin
                    ALUctr = `ALU_add;//jalr
                    jr     = `jalr;
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
