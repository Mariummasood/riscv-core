`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2021 12:52:31 PM
// Design Name: 
// Module Name: ins_mem_tb
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


module ins_mem_tb;
logic clk , reset;
logic write_en; 
logic read_en;
logic [19:0] addr; 
logic [31:0] data_in;
logic [31:0] data_out;

ins_mem test(
.clk(clk)
,.reset(reset)
,.write_en(write_en)
,.addr(addr)
,.data_in(data_in)
,.data_out(data_out)

    );
    
    initial begin
   $readmemh("F:/Vivado/RTL/hex_fil.mem",mem); 
    end
    
endmodule
