`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/12 20:53:34
// Design Name: 
// Module Name: mux
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


module mux_5bit(x,y,control,z);
    input [4:0] x,y;//5bit input
    output reg [4:0] z;
    input control;//control=1,choose y
    always @* begin
        if(control)//control = 1
            z = y;
        else
            z = x;
    end
endmodule

module mux_32bit(x,y,control,z);
    input [31:0] x,y;//32bit input
    output reg [31:0] z;
    input control;//control=1,choose y
    always @* begin
        if(control)//control = 1
            z = y;
        else
            z = x;
    end
endmodule
