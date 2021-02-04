`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 10:36:47 AM
// Design Name: 
// Module Name: top_core
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


module top_core(
//Programm_counter
input logic           clk,
input logic           reset
);
logic           branch_i;
logic  [1:0]    nextpc_sel;
logic [31:0]    imm_i;
logic [31:0]    pc_out;
logic [31:0]    program_counter;

//Inst_mem
logic       read_en_i;
logic  [11:0]   addr_i; 
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
logic [11:0]    aluout_addr;
//data_mem
logic           clk_d;
logic           reset_d;
logic [9:0]     addr_d;
logic [31:0]    data_in;
logic [31:0]    data_out;
logic           load_en;
logic           store_en;
logic           instruction;
logic           write_enable;


 pc pc_top(
.clk(clk)
,.reset(reset)
,.nextpc_sel(nextpc_sel)
,.branch(branch_i)
,.imm_i(imm_i)
,.pc_out(pc_out)
,.operand_a(rs1_data)
);

assign addr_i = pc_out[11:2];

//INSTANTIATING ins_mem 
ins_mem ins_memtop(
 .clk(clk)
 ,.reset(reset)
 ,.write_en(1'b0)
 ,.data_in(data_i)
 ,.addr_i(addr_i)
 ,.read_en(1'b1)
 ,.data_o(data_o)
);
assign instruction = data_o;
//INSTANTIATING CONTROL unit 

control_unit control_unittop (
.ins(data_o)
,.pc(pc_out)
,.illegal(illegal)
,.memwrite(memwrite)
,.regwrite(regwrite)
,.memread(memread)
,.memtoreg(memtoreg)
,.branch(branch)
,.nextpc_sel(nextpc_sel)
,.rs1(rs1)
,.rs2(rs2)
,.rd(rd_address)
,.immval(immval)
,.aluop(aluop)
,.op_b_sel(op_b_sel)
,.op_a_sel(op_a_sel)
,.extend_sel(extend_sel)
);
 

//assign write_en = regwrite;//


reg_file reg_filetop(
.clk(clk)
,.reset(reset)
,.write_en(regwrite)
,.rd_address(rd_address)
,.rs1_address(rs1) 
,.rs2_address(rs2)
,.rd_data(rd_data)
,.rs1_data(rs1_data)
,.rs2_data(rs2_data)
);

assign rd_data = (memtoreg == 1'b1) ? data_out: alu_out;

assign  aluout_addr= alu_out[13:2] ;

always_comb begin 
if(op_a_sel == 2'b01)
operand_a = rs1_data + pc;
else if (op_a_sel == 2'b10)
operand_a= rs1_data + pc+ 32'h4;
else 
 operand_a = rs1_data;
end

assign operand_b = (op_b_sel) ? rs2_data :immval;


/*assign operand_a = (op_a_sel== 2'b01) ? pc  : rs1_data; //auipc
assign operand_a = (op_a_sel== 2'b10) ? pc+32'h4  : rs1_data; //jal, jalr */


alu alutop(
.aluop(aluop)
,.operand_a(operand_a)
,.operand_b(operand_b)
,.shbits(shbits)
,.alu_out(alu_out)
,.branch(branch_i)
 
);



assign load_en= memread ;
//assign store_en= memwrite ;//



//INSTANTIATING DATA MEMORY
data_mem data_memtop(
 .clk(clk)
 ,.reset(reset)
 ,.store(write_en)
 ,.read_en(load_en)
 ,.data_in (data_in)
 ,.addr(aluout_addr)
 ,.data_out(data_out)
);
 

endmodule