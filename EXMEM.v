`ifndef _exmem
`define _exmem
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    19:05:39 11/19/2017
// Design Name:
// Module Name:    EXMEM
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
module EXMEM(clk, reset, ALUResult, WriteDataEX, WriteRegEX,
		RegWriteEX, MemReadEX, MemWriteEX, MemtoRegEX,
		Address, WriteDataMEM, WriteRegMEM,
		RegWriteMEM, MemReadMEM, MemWriteMEM, MemtoRegMEM
);

	input clk, reset;
	input [31:0] ALUResult;
	input [31:0] WriteDataEX;
	input [4:0] WriteRegEX;

	input RegWriteEX, MemReadEX, MemWriteEX, MemtoRegEX;

	output reg [31:0] Address;
	output reg [31:0] WriteDataMEM;
	output reg [4:0] WriteRegMEM;
	output reg RegWriteMEM, MemReadMEM, MemWriteMEM, MemtoRegMEM;

	initial begin
		Address <= 32'b0;
		WriteDataMEM <= 32'b0;
		WriteRegMEM <= 5'b0;
		RegWriteMEM <= 1'b0;
		MemReadMEM <= 1'b0;
		MemWriteMEM <= 1'b0;
		MemtoRegMEM <= 1'b0;
	end

	always @(posedge clk) begin
		if (reset) begin
			Address <= 32'b0;
			WriteDataMEM <= 32'b0;
			WriteRegMEM <= 5'b0;
			RegWriteMEM <= 1'b0;
			MemReadMEM <= 1'b0;
			MemWriteMEM <= 1'b0;
			MemtoRegMEM <= 1'b0;
		end
		else begin
			Address <= ALUResult;
			WriteDataMEM <= WriteDataEX;
			WriteRegMEM <= WriteRegEX;
			RegWriteMEM <= RegWriteEX;
			MemReadMEM <= MemReadEX;
			MemWriteMEM <= MemWriteEX;
			MemtoRegMEM <= MemtoRegEX;
		end
	end
endmodule
`endif
