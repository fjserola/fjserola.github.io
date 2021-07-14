`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/18 00:02:06
// Design Name: 
// Module Name: Hazard
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


module Hazard(MemtoReg_inIDEX,rt_inIDEX,rs_inIFID,rt_inIFID,hazard);
    input MemtoReg_inIDEX;
    input [4:0] rt_inIDEX;
    input [4:0] rs_inIFID;
    input [4:0] rt_inIFID;

    output reg hazard;

    always @(*) begin
        if(MemtoReg_inIDEX == 1 && rt_inIDEX != 0 && (rt_inIDEX == rs_inIFID || rt_inIDEX == rt_inIFID) )
            hazard = 1;
        else hazard = 0;
    end
endmodule
