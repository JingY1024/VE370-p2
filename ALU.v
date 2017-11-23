`ifndef _alu
`define _alu
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:44:26 11/14/2017
// Design Name:
// Module Name:    ALU
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
module ALU(ReadData1, ReadData2, ALUcontrol, ALUresult);
	input [31:0] ReadData1;
	input [31:0] ReadData2;
	input [3:0] ALUcontrol;
	output reg [31:0] ALUresult;

always @(ALUcontrol or ReadData1 or ReadData2)
	begin
		if(ALUcontrol==4'b0000)//add,addi,lw,sw
			ALUresult<=ReadData1+ReadData2;
		else if (ALUcontrol==4'b0001)//sub,beq,bne
			ALUresult<=ReadData1-ReadData2;
		else if (ALUcontrol==4'b0010)//and,andi;
			ALUresult<=ReadData1&ReadData2;
		else if (ALUcontrol==4'b0011)//or
			ALUresult<=ReadData1|ReadData2;
		else if (ALUcontrol==4'b0100)//slt
			ALUresult<=ReadData1<ReadData2;
		else//jump
			ALUresult<=0;
	end
endmodule
`endif
