`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/20 19:39:07
// Design Name: 
// Module Name: IFID
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


module IFID(clk,IFFlush,PCAdd4,Inst,pcadd4InIFID,instInIFID);
    input clk;
    input IFFlush;
    input  [31:0] PCAdd4;
    input [31:0] Inst;
    output reg [31:0] pcadd4InIFID;
    output reg [31:0] instInIFID;

    always @(posedge clk) begin
        pcadd4InIFID = PCAdd4;
        instInIFID = Inst;
        if(IFFlush)
        begin
            instInIFID = 32'b0;//nop
        end
    end
endmodule
