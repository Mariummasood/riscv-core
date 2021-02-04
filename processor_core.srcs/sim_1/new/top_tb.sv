`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2021 10:34:52 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb;
//Programm_counter
logic           clk;
logic           reset;
logic           branch_i;
logic  [1:0]     nextpc_sel;
logic [31:0]    imm_i;
logic [31:0]    pc_out;
logic [31:0]    program_counter;

//Inst_mem
logic           clk_i;
logic         reset_i;
logic      write_en_i; 
logic       read_en_i;
logic  [9:0]   addr_i; 
logic [31:0]   data_i;
logic [31:0]   data_o;

//Control_unit
logic  [31:0] ins;
logic  [31:0] pc;
logic         illegal;
logic         memtoreg; 
logic         regwrite; 
logic         memread; 
logic         memwrite;
logic [4:0]   rs1;
logic [4:0]   rs2;
logic [4:0]   rd;
logic [31:0]  immval;
logic         op_b_sel;
logic [1:0]   op_a_sel;
logic [1:0]   extend_sel;

//Reg_file 
logic           clk_reg;
logic           reset_reg;
logic           write_en;        //reg_write enable pin  
logic  [4:0]    rd_address;  //writeregister
logic  [4:0]    rs1_address;      //read reg1
logic  [4:0]    rs2_address;   //read reg2
logic [31:0]    rd_data;    //writedata
logic [31:0]    rs1_data;   //read data rs1
logic [31:0]    rs2_data;    //read data rs2

//Alu
logic  [5:0]    aluop;
logic [31:0]    operand_a;
logic [31:0]    operand_b;
logic [ 4:0]    shbits;
logic [31:0]    alu_out;
logic           branch;

//data_mem
logic clk_d;
logic reset_d;
logic [9:0] addr_d;
logic [31:0] data_in;
logic [31:0] data_out;
logic        load_en;
logic        store_en;

logic        instruction;

 pc pc_top(
.clk(clk_i)
,.reset(reset_i)
,.nextpc_sel(nextpc_sel)
,.branch(branch_i)
,.imm_i(imm_i)
,.pc_out(pc_out)
,.operand_a(operand_a));

assign addr_i = pc_out[9:0];

//INSTANTIATING ins_mem 
ins_mem ins_memtop(
 .clk(clk_i),
 .reset(reset_i),
 .write_en(write_en_i),
 .data_in(data_i),
 .addr(addr_i),
 .read_en(read_en_i),
 .data_out(data_out)
);
assign instruction = data_o;
//INSTANTIATING CONTROL unit 
control_unit control_unit1 (
.ins(data_o)
,.pc(program_counter)
,.illegal(illegal)
,.memwrite(memwrite)
,.regwrite(write_en)
,.memread(memread)
,.memtoreg(memtoreg)
,.branch(branch)
,.nextpc_sel(nextpc_sel)
,.rs1(rs1)
,.rs2(rs2)
,.rd(rd)
,.immval(immval)
,.aluop(aluop)
,.op_b_sel(op_b_sel)
);
//assign operand_a = (op_a_sel== 2'b01)? (pc+32'h4) : rs1_data;// 
assign operand_b = (op_b_sel==1) ? immval : rs2_data;

reg_file reg_filetop(
.clk(clk_reg),
.reset(reset_reg),
.write_en(write_en), 
.rd_address(rd_address), 
.rs1_address(rs1_address), 
.rs2_address(rs2_address),
.rd_data(rd_data),
.rs1_data(rs1_data),
.rs1_data(rs1_data)
);

   
alu alutop(
    .aluop(aluop),
    .operand_a(operand_a),
    .operand_b(operand_b),
    .shbits(shbits),
    .alu_out(alu_out)
    ,.operand_a(rs1_data),
    .operand_b(rs2_data)
 
);


//INSTANTIATING DATA MEMORY
data_mem data_memtop(
 .clk(clk_d),
 .reset(reset_d),
 .write_en(store_en),
 .read_en(load_en),
 .data_in (data_in),
 .addr(addr_d),
 .data_out(data_out)
);

initial clk =0;


initial clk =0;

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

