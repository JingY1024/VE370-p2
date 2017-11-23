`timescale 1ns / 1ps

module registers(ReadRegister1, ReadRegister2, WriteRegister, WriteData, 
		RegWrite, ReadData1, ReadData2, 
		clk,rs0,rs1,rs2,rs3,rs4,rs5,rs6,rs7,rt0,rt1,rt2,rt3,rt4,rt5,rt6,rt7,rt8,rt9
);
	input RegWrite, clk;
	input [4:0] ReadRegister1;
	input [4:0] ReadRegister2;
	input [4:0] WriteRegister;
	input [31:0] WriteData;
	output [31:0] ReadData1;
	output [31:0] ReadData2;
	output [31:0] rs0,rs1,rs2,rs3,rs4,rs5,rs6,rs7,rt0,rt1,rt2,rt3,rt4,rt5,rt6,rt7,rt8,rt9;
	//output [31:0] register[0:31];
	reg [31:0]register[0:31];
	integer i;

	initial begin
		for (i = 0; i < 32; i = i + 1)
		begin
			register[i] = 32'b0;
		end
	end

	always @(negedge clk) begin
		if (RegWrite == 1'b1) begin
			register[WriteRegister] <= WriteData;
		end
	end

	assign ReadData1 = register[ReadRegister1];
	assign ReadData2 = register[ReadRegister2];
	//assign registers
	assign rs0=register[16];
	assign rs1=register[17];
	assign rs2=register[18];
	assign rs3=register[19];
	assign rs4=register[20];
	assign rs5=register[21];
	assign rs6=register[22];
	assign rs7=register[23];
	assign rt0=register[8];
	assign rt1=register[9];
	assign rt2=register[10];
	assign rt3=register[11];
	assign rt4=register[12];
	assign rt5=register[13];
	assign rt6=register[14];
	assign rt7=register[15];
	assign rt8=register[24];
	assign rt9=register[25];
endmodule
