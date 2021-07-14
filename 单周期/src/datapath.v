`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/15 09:58:55
// Design Name: 
// Module Name: datapath
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


module datapath(clk,rst,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,ExtOp,op,PC);
    input clk,rst;
    input Branch;
    input Jump;
    input RegDst;     
    input ALUSrc;     
    input [2:0] ALUOp;
    input MemtoReg;   
    input RegWrite;   
    input MemWrite;   
    input ExtOp;      
    output [5:0] op;
    output [31:0] PC;

    wire [31:0] NPC,Inst,WriteData,ReadData_1,ReadData_2,exten32,ReadData2_Or_immexten32,DataAddr,ReadData;
    wire [4:0] RegFile_wirte_addr;
    wire [2:0] ALUctr;
    wire zero;

    pc module_PC(rst,clk,NPC,PC);//PC
    //input rst,clk,NPC. output PC.

    im_4k module_im(PC,Inst);//IM
    //input PC. output 32bit Inst.

    mux_5bit module_mux5bit(Inst[20:16],Inst[15:11],RegDst,RegFile_wirte_addr);
    //before rf. rt?rd?->rf.write_addr   input rt,rd,RegDst. output addr.

    rf module_regfile(clk,rst,RegWrite,Inst[25:21],Inst[20:16],RegFile_wirte_addr,WriteData,ReadData_1,ReadData_2);//Reg File
    //input clk,rst,RegWrite，rs,rt,(rd/rt)RegFile_wirte_addr,WriteData(from dm/(rf.read1+rf.read2)DataAddr)
    //output (rf.read1)ReadData_1,(rf.read2)ReadData_2.

    exten16 module_exten16(Inst[15:0],ExtOp,exten32);//imme extend
    //input imm,ExtOp. output extend32

    mux_32bit module_mux32bit1(ReadData_2,exten32,ALUSrc,ReadData2_Or_immexten32);
    //exten32 or rf.read2 to ALU ->(end)DataAddr

    ALUctr module_ALUctr(Inst[5:0],ALUOp,ALUctr);//ALU_ctr
    //input fun and ALUOp->ALUctr

    ALU module_ALU(ReadData_1,ReadData2_Or_immexten32,ALUctr,DataAddr,zero);//ALU
    //rf.read1+(ReadData2_Or_immexten32) pass ALUctr control->DataAddr and zero

    dm_4k module_dm(clk,rst,DataAddr,ReadData_2,ReadData,MemWrite);//DM
    //input DataAddr rf.read2 to write pass MemWrite      input DataAddr output dm.ReadData

    mux_32bit module_mux32bit2(DataAddr,ReadData,MemtoReg,WriteData);
    //input dm.readData and rf.read1+rf.read2. output rf.writeData
    
    NPC module_NPC(PC,Inst[25:0],exten32,Branch,Jump,zero,NPC);//NPC

    assign op = Inst[31:26];
endmodule
