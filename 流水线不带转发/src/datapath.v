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

module datapath(clk,rst,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,ExtOp,MemRead,op);
    input clk,rst;
    input [1:0] Branch;
    input [1:0] Jump;
    input RegDst;     
    input ALUSrc;     
    input [3:0] ALUOp;
    input MemtoReg;   
    input RegWrite;   
    input ExtOp;
    input [1:0] MemWrite;   
    input [2:0] MemRead;
    
    output [5:0] op;

    //define
    wire [31:0]four = 32'h0000_0004;
    wire [3:0] ALU_add = 4'b0001;
    //define
    wire [31:0] PC,NPC,Inst,WriteData,ReadData_1,ReadData_2,extend32,DataAddr,ReadData;
    wire [3:0] ALUctr;
    wire zero;
    wire MemtoReg_inMEMWB,RegWrite_inMEMWB;
    wire [4:0] rt_Or_rd_inMEMWB;
    wire [31:0] ALU_Add4;
	wire emptyline;
    wire [31:0] pcadd4_inIFID,inst_inIFID;
    //output in IFID

    pc module_PC(rst,clk,NPC,PC);//PC
    //input rst,clk,NPC. output PC.

    // assign ALU_Add4 = PC+4;
    //IFID input ALU_Add4
    ALU module_ALUadd4(PC,four,ALU_add,ALU_Add4);//ALU_Add4;
    //input PC,four,ALU_add. output ALU_Add4,zero

    im_4k module_im(PC,Inst);//IM
    //input PC. output 32bit Inst.

    IFID module_IFID(clk,ALU_Add4,Inst,pcadd4_inIFID,inst_inIFID);
    //input clk,ALU_Add4,Inst. output pcadd4InIFID, inst_inIFID.

	assign op = inst_inIFID[31:26];

    rf module_regfile(clk,rst,RegWrite_inMEMWB,inst_inIFID[25:21],inst_inIFID[20:16],rt_Or_rd_inMEMWB,WriteData,ReadData_1,ReadData_2);//Reg File
    //input clk,rst,RegWrite，rs,rt,(rd/rt)RegFile_wirte_addr,WriteData(from dm/(rf.read1+rf.read2)DataAddr)
    //output (rf.read1)ReadData_1,(rf.read2)ReadData_2.

    exten16 module_exten16(inst_inIFID[15:0],ExtOp,extend32);//imme extend
    //input imm,ExtOp. output extend32

    wire [31:0] pcadd4_inIDEX,rfReadData1_inIDEX,rfReadData2_inIDEX,extend32_inIDEX;
    wire [25:0] Inst26_inIDEX;
    //output for IDEX
    wire [4:0] rt_inIDEX,rd_inIDEX,sa_inIDEX;
    //output rt,rd in IDEX
    
    wire [1:0] Branch_inIDEX;
    wire [1:0] Jump_inIDEX;
    wire RegDst_inIDEX;
    wire ALUSrc_inIDEX;
    wire [3:0] ALUOp_inIDEX;
    wire MemtoReg_inIDEX;
    wire RegWrite_inIDEX;
    wire [1:0] MemWrite_inIDEX;
    wire [2:0] MemRead_inIDEX;
    //output control in IDEX
    IDEX module_IDEX(clk,Branch,Jump,RegDst,ALUSrc,ALUOp,MemtoReg,RegWrite,MemWrite,MemRead,
            pcadd4_inIFID,ReadData_1,ReadData_2,extend32,inst_inIFID[20:16],inst_inIFID[15:11],inst_inIFID[10:6],inst_inIFID[25:0],
            pcadd4_inIDEX,rfReadData1_inIDEX,rfReadData2_inIDEX,extend32_inIDEX,rt_inIDEX,rd_inIDEX,sa_inIDEX,Inst26_inIDEX,
            Branch_inIDEX,Jump_inIDEX,RegDst_inIDEX,ALUSrc_inIDEX,ALUOp_inIDEX,MemtoReg_inIDEX,RegWrite_inIDEX,MemWrite_inIDEX,MemRead_inIDEX
           );
    //Jump
    wire [31:0] JumpAddr;
    assign JumpAddr = {pcadd4_inIDEX[31:28],Inst26_inIDEX,2'b00};


	wire [4:0] rd_Or_rt;
    mux_5bit module_mux5bit(rt_inIDEX,rd_inIDEX,RegDst_inIDEX,rd_Or_rt);
    // before rf. rt?rd?->rf.write_addr   input rt,rd,RegDst. output rd_Or_rt.

	wire [31:0] ReadData2_Or_immexten32;
    mux_32bit module_mux32bit1(rfReadData2_inIDEX,extend32_inIDEX,ALUSrc_inIDEX,ReadData2_Or_immexten32);
    //exten32 or rf.read2 to ALU ->(end)DataAddr

    wire jr;
    ALUctr module_ALUctr(extend32_inIDEX[5:0],ALUOp_inIDEX,ALUctr,jr);//ALU_ctr
    //input fun and ALUOp->ALUctr

    ALU module_ALU(rfReadData1_inIDEX,ReadData2_Or_immexten32,ALUctr,DataAddr,zero,sa_inIDEX);//ALU
    //rf.read1+(ReadData2_Or_immexten32) pass ALUctr control->DataAddr and zero

	wire [31:0] PCAdd4_AddExten32;
	wire [31:0] extend32_inIDEXsll2;
    //branch ex
	assign extend32_inIDEXsll2 = {extend32_inIDEX[29:0],2'b00};
	ALU module_ADDSLL2(pcadd4_inIDEX,extend32_inIDEXsll2,ALU_add,PCAdd4_AddExten32);//ALU for add exten32sll2 and pcadd4
    //branch ex
    wire [31:0] JalAddr;
    wire [31:0] pcaddr8;
    ALU module_PCAdd8(pcadd4_inIDEX,four,ALU_add,pcaddr8);
    assign JalAddr = {pcadd4_inIDEX[31:28],Inst26_inIDEX,2'b00};

    wire [1:0] Branch_inEXMEM;
    wire [1:0] Jump_inEXMEM;
    wire MemtoReg_inEXMEM;
    wire RegWrite_inEXMEM;
    wire [1:0] MemWrite_inEXMEM;
    wire [2:0] MemRead_inEXMEM;
    wire zero_inEXMEM;
    wire [31:0] PCAdd4_AddExten32_inEXMEM;
    wire [31:0] DataAddr_inEXMEM;
    wire [31:0] rfReadData2_inEXMEM;
    wire [31:0] JumpAddr_inEXMEM;
    wire [4:0] rd_Or_rt_inEXMEM;
    wire [31:0] JalAddr_inEXMEM;
    wire [31:0] pcaddr8_inEXMEM;
    EXMEM module_EXMEM(clk,Branch_inIDEX,Jump_inIDEX,,MemtoReg_inIDEX,RegWrite_inIDEX,MemWrite_inIDEX,MemRead_inIDEX,zero,jr,
            PCAdd4_AddExten32,DataAddr,rfReadData2_inIDEX,JumpAddr,rd_Or_rt,JalAddr,pcaddr8,
            Branch_inEXMEM,Jump_inEXMEM,MemtoReg_inEXMEM,RegWrite_inEXMEM,MemWrite_inEXMEM,MemRead_inEXMEM,zero_inEXMEM,jr_inEXMEM,
            PCAdd4_AddExten32_inEXMEM,DataAddr_inEXMEM,rfReadData2_inEXMEM,JumpAddr_inEXMEM,rd_Or_rt_inEXMEM,JalAddr_inEXMEM,pcaddr8_inEXMEM
            );//output

    //NPC
    wire [31:0] DataAddr_inJAL;
    wire [4:0]  rd_Or_rt_inJAL;
    jal module_jal(Jump_inEXMEM,DataAddr_inEXMEM,pcaddr8_inEXMEM,rd_Or_rt_inEXMEM,DataAddr_inJAL,rd_Or_rt_inJAL);
    // if(Jump_inEXMEM==`jal)
    // begin
    //     assign DataAddr_inEXMEM = pcaddr8_inEXMEM;
    //     assign rd_Or_rt_inEXMEM = 5'b11111;
    // end
	NPC module_NPC(Branch_inEXMEM,zero_inEXMEM,Jump_inEXMEM,jr_inEXMEM,PCAdd4_AddExten32_inEXMEM,ALU_Add4,JumpAddr_inEXMEM,JalAddr_inEXMEM,DataAddr_inJAL,NPC);
    //NPC

    //dm,MEMWB,mux
    dm_4k module_dm(clk,rst,DataAddr_inJAL,rfReadData2_inEXMEM,ReadData,MemWrite_inEXMEM,MemRead_inEXMEM);//DM
    //input DataAddr(rfReadData1_Add_MUX_inEXMEM) rf.read2 to write pass MemWrite      input DataAddr output dm.ReadData

    wire [31:0] dmReadData_inMEMWB,rfReadData1_Add_MUX_inMEMWB;
    MEMWB module_MEMWB(clk,MemtoReg_inEXMEM,RegWrite_inEXMEM,ReadData,DataAddr_inJAL,rd_Or_rt_inJAL,
            MemtoReg_inMEMWB,RegWrite_inMEMWB,dmReadData_inMEMWB,rfReadData1_Add_MUX_inMEMWB,rt_Or_rd_inMEMWB);

    mux_32bit module_mux32bit2(rfReadData1_Add_MUX_inMEMWB,dmReadData_inMEMWB,MemtoReg_inMEMWB,WriteData);
    //input dm.readData and rf.read1+rf.read2. output rf.writeData
    

endmodule
