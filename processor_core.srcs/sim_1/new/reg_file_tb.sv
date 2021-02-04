`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2021 10:51:04 PM
// Design Name: 
// Module Name: reg_file_tb
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


module reg_file_tb;
logic clk;
logic write_en;
logic [4:0] rd_address, rs1_address, rs2_address;
logic [31:0 ]rd_data, rs1_data, rs2_data;

reg_file reg_file_1(
.clk(clk),
.write_en(write_en), 
.rd_address(rd_address), 
.rs1_address(rs1_address), 
.rs2_address(rs2_address),
.rd_data(rd_data),
.rs1_data(rs1_data),
.rs2_data(rs2_data)
);

initial begin
clk =0;
write_en=0;
rs1_address=0;
rs2_address=0;
rd_address=0;
rd_data=0;

#4; //write operation
write_en=1;
//rs1_address=5;
//rs2_address=6;
rd_address=5;
rd_data=10;

#4; //write operation
write_en=1;
//rs1_address=5;
//rs2_address=6;
rd_address=6;
rd_data=5;

#4; //read operation
write_en=0;
rs1_address=5;
rs2_address=6;
rd_address=11;
rd_data=100;

#4; //read & write operation
write_en=1;
rs1_address=5;
rs2_address=6;
rd_address=6;
rd_data=77;

end

always #2 clk=~clk;
endmodule
