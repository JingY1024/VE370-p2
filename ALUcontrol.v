`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:48:20 11/14/2017 
// Design Name: 
// Module Name:    ALUcontrol 
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
module ALUcontrol(funct,ALUOp,ALUcontrol);
	input [5:0] funct;
	input [2:0] ALUOp;
	output reg [3:0] ALUcontrol;
	always@(funct or ALUOp)
		begin
			if (ALUOp==3'b010 && funct==6'b100000) ALUcontrol<=4'b0000; //add
			else if (ALUOp==3'b010 && funct==6'b100010) ALUcontrol<=4'b0001; //sub
			else if (ALUOp==3'b010 && funct==6'b100100) ALUcontrol<=4'b0010; //and
			else if (ALUOp==3'b010 && funct==6'b100101) ALUcontrol<=4'b0011; //or
			else if (ALUOp==3'b010 && funct==6'b101010) ALUcontrol<=4'b0100; //slt
			else if (ALUOp==3'b000) ALUcontrol<=4'b0000; //lw or sw
			//else if (ALUOp==3'b001) ALUcontrol<=4'b0001; //beq or bne
			else if (ALUOp==3'b011) ALUcontrol<=4'b0000; //addi
			else if (ALUOp==3'b100) ALUcontrol<=4'b0010; //andi
			//else ALUcontrol<=4'b0100; //j
		end
endmodule
