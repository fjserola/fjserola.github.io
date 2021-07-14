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

`define jal  2'b10

module datapath(clk,rst,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,ExtOp,MemRead,op,rt,hazard);
    input clk,rst;
    input [3:0] Branch;
    input [1:0] Jump;
    input RegDst;     
    input ALUSrc;     
    input [4:0] ALUOp;
    input MemtoReg;   
    input RegWrite;   
    input ExtOp;
    input [1:0] MemWrite;   
    input [2:0] MemRead;
    
    output [5:0] op;
    output [4:0] rt;
    output hazard;

    //define
    wire [31:0]four = 32'h0000_0004;
    wire [4:0] ALU_add = 5'b00001;
    //define

    wire [31:0] PC,NPC,Inst,WriteData,ReadData_1,ReadData_2,extend32,DataAddr,ReadData;
    wire [4:0] ALUctr;
    wire zero;
    wire gz,lz;
    wire rf31Write;

    wire [31:0] ALU_Add4;
	wire emptyline;

    wire [31:0] pcadd4_inIFID,inst_inIFID;

    wire [31:0] RealReadData1,RealReadData2;
    wire [1:0] ForwardA,ForwardB;

    wire MemtoReg_inIDEX;
    wire [4:0] rs_inIDEX,rt_inIDEX,rd_inIDEX,sa_inIDEX;
    wire [31:0] rfReadData1_inIDEX,rfReadData2_inIDEX,extend32_inIDEX;
    wire RegDst_inIDEX;
    wire ALUSrc_inIDEX;
    wire [4:0] ALUctr_inIDEX;
    wire RegWrite_inIDEX;
    wire [1:0] MemWrite_inIDEX;
    wire [2:0] MemRead_inIDEX;

    wire MemtoReg_inEXMEM;
    wire RegWrite_inEXMEM;
    wire [1:0] MemWrite_inEXMEM;
    wire [2:0] MemRead_inEXMEM;
    wire [31:0] DataAddr_inEXMEM;
    wire [31:0] rfReadData2_inEXMEM;
    wire [4:0] rd_Or_rt_inEXMEM;

    wire MemtoReg_inMEMWB,RegWrite_inMEMWB;
    wire [4:0] rt_Or_rd_inMEMWB;
    
    //output in IFID
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    pc module_PC(rst,clk,NPC,PC);//PC
    //input rst,clk,NPC. output PC.

    // assign ALU_Add4 = PC+4;
    //IFID input ALU_Add4
    ALU module_ALUadd4(PC,four,ALU_add,ALU_Add4);//ALU_Add4;
    //input PC,four,ALU_add. output ALU_Add4

    im_4k module_im(PC,Inst);//IM
    //input PC. output 32bit Inst.

    IFID module_IFID(clk,IFFlush,ALU_Add4,Inst,pcadd4_inIFID,inst_inIFID);
    //input clk,ALU_Add4,Inst. output pcadd4InIFID, inst_inIFID.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    assign op = inst_inIFID[31:26];
    assign rt = inst_inIFID[20:16];

    wire [31:0] JumpAddr;
    assign JumpAddr = {pcadd4_inIFID[31:28],inst_inIFID[25:0],2'b00};

    rf module_regfile(clk,rst,RegWrite_inMEMWB,inst_inIFID[25:21],inst_inIFID[20:16],rt_Or_rd_inMEMWB,WriteData_inMEMWB,ReadData_1,ReadData_2,
                        rf31Write,pcadd4_inIFID);//Reg File
    //input clk,rst,RegWrite，rs,rt,(rd/rt)RegFile_wirte_addr,WriteData(from dm/(rf.read1+rf.read2)DataAddr)
    //output (rf.read1)ReadData_1,(rf.read2)ReadData_2.

    exten16 module_exten16(inst_inIFID[15:0],ExtOp,extend32);//imme extend
    //input imm,ExtOp. output extend32

    wire [1:0] jr;
    ALUctr module_ALUctr(inst_inIFID[5:0],ALUOp,ALUctr,jr);//ALU_ctr
    //input fun and ALUOp->ALUctr

    mux3_32bit module_rfread1(ReadData_1,DataAddr,WriteData,ForwardA,RealReadData1);
    mux3_32bit module_rfread2(ReadData_2,DataAddr,WriteData,ForwardB,RealReadData2);


    BranchCtr module_BranchCtr(RealReadData1,RealReadData2,zero,gz,lz);

    NPC module_NPC(Branch,zero,gz,lz,Jump,jr,ALU_Add4,BranchAddr,JumpAddr,RealReadData1,NPC,IFFlush);

    jal module_jal(Jump,jr,Branch,rf31Write);


    wire [31:0] BranchAddr;
	wire [31:0] extend32_sll2;
    //branch ex
	assign extend32_sll2 = {extend32[29:0],2'b00};
	ALU module_ADDSLL2(pcadd4_inIFID,extend32_sll2,ALU_add,BranchAddr);//ALU for add exten32sll2 and pcadd4
    //branch ex

    Hazard module_Hazard(MemtoReg_inIDEX,rt_inIDEX,inst_inIFID[25:21],inst_inIFID[20:16],hazard);

    Forwarding module_Forward(inst_inIFID[25:21],inst_inIFID[20:16],RegWrite_inIDEX,RegWrite_inEXMEM,rd_Or_rt,rd_Or_rt_inEXMEM,ForwardA,ForwardB);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    IDEX module_IDEX(clk,RegDst,ALUSrc,ALUctr,MemtoReg,RegWrite,MemWrite,MemRead,
            RealReadData1,RealReadData2,extend32,inst_inIFID[25:21],inst_inIFID[20:16],inst_inIFID[15:11],inst_inIFID[10:6],
            rfReadData1_inIDEX,rfReadData2_inIDEX,extend32_inIDEX,rs_inIDEX,rt_inIDEX,rd_inIDEX,sa_inIDEX,
            RegDst_inIDEX,ALUSrc_inIDEX,ALUctr_inIDEX,MemtoReg_inIDEX,RegWrite_inIDEX,MemWrite_inIDEX,MemRead_inIDEX
           );

	wire [4:0] rd_Or_rt;
    mux_5bit module_mux5bit(rt_inIDEX,rd_inIDEX,RegDst_inIDEX,rd_Or_rt);
    // before rf. rt?rd?->rf.write_addr   input rt,rd,RegDst. output rd_Or_rt.

	wire [31:0] ALU_B;
    mux_32bit module_mux32bit1(rfReadData2_inIDEX,extend32_inIDEX,ALUSrc_inIDEX,ALU_B);
    //exten32 or rf.read2 to ALU ->(end)DataAddr

    ALU module_ALU(rfReadData1_inIDEX,ALU_B,ALUctr_inIDEX,DataAddr,emptyline,rs_inIDEX,sa_inIDEX);//ALU
    //rf.read1+(ALU_B) pass ALUctr control->DataAddr and zero

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    EXMEM module_EXMEM(clk,MemtoReg_inIDEX,RegWrite_inIDEX,MemWrite_inIDEX,MemRead_inIDEX,
            DataAddr,rfReadData2_inIDEX,rd_Or_rt,
            MemtoReg_inEXMEM,RegWrite_inEXMEM,MemWrite_inEXMEM,MemRead_inEXMEM,
            DataAddr_inEXMEM,rfReadData2_inEXMEM,rd_Or_rt_inEXMEM
            );

    //dm,MEMWB,mux
    dm_4k module_dm(clk,rst,DataAddr_inEXMEM,rfReadData2_inEXMEM,ReadData,MemWrite_inEXMEM,MemRead_inEXMEM);//DM
    //input DataAddr(rfReadData1_Add_MUX_inEXMEM) rf.read2 to write pass MemWrite      input DataAddr output dm.ReadData

    mux_32bit module_mux32bit2(DataAddr_inEXMEM,ReadData,MemtoReg_inEXMEM,WriteData);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    wire [31:0] WriteData_inMEMWB;
    MEMWB module_MEMWB(clk,RegWrite_inEXMEM,WriteData,rd_Or_rt_inEXMEM,
            RegWrite_inMEMWB,WriteData_inMEMWB,rt_Or_rd_inMEMWB);

    //input dm.readData and rf.read1+rf.read2. output rf.writeData
    

endmodule
