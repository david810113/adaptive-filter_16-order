`timescale 1ns/1ps
`define CYCLE 100
`define sck_time 81920
`define cs_time 163833
module test_bench ();

//**************************** wire & reg**********************//
initial $display("//***************************************");
initial $display("//==top input : clk,  mosi, sck, cs, rstn");
initial $display("//==top output :  miso");
initial $display("//***************************************");
reg clk;
reg rstn;
reg sck;
reg mosi;
reg cs;
wire miso;
reg [13:0]index_2;
//**************************** module **********************//
initial $display("===module : top_all");
top_all top_all(.clk(clk),
		.rstn(rstn),
		.sck(sck),
		.mosi(mosi),
		.cs(cs),
		.miso(miso)
);

//**************************** clock gen **********************//
initial
begin
	$display("===starting generating clk");
	force clk = 1'b0;
	forever #(`CYCLE/2) force clk = ~clk;
end
//**************************** initial and wavegen **********************//
initial 
begin
	$display("===starting dump waveform");
	$dumpfile("top_all.vcd");
	$dumpvars(0,top_all);
end

//**************************** main **********************//
initial

begin

	force clk = 1'b0;
	force rstn = 1'b0;
	force sck = 1'b0;
	force mosi = 1'b0;
	force cs = 1'b0;


	$display("===reset");
	reset;

	#1_000;
	$display("===starting sending data");

	for(index_2 = 14'd1355; index_2 < 14'd2048; index_2 = index_2 + 14'd20)
	begin 
	$display("send : 0x%h, 0x%h" , index_2, index_2 + 14'd1);
	send_data(index_2, index_2 + 14'd1); 
	end


	$display("===all done");
	#100000 $finish;
end




//*******************************task reset******************//
task reset;
begin
	force rstn = 1'b1;
	#1_000;
	force rstn = 1'b0;
	#1_000;
	force rstn = 1'b1;
	#1_000;
end
endtask

//****************************task send_data_2*****************//
task send_data_2;
input [13:0] tmp_in;
reg [13:0] index;
begin
	force cs = 1'b0;
	#`cs_time;
	for (index = 14'd0; index < 14'd14; index = index + 14'd1)
	begin	
		force sck = 1'b0;
		force mosi = tmp_in[14'd13-index];
		#`sck_time;
		force sck = 1'b1;
		#`sck_time;		
		force sck = 1'b0;
		release mosi;
	end
	#`cs_time;
	force cs = 1'b1;
	#`cs_time;
end
endtask

//****************************task send_data*****************//
task send_data;
input [13:0] AD_1;
input [13:0] AD_2;

begin
	send_data_2 (14'h0fff);
	send_data_2 (AD_1); //(tmp_in_ad1_msb)
	send_data_2 (AD_2); //(tmp_in_ad1_lsb)

end
endtask





endmodule













