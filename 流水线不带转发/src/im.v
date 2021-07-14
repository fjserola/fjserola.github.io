`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/12 14:07:36
// Design Name: 
// Module Name: im
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


module im_4k(Addr,Inst);
    input [31:0] Addr;//address bus
    output [31:0] Inst;//32-bit memory output
    reg [31:0] rom [1023:0];//register memory

    initial begin
        $readmemh("code.txt",rom);//read code in code.txt
    end

    assign Inst = rom[Addr[11:2]];
endmodule
