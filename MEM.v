`timescale 1ns / 1ps
`include "Data_memory.v"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    17:10:17 11/19/2017
// Design Name:
// Module Name:    MEM
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module MEM(clk);

	input clk;
	input [31:0] Address;
	input [31:0] WriteData;
	input RegWrite, MemtoReg, MemWrite, MemRead;
	input [4:0] WriteReg;

	output [31:0] ReadData;
	output [31:0] Result;
	output [4:0] WriteRegtoWB;
	output RegWritetoWB, MemtoRegtoWB;

	assign RegWritetoWB = RegWrite;
	assign MemtoRegtoWB = MemtoWB;
	assign Result = Address;
	assign WriteRegtoWB = WriteReg;

	Data_memory dataMemory(clk,Address,WriteData,ReadData,MemWrite,MemRead);

endmodule
