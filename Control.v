`ifndef _control
`define _control
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:37:59 11/15/2017
// Design Name:
// Module Name:    Control
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
module Control(Instruction, RegDst, RegWrite, MemRead,
			MemtoReg, MemWrite, ALUSrc, ALUOp
);

	input [5:0] Instruction;
	output reg RegDst, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
	output reg [2:0] ALUOp;

	initial begin
		RegDst 	<= 0;
		MemRead 	<= 0;
		MemtoReg <= 0;
		MemWrite <= 0;
		ALUSrc 	<= 0;
		RegWrite <= 0;
		ALUOp 	<= 3'b000;
	end

	always @ (Instruction) begin
		// and or add slt sub
		if (Instruction == 6'b000000) begin
			RegDst 	<= 1;
			MemRead 	<= 0;
			MemtoReg <= 0;
			MemWrite <= 0;
			ALUSrc 	<= 0;
			RegWrite <= 1;
			ALUOp 	<= 3'b010;
		end

		// addi
		else if (Instruction == 6'b001000) begin
			RegDst 	<= 0;
			MemRead 	<= 0;
			MemtoReg <= 0;
			MemWrite <= 0;
			ALUSrc 	<= 1;
			RegWrite <= 1;
			ALUOp 	<= 3'b011;
		end

		//andi
		else if (Instruction == 6'b001100) begin
			RegDst 	<= 0;
			MemRead 	<= 0;
			MemtoReg <= 0;
			MemWrite <= 0;
			ALUSrc 	<= 1;
			RegWrite <= 1;
			ALUOp 	<= 3'b100;
		end

		// lw
		else if (Instruction == 6'b100011) begin
			RegDst 	<= 0;
			MemRead 	<= 1;
			MemtoReg <= 1;
			MemWrite <= 0;
			ALUSrc 	<= 1;
			RegWrite <= 1;
			ALUOp 	<= 3'b000;
		end

		// sw
		else if (Instruction == 6'b101011) begin
			RegDst 	<= 0;
			MemRead 	<= 0;
			MemtoReg <= 0;
			MemWrite <= 1;
			ALUSrc 	<= 1;
			RegWrite <= 0;
			ALUOp 	<= 3'b000;
		end
		else begin
			RegDst 	<= 0;
			MemRead 	<= 0;
			MemtoReg <= 0;
			MemWrite <= 0;
			ALUSrc 	<= 0;
			RegWrite <= 0;
			ALUOp 	<= 3'b000;
		end
	end

endmodule
`endif
