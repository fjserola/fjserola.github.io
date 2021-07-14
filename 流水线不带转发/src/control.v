`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 19:18:56
// Design Name: 
// Module Name: control
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

//MemRead
`define lw   3'b000
`define lh   3'b001
`define lhu  3'b010
`define lb   3'b011
`define lbu  3'b100
//MemRead

//MemWrite
`define sno  2'b00
`define sh   2'b01
`define sb   2'b10
`define sw   2'b11
//MemWrite

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

module control(op,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,ExtOp,MemRead);
    input [5:0] op;//PC high 6bit
    output reg [1:0] Branch;
    output reg [1:0] Jump;
    output reg RegDst;      //rd or rt
    output reg ALUSrc;      //(reg file read data) or (immediate data exten) to (ALU B)
    output reg [3:0] ALUOp; //ALU operation
    output reg MemtoReg;    //(dm read data) or (alu data) to (reg file write)
    output reg RegWrite;    //reg file write enable
    output reg ExtOp;       //extend Operation
    output reg [1:0] MemWrite;    //dm write enable
    output reg [2:0] MemRead;

    //ALUOp 001(R-type) 010(ori) 000(addu,addiu,lw,sw) 100(beq) 111(lui)
    always @(*) begin
        case (op)
        6'b000000  : begin//R-type
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 1;      
            ALUSrc  = 0;      
            ALUOp   = `RType;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= `sno;
            ExtOp   = 0;
            MemRead = `lw;
        end

        6'b001000  : begin//addi
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `ADD;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= `sno; 
            ExtOp   = 1;  
            MemRead = `lw;
        end

        6'b001001  : begin//addiu
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `ADD;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= `sno; 
            ExtOp   = 1;
            MemRead = `lw;  
        end

        6'b001100  : begin//andi
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `AND;//and
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= `sno; 
            ExtOp   = 0; 
            MemRead = `lw; 
        end

        6'b001101  : begin//ori
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `OR;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= `sno;
            ExtOp   = 0;  
            MemRead = `lw; 
        end

        6'b001110  : begin//xori
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `XOR;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= `sno;
            ExtOp   = 0;  
            MemRead = `lw; 
        end

        6'b001010  : begin//slti
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `SLT;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= `sno;
            ExtOp   = 1;  
            MemRead = `lw; 
        end

        6'b001011  : begin//sltiu
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `SLTU;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= `sno;
            ExtOp   = 1;   
            MemRead = `lw;
        end

        6'b001111  : begin//lui
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `LUI;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= `sno; 
            ExtOp   = 0;
            MemRead = `lw;  
        end

        6'b100011  : begin//lw
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `ADD;
            MemtoReg= 1;    
            RegWrite= 1; 
            MemWrite= `sno; 
            ExtOp   = 1;  
            MemRead = `lw;
        end

        6'b100001  : begin//lh
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `ADD;
            MemtoReg= 1;    
            RegWrite= 1; 
            MemWrite= `sno; 
            ExtOp   = 1;  
            MemRead = `lh;
        end

        6'b100101  : begin//lhu
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `ADD;
            MemtoReg= 1;    
            RegWrite= 1; 
            MemWrite= `sno; 
            ExtOp   = 1;  
            MemRead = `lhu;
        end

        6'b100000  : begin//lb
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `ADD;
            MemtoReg= 1;    
            RegWrite= 1; 
            MemWrite= `sno; 
            ExtOp   = 1;  
            MemRead = `lb;
        end

        6'b100100  : begin//lbu
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `ADD;
            MemtoReg= 1;    
            RegWrite= 1; 
            MemWrite= `sno; 
            ExtOp   = 1;  
            MemRead = `lbu;
        end

        6'b101011  : begin//sw
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `ADD;
            MemtoReg= 0;    
            RegWrite= 0; 
            MemWrite= `sw; 
            ExtOp   = 1; 
            MemRead = `lw; 
        end

        6'b101001  : begin//sh
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `ADD;
            MemtoReg= 0;    
            RegWrite= 0; 
            MemWrite= `sh; 
            ExtOp   = 1; 
            MemRead = `lw; 
        end

        6'b101000  : begin//sb
            Branch  = `bno;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `ADD;
            MemtoReg= 0;    
            RegWrite= 0; 
            MemWrite= `sb; 
            ExtOp   = 1; 
            MemRead = `lw; 
        end

        6'b000100  : begin//beq
            Branch  = `beq;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 0;      
            ALUOp   = `SUB;
            MemtoReg= 0;    
            RegWrite= 0; 
            MemWrite= `sno; 
            ExtOp   = 0; 
            MemRead = `lw; 
        end

        6'b000101  : begin//bne
            Branch  = `bne;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 0;      
            ALUOp   = `SUB;
            MemtoReg= 0;    
            RegWrite= 0; 
            MemWrite= `sno; 
            ExtOp   = 0; 
            MemRead = `lw; 
        end

        6'b000010  : begin//j
            Branch  = `bno;
            Jump    = `j;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `Rand;
            MemtoReg= 0;    
            RegWrite= 0; 
            MemWrite= `sno; 
            ExtOp   = 0; 
            MemRead = `lw; 
        end

        6'b000011  : begin//jal
            Branch  = `bno;
            Jump    = `jal;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = `Rand;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= `sno; 
            ExtOp   = 0; 
            MemRead = `lw; 
        end

        endcase
    end
endmodule
