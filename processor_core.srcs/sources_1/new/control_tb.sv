`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2021 01:18:59 PM
// Design Name: 
// Module Name: control_tb
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


module control_tb;

logic [31:0] instruction;
logic [31:0] program_counter;
logic         illegal;
logic         memtoreg; 
logic         regwrite; 
logic         memread; 
logic         memwrite; 
logic         branch;
logic [1:0]   nextpc_sel; //nextpc_sel
logic [5:0]   aluop; //alu control bits
logic [4:0]   rs1;
logic [4:0]   rs2;
logic [4:0]   rd;
logic [31:0]  immval;
logic [1:0] extend_sel;
logic op_b_sel;
logic [1:0] op_a_sel; 


/*logic clk , reset;
logic write_en; 
logic read_en;
logic [19:0] addr; 
logic [31:0] data_in;
logic [31:0] data_out; */

/*ins_mem ins_mem1(
.clk(clk)
,.reset(reset)
,.write_en(write_en)
,.addr(addr)
,.data_in(instruction)
,.data_out(data_out)
    ); */
    
control_unit dut(
    .ins(instruction),
    .pc (program_counter),
.illegal(illegal),
.memtoreg(memtoreg), 
.regwrite(regwrite), 
.memread(memread), 
.memwrite(memwrite), 
.branch(branch),
.nextpc_sel(nextpc_sel), //nextpc_sel
.aluop(aluop), //alu control bits
.rs1(rs1),
.rs2(rs2),
.rd(rd),
.immval(immval),
.extend_sel(extend_sel)
,.op_b_sel(op_b_sel)

);
 


initial begin



#10;
instruction = 32'h005201B3;    //add
program_counter    = 32'h00000004;

#10;

instruction = 32'h00537293; //andi
program_counter    = 32'h00000008;

#10;

instruction = 32'hFF9FF0EF; //jal and up to Pc=4
program_counter    = 32'h0000000c;

#10;

instruction = 32'h05BA02B7; //lui
program_counter    = 32'h000000016;

#10;

instruction = 32'h31528293; //addi
program_counter    = 32'h000000020;
 
 #10;

instruction = 32'h00800313; //lui 23456
program_counter    = 32'h000000024;

#10;
instruction = 32'h00A98863; //addi 789
program_counter    = 32'h00000028;

 #10;

instruction = 32'h00A90933; //addi
program_counter    = 32'h000000024;

#10;
instruction = 32'hFFF98993; //loop beq 
program_counter    = 32'h00000000;


 #10;

instruction = 32'hFF5FF06F;
program_counter    = 32'h000000024;


end
endmodule

