`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2021 01:57:17 PM
// Design Name: 
// Module Name: main_tb
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


module main_tb;

logic clk;
logic reset;


top_core top_core1(
    .clk(clk)
    ,.reset(reset)
    );
    


initial begin
clk = 0;
reset = 1;
#2;
reset =0;
end
always #1 clk <= ~clk;
endmodule
