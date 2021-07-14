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
`define lno  3'b000
`define lw   3'b001
`define lh   3'b010
`define lhu  3'b011
`define lb   3'b100
`define lbu  3'b101
//MemRead

//MemWrite
`define sno  2'b00
`define sh   2'b01
`define sb   2'b10
`define sw   2'b11
//MemWrite

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

//j class
`define jno  2'b00
`define j    2'b01
`define jal  2'b10
//j class

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

module control(hazard,op,rt,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,ExtOp,MemRead);
    input hazard;
    input [5:0] op;//PC high 6bit
    input [4:0] rt;
    output reg [3:0] Branch;
    output reg [1:0] Jump;
    output reg RegDst;      //rd or rt
    output reg ALUSrc;      //(reg file read data) or (immediate data exten) to (ALU B)
    output reg [4:0] ALUOp; //ALU operation
    output reg MemtoReg;    //(dm read data) or (alu data) to (reg file write)
    output reg RegWrite;    //reg file write enable
    output reg ExtOp;       //extend Operation
    output reg [1:0] MemWrite;    //dm write enable
    output reg [2:0] MemRead;

    //ALUOp 001(R-type) 010(ori) 000(addu,addiu,lw,sw) 100(beq) 111(lui)
    always @(*) begin
        if(hazard==0)begin
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
            MemRead = `lno;
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
            MemRead = `lno;
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
            MemRead = `lno;  
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
            MemRead = `lno; 
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
            MemRead = `lno; 
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
            MemRead = `lno; 
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
            MemRead = `lno; 
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
            MemRead = `lno;
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
            MemRead = `lno;  
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
            MemRead = `lno; 
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
            MemRead = `lno; 
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
            MemRead = `lno; 
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
            MemRead = `lno; 
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
            MemRead = `lno; 
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
            MemRead = `lno; 
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
            MemRead = `lno; 
        end


        6'b000110  : begin//blez
            Branch  = `blez;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 0;      
            ALUOp   = `Rand;
            MemtoReg= 0;    
            RegWrite= 0; 
            MemWrite= `sno; 
            ExtOp   = 1; 
            MemRead = `lno; 
        end

        6'b0000111  : begin//bgtz
            Branch  = `bgtz;
            Jump    = `jno;
            RegDst  = 0;      
            ALUSrc  = 0;      
            ALUOp   = `Rand;
            MemtoReg= 0;    
            RegWrite= 0; 
            MemWrite= `sno; 
            ExtOp   = 1; 
            MemRead = `lno; 
        end
        
        6'b000001   : begin//REGMM
            case(rt)
                5'b00000 : begin//BLTZ
                    Branch  = `bltz;
                    Jump    = `jno;
                    RegDst  = 0;      
                    ALUSrc  = 0;      
                    ALUOp   = `Rand;
                    MemtoReg= 0;    
                    RegWrite= 0; 
                    MemWrite= `sno; 
                    ExtOp   = 1; 
                    MemRead = `lno; 
                end

                5'b00001 : begin//BGEZ
                    Branch  = `bgez;
                    Jump    = `jno;
                    RegDst  = 0;      
                    ALUSrc  = 0;      
                    ALUOp   = `Rand;
                    MemtoReg= 0;    
                    RegWrite= 0; 
                    MemWrite= `sno; 
                    ExtOp   = 1; 
                    MemRead = `lno; 
                end

                5'b10000 : begin//BLTZAL
                    Branch  = `bltzal;
                    Jump    = `jno;
                    RegDst  = 0;      
                    ALUSrc  = 0;      
                    ALUOp   = `Rand;
                    MemtoReg= 0;    
                    RegWrite= 0; 
                    MemWrite= `sno; 
                    ExtOp   = 1; 
                    MemRead = `lno;
                end

                5'b10001 : begin//BGEZAL
                    Branch  = `bgezal;
                    Jump    = `jno;
                    RegDst  = 0;      
                    ALUSrc  = 0;      
                    ALUOp   = `Rand;
                    MemtoReg= 0;    
                    RegWrite= 0; 
                    MemWrite= `sno; 
                    ExtOp   = 1; 
                    MemRead = `lno;
                end
            endcase
        end
        
        endcase
    end
    if(hazard==1)begin
        Branch  = `bno;
        Jump    = `jno;
        RegDst  = 0;      
        ALUSrc  = 0;      
        ALUOp   = `Rand;
        MemtoReg= 0;    
        RegWrite= 0; 
        MemWrite= `sno; 
        ExtOp   = 0; 
        MemRead = `lno;
    end
    end
endmodule
