`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2021 03:49:09 PM
// Design Name: 
// Module Name: top
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

module top;
logic clk , reset, writedata, write_en,imm;

logic [11:0]  imm12;
logic [19:0]  imm20, addr, instrmem_addr;  
logic [9:0] alu_addr , datamem_addr;

logic [31:0] instr;
logic [31:0] program_counter;
logic         illegal;
logic         memtoreg; 
logic         regwrite; 
logic         memread; 
logic         memwrite; 
logic         branch;
logic [1:0]   jump; //nextpc_sel
logic [5:0]   aluop; //alu control bits
logic [4:0]   rs1;
logic [4:0]   rs2;
logic [4:0]   rd;
logic [31:0]  immval;
logic [1:0] extend_sel;
logic op_b_sel;
logic [5:0] aluop_cu;

logic wen_i;
logic ren_i;
logic [31:0] data_in_i;
logic [31:0] data_o;
logic [9:0] addr_i; 

logic wen_d;
logic ren_d;
logic [31:0] data_in_d;
logic [31:0] data_o_d;
logic [9:0] addr_d;

logic wen_reg; 
logic [4:0] rd_regadd_i; 
logic [4:0] rs1_regadd_i; 
logic [4:0]rs2_regadd_i;
logic [31:0]rd_regdata_o;
logic [31:0]rs1_regdata_o;
logic [31:0] rs2_regdata_o;

logic  [31:0] operand_a;
logic  [31:0] operand_b;
logic  [31:0] instr_i;
logic  [31:0] rs1_data;
logic  [31:0] rs2_data;
logic [4:0] shbits;
logic [31:0] alu_out;

logic clk_i;
logic reset_i; 
logic [1:0]    nextpc_sel;
logic          branch_i;
logic [31:0]   imm_i;
logic [31:0]  pc_out;
logic [31:0] instruction;

pc pc_top(
.clk(clk_i)
,.reset(reset_i)
,.nextpc_sel(nextpc_sel)
,.branch(branch_i)
,.imm_i(immval)
,.pc_out(pc_out));

assign addr_i = pc_out[9:0];

//INSTANTIATING ins_mem 
ins_mem ins_memtop(
 .clk(clk),
 .reset(reset),
 .write_en(wen_i),
 .data_in (data_in_i),
 .addr(addr_i),
 .read_en(ren_i),
 .data_out(data_o)
);
assign instruction = data_o;
//INSTANTIATING CONTROL unit 
control_unit control_unittop (
.clk(clk)
,.ins(data_o)
,.pc(program_counter)
,.illegal(illegal)
,.memwrite(memwrite)
,.regwrite(write_en)
,.memread(ren_d)
,.memtoreg(memtoreg)
,.branch(branch)
,.jump(jump)
,.rs1(rs1)
,.rs2(rs2)
,.rd(rd)
,.immval(immval)
,.aluop(aluop_cu)
,.op_b_sel(op_b_sel)
);
//assign operand_a = (op_a_sel== 2'b01)? (pc+32'h4) : rs1_data;// 
assign operand_b = (op_b_sel==1) ? immval : rs2_data;

reg_file reg_filetop(
.clk(clk),
.reset(reset),
.write_en(wen_reg), 
.rd_address(rd_regadd_i), 
.rs1_address(rs1_regadd_i), 
.rs2_address(rs2_regadd_i),
.rd_data(rd_regdata_o),
.rs1_data(rs1_regdata_o),
.rs2_data(rs2_regdata_o)
);

   
alu alutop(
    .aluop(aluop),
    /*.operand_a(op_a_sel),
    .operand_b(op_b_sel), */
    .shbits(shbits),
    .alu_out(alu_out)
    ,.operand_a(rs1_regadd_i),
    .operand_b(rs2_regadd_i)
 
);


//INSTANTIATING DATA MEMORY
data_mem data_memtop(
 .clk(clk),
 .reset(reset),
 .write_en(write_en),
 .read_en(ren_d),
 .data_in (data_in_d),
 .addr(addr_d),
 .data_out(data_o_d)
);

initial clk =0;

endmodule
