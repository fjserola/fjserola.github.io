`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 19:20:37
// Design Name: 
// Module Name: NPC
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


module NPC(pc,jump_26,immextend,Branch,Jump,zero,NPC);
    input [31:0] pc;//least pc
    input [25:0] jump_26;//jump instruction 26bit
    input [31:0] immextend;//imm16 extend 32bit;
    input Branch;//control
    input Jump;//control
    input zero;//zero signal
    output [31:0] NPC;

    wire [31:0] pc_add4;
    wire [27:0] jump_28;//sll 2bit
    wire [31:0] jump_32;//add pc high 4bit
    wire [31:0] immextendsll2;//immediate extend sll 2bit(immextend*4)
    wire [31:0] pc_branch;//branch = pc+4+immediate*4
    wire Branch_Or_PCadd4;
    wire [31:0] pcadd4_Or_branch;//mux1

    assign pc_add4 = pc+4;//pc+4(first alu) normal npc
    assign jump_28 = {jump_26,2'b00};//jump sll 2bit
    assign jump_32 = {pc_add4[31:28],jump_28};//jump add high pc 4bit
    assign immextendsll2 = {immextend[29:0],2'b00};//immextend*4
    assign pc_branch = pc_add4+immextendsll2;//branch address
    assign Branch_Or_PCadd4 = Branch&zero;//Branch? PC+4?
    mux_32bit module_mux32bit1(pc_add4,pc_branch,Branch_Or_PCadd4,pcadd4_Or_branch);//PC+4? Branch?
    mux_32bit module_mux32bit2(pcadd4_Or_branch,jump_32,Jump,NPC);//Jump?/Branch? Jump?/PC+4?
endmodule
