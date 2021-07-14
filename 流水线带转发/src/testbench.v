`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/15 16:01:22
// Design Name: 
// Module Name: testbench
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


module testbench;
    reg clk,rst;
    wire [31:0] PC;
    mips Mips(clk,rst);
    initial begin
        clk=0;
        rst=1;
        #50;
        clk=1;
        #50;
        rst=0;
        clk=0;
        forever #50 begin
            clk=!clk;
        end
    end
endmodule
