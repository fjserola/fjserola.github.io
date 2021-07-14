`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 19:18:37
// Design Name: 
// Module Name: exten16
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


module exten16(imm16,ExtOp,immeextend);
    input [15:0] imm16;
    input ExtOp;
    output wire [31:0]immeextend;
    assign immeextend = (ExtOp==1)?{{16{imm16[15]}},imm16}:{16'b0000000000000000,imm16} ;
endmodule
