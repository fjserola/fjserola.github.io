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

module control(op,RegDst,Jump,Branch,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,ExtOp);
    input [5:0] op;//PC high 6bit
    output reg Branch;
    output reg Jump;
    output reg RegDst;      //rd or rt
    output reg ALUSrc;      //(reg file read data) or (immediate data exten) to (ALU B)
    output reg [2:0] ALUOp; //ALU operation
    output reg MemtoReg;    //(dm read data) or (alu data) to (reg file write)
    output reg RegWrite;    //reg file write enable
    output reg MemWrite;    //dm write enable
    output reg ExtOp;       //extend Operation

    //ALUOp 001(R-type) 010(ori) 000(addu,addiu,lw,sw) 100(beq) 111(lui)
    always @(*) begin
        case (op)
        6'b000000  : begin//R-type
            Branch  = 0;
            Jump    = 0;
            RegDst  = 1;      
            ALUSrc  = 0;      
            ALUOp   = 3'b001;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= 0;
            ExtOp   = 0;
        end

        6'b001101  : begin//ori
            Branch  = 0;
            Jump    = 0;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = 3'b010;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= 0;
            ExtOp   = 0;   
        end

        6'b001001  : begin//addiu
            Branch  = 0;
            Jump    = 0;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = 3'b000;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= 0; 
            ExtOp   = 1;  
        end

        6'b100011  : begin//lw
            Branch  = 0;
            Jump    = 0;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = 3'b000;
            MemtoReg= 1;    
            RegWrite= 1; 
            MemWrite= 0; 
            ExtOp   = 1;  
        end

        6'b101011  : begin//sw
            Branch  = 0;
            Jump    = 0;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = 3'b000;
            MemtoReg= 0;    
            RegWrite= 0; 
            MemWrite= 1; 
            ExtOp   = 1;  
        end

        6'b000100  : begin//beq
            Branch  = 1;
            Jump    = 0;
            RegDst  = 0;      
            ALUSrc  = 0;      
            ALUOp   = 3'b100;
            MemtoReg= 0;    
            RegWrite= 0; 
            MemWrite= 0; 
            ExtOp   = 0;  
        end

        6'b000010  : begin//jump
            Branch  = 0;
            Jump    = 1;
            RegDst  = 0;      
            ALUSrc  = 0;      
            ALUOp   = 3'bxxx;
            MemtoReg= 0;    
            RegWrite= 0; 
            MemWrite= 0; 
            ExtOp   = 0;  
        end

        6'b001000  : begin//addi
            Branch  = 0;
            Jump    = 0;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = 3'b000;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= 0; 
            ExtOp   = 1;  
        end

        6'b001111  : begin//lui
            Branch  = 0;
            Jump    = 0;
            RegDst  = 0;      
            ALUSrc  = 1;      
            ALUOp   = 3'b111;
            MemtoReg= 0;    
            RegWrite= 1; 
            MemWrite= 0; 
            ExtOp   = 0;  
        end

        endcase
    end
endmodule
