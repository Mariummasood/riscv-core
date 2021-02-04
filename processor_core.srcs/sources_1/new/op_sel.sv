`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2021 01:45:36 PM
// Design Name: 
// Module Name: op_sel
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


module op_sel();
/*input logic [1:0] operand_ASel ,extend_sel ,
input logic [31:0] pc,
input logic operand_BSel ,
input logic [31:0] rs1,rs2,
input logic [31:0] stype_imm ,sbtype_imm , ujtype_imm, utype_imm ,itype_imm,
output logic [31:0] operand_A ,operand_B );
// FOR OPERAND_B SELECTION
always_comb begin 
if (operand_BSel == 1'b1) begin
if (extend_sel == 2'b0 ) 
operand_B=itype_imm;
else if (extend_sel == 2'b01 )
operand_B=utype_imm;
else if (extend_sel == 2'b10 )
operand_B=stype_imm;
end
else
operand_B=rs2;
//FOR OPERAND_A SELECTION
if(operand_ASel == 2'b01)
operand_A=(pc+32'h4);
else
operand_A=rs1;
end*/
endmodule 