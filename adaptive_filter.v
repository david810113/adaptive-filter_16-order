`timescale 1ns/1ps
module adaptive_filter(adap_filter_state, rstn, clk, reff_0, reff_1, reff_2, reff_3, reff_4, reff_5, reff_6, reff_7, reff_8, reff_9, reff_10, reff_11, reff_12, reff_13, reff_14, reff_15, buffer_in_0, buffer_in_1, buffer_in_2, buffer_in_3, buffer_in_4, buffer_in_5, buffer_in_6, buffer_in_7, buffer_in_8, buffer_in_9, buffer_in_10, buffer_in_11, buffer_in_12, buffer_in_13, buffer_in_14, buffer_in_15, buffer_in_16, weight_in_0, weight_in_1, weight_in_2, weight_in_3, weight_in_4, weight_in_5, weight_in_6, weight_in_7, weight_in_8, weight_in_9, weight_in_10, weight_in_11, weight_in_12, weight_in_13, weight_in_14, weight_in_15, d, e);
input rstn, clk, adap_filter_state;

input [13:0] reff_0;
input [13:0] reff_1;
input [13:0] reff_2;
input [13:0] reff_3;
input [13:0] reff_4;
input [13:0] reff_5;
input [13:0] reff_6;
input [13:0] reff_7;
input [13:0] reff_8;
input [13:0] reff_9;
input [13:0] reff_10;
input [13:0] reff_11;
input [13:0] reff_12;
input [13:0] reff_13;
input [13:0] reff_14;
input [13:0] reff_15;

input [13:0] buffer_in_0;
input [13:0] buffer_in_1;
input [13:0] buffer_in_2;
input [13:0] buffer_in_3;
input [13:0] buffer_in_4;
input [13:0] buffer_in_5;
input [13:0] buffer_in_6;
input [13:0] buffer_in_7;
input [13:0] buffer_in_8;
input [13:0] buffer_in_9;
input [13:0] buffer_in_10;
input [13:0] buffer_in_11;
input [13:0] buffer_in_12;
input [13:0] buffer_in_13;
input [13:0] buffer_in_14;
input [13:0] buffer_in_15;
input [13:0] buffer_in_16;

input [31:0] weight_in_0;
input [31:0] weight_in_1;
input [31:0] weight_in_2;
input [31:0] weight_in_3;
input [31:0] weight_in_4;
input [31:0] weight_in_5;
input [31:0] weight_in_6;
input [31:0] weight_in_7;
input [31:0] weight_in_8;
input [31:0] weight_in_9;
input [31:0] weight_in_10;
input [31:0] weight_in_11;
input [31:0] weight_in_12;
input [31:0] weight_in_13;
input [31:0] weight_in_14;
input [31:0] weight_in_15;
/*
wire [13:0] Shift_out_0;
wire [13:0] Shift_out_1;
wire [13:0] Shift_out_2;
wire [13:0] Shift_out_3;
wire [13:0] Shift_out_4;
wire [13:0] Shift_out_5;
wire [13:0] Shift_out_6;
wire [13:0] Shift_out_7;
wire [13:0] Shift_out_8;
wire [13:0] Shift_out_9;
wire [13:0] Shift_out_10;
wire [13:0] Shift_out_11;
wire [13:0] Shift_out_12;
wire [13:0] Shift_out_13;
wire [13:0] Shift_out_14;
wire [13:0] Shift_out_15;
*/
output reg [10:0] e;   
output reg [13:0] d ;   
//parameter usize = 25;
reg [31:0] dreg;
reg [31:0] rreg;
reg [4:0]counter;
//reg [4:0]counter1;
//********************** Counter ***********************//
always@(negedge clk or negedge rstn)
begin
if (rstn == 0)
	counter <= #2   5'd0;
else if (adap_filter_state == 1'b0 | counter == 5'd15)
	counter <= #2   5'd0;	
else
	counter <= #2  counter + 1'd1;
end



wire flag_15;
wire flag_n;
assign flag_15 = (counter == 5'd15) ? 1'd1 : 1'd0;
assign flag_n = (buffer_in_15 > 32'b0 )?1'd1 :1'd0;
/*
always@(posedge flag_15 or negedge rstn)
begin
if (rstn == 0)
	counter1 <= #2   5'd0;
else if (counter1<15)
	counter1 <= #2  counter1 + 1'd1;	
else
	counter1 <= #2  counter1;
end
*/




//********************** MUX ***********************//	
wire [13:0] reff;
wire [31:0] weight_in;
	
assign reff =   {14{(counter == 5'd0)}} & buffer_in_15|
		{14{(counter == 5'd1)}} & buffer_in_14 |
		{14{(counter == 5'd2)}} & buffer_in_13 |		
		{14{(counter == 5'd3)}} & buffer_in_12 |
		{14{(counter == 5'd4)}} & buffer_in_11 |
		{14{(counter == 5'd5)}} & buffer_in_10 |		
		{14{(counter == 5'd6)}} & buffer_in_9 |	
		{14{(counter == 5'd7)}} & buffer_in_8 |
		{14{(counter == 5'd8)}} & buffer_in_7 |		
		{14{(counter == 5'd9)}} & buffer_in_6|
		{14{(counter == 5'd10)}} & buffer_in_5 |
		{14{(counter == 5'd11)}} & buffer_in_4 |		
		{14{(counter == 5'd12)}} & buffer_in_3 |			
		{14{(counter == 5'd13)}} & buffer_in_2 |
		{14{(counter == 5'd14)}} & buffer_in_1 |
		{14{(counter == 5'd15)}} & buffer_in_0 ;
		
assign weight_in =      {32{(counter == 5'd0)}} & weight_in_15 |
			{32{(counter == 5'd1)}} & weight_in_14 |
			{32{(counter == 5'd2)}} & weight_in_13 |		
			{32{(counter == 5'd3)}} & weight_in_12 |
			{32{(counter == 5'd4)}} & weight_in_11 |
			{32{(counter == 5'd5)}} & weight_in_10 |		
			{32{(counter == 5'd6)}} & weight_in_9 |	
			{32{(counter == 5'd7)}} & weight_in_8 |
			{32{(counter == 5'd8)}} & weight_in_7 |		
			{32{(counter == 5'd9)}} & weight_in_6 |
			{32{(counter == 5'd10)}} & weight_in_5 |
			{32{(counter == 5'd11)}} & weight_in_4 |		
			{32{(counter == 5'd12)}} & weight_in_3 |			
			{32{(counter == 5'd13)}} & weight_in_2 |
			{32{(counter == 5'd14)}} & weight_in_1 |		
			{32{(counter == 5'd15)}} & weight_in_0 ;		

//********************** DSP ***********************//
// 確認dsp_result是否會歸零,其餘時脈OK----------------------
reg [31:0] multiple;
//reg [31:0] dsp_result;
wire counter_flag;
//reg [31:0] sum;
reg [31:0] nref;

//assign nref = {17'd0, reff} * {17'd0, reff};
//assign sum = rreg + nref ;
//assign multiple = weight_in * {17'd0, reff};
//assign dsp_result = dreg + multiple[31:5];
assign counter_flag = ~(&counter);//0~14


always@(posedge clk or negedge rstn)
begin
if (rstn == 0)
	multiple <= #2  32'd0;
else if (adap_filter_state == 1'b0)
	multiple <= #2  32'd0;
else if (counter_flag == 1'd1)
	multiple <= #2  weight_in * {17'd0, reff};
else
	multiple <= #2  multiple;
end
always@(posedge clk or negedge rstn)
begin
if (rstn == 0)
	dreg <= #2  32'd0;
else if (adap_filter_state == 1'b1&&counter <= 5'd15)
	dreg <= #2  dreg + multiple[31:5];
else if (adap_filter_state == 1'b0)
	dreg <= #2  32'd0;
else
	dreg <= #2  dreg;
end
always@(posedge clk or negedge rstn)
begin
if (rstn == 0)
	nref <= #2  32'd0;
else if (adap_filter_state == 1'b0)
	nref <= #2  32'd0;
else if (counter_flag == 1'd1)
	nref <= #2 {17'd0, reff} * {17'd0, reff};
else
	nref <= #2  nref;
end
always@(posedge clk or negedge rstn)
begin
if (rstn == 0)
	rreg <= #2  32'd0;
else if (adap_filter_state == 1'b0)
	rreg <= #2  32'd0;
else if (adap_filter_state == 1'b1&&counter <= 5'd15)
	rreg <= #2  rreg + nref ;
else
	rreg <= #2  rreg;
end

/*

always@(posedge clk or negedge rstn)
begin
if (rstn == 0)
	rreg <= #2  14'd0;
else if (adap_filter_state == 1'b0)
	rreg <= #2  14'd0;
else if (counter_flag == 1'd1)
	rreg <= #2  sum;
else
	rreg <= #2  rreg;
end
*/
/*
always@(posedge clk or negedge rstn)
begin
if (rstn == 0)
	dreg <= #2  32'd0;
else if (adap_filter_state == 1'b0)
	dreg <= #2  32'd0;
else if (counter_flag == 1'd1)
	dreg <= #2  dsp_result;
else
	dreg <= #2  dreg;
end
*/
/*
always@(posedge clk or negedge rstn)
begin
if (rstn == 0)
	dreg <= #2  14'd000;
else if (adap_filter_state == 1'b0)
	dreg <= #2  14'd000;
else if (counter == 5'd0)
	dreg <= #2  dreg + weight_in_0 * reff_0;
else if (counter == 5'd1)
	dreg <= #2  dreg + Shift_out_1;
else if (counter == 5'd2)
	dreg <= #2  dreg + Shift_out_2;
else if (counter == 5'd3)
	dreg <= #2  dreg + Shift_out_3;
else if (counter == 5'd4)
	dreg <= #2  dreg + Shift_out_4;
else if (counter == 5'd5)
	dreg <= #2  dreg + Shift_out_5;
else if (counter == 5'd6)
	dreg <= #2  dreg + Shift_out_6;
else if (counter == 5'd7)
	dreg <= #2  dreg + Shift_out_7;
else if (counter == 5'd8)
	dreg <= #2  dreg + Shift_out_8;
else if (counter == 5'd9)
	dreg <= #2  dreg + Shift_out_9;
else if (counter == 5'd10)
	dreg <= #2  dreg + Shift_out_10;
else if (counter == 5'd11)
	dreg <= #2  dreg + Shift_out_11;
else if (counter == 5'd12)
	dreg <= #2  dreg + Shift_out_12;
else if (counter == 5'd13)
	dreg <= #2  dreg + Shift_out_13;
else if (counter == 5'd14)
	dreg <= #2  dreg + Shift_out_14;
else
	dreg <= #2  dreg;
end    
*/
/*
always@(posedge clk or negedge rstn)
begin
if(rstn==0)
	n <= 14'd0;	
else if (counter == 5'd15)
	n <= #2  sum  ;
else
	n <= #2 n;
end
*/
always@(posedge clk or negedge rstn)
begin
if(rstn==0)
	d <= 14'd0;	
else if (counter == 5'd15&&flag_15==1&&flag_n==1)
	d <= #2  dreg/rreg;
else if (counter == 5'd15&&flag_15==1&&flag_n==0)
	d <= #2  dreg;

else
	d <= #2 d;
end

always@(negedge clk or negedge rstn)
begin
if (rstn == 0)
	e <= #2  14'd0;
else if (adap_filter_state == 1'b1 && counter == 5'd15 && d[13] == 0)
	e <= #2  buffer_in_15 - d;	
else if (adap_filter_state == 1'b1 && counter == 5'd15 && d[13] == 1)
	e <= #2  buffer_in_15 + d;	
else
	e <= #2  e;

end


//********************** Multiple ***********************//
/*
wire [44:0] mux1_0;
wire [44:0] mux1_1;
wire [44:0] mux1_2;
wire [44:0] mux1_3;
wire [44:0] mux1_4;
wire [44:0] mux1_5;
wire [44:0] mux1_6;
wire [44:0] mux1_7;
wire [44:0] mux1_8;
wire [44:0] mux1_9;
wire [44:0] mux1_10;
wire [44:0] mux1_11;
wire [44:0] mux1_12;
wire [44:0] mux1_13;
wire [44:0] mux1_14;
wire [44:0] mux1_15;
assign mux1_0 = weight_in_0 * reff_0;
assign mux1_1 = weight_in_1 * reff_1;
assign mux1_2 = weight_in_2 * reff_2;
assign mux1_3 = weight_in_3 * reff_3;
assign mux1_4 = weight_in_4 * reff_4;
assign mux1_5 = weight_in_5 * reff_5;
assign mux1_6 = weight_in_6 * reff_6;
assign mux1_7 = weight_in_7 * reff_7;
assign mux1_8 = weight_in_8 * reff_8;
assign mux1_9 = weight_in_9 * reff_9;
assign mux1_10 = weight_in_10 * reff_10;
assign mux1_11 = weight_in_11 * reff_11;
assign mux1_12 = weight_in_12 * reff_12;
assign mux1_13 = weight_in_13 * reff_13;
assign mux1_14 = weight_in_14 * reff_14;
assign mux1_15 = weight_in_15 * reff_15;


Shift Shift_0(.rstn(rstn), .clk(clk), .in(mux1_0), .out(Shift_out_0));
Shift Shift_1(.rstn(rstn), .clk(clk), .in(mux1_1), .out(Shift_out_1));
Shift Shift_2(.rstn(rstn), .clk(clk), .in(mux1_2), .out(Shift_out_2));
Shift Shift_3(.rstn(rstn), .clk(clk), .in(mux1_3), .out(Shift_out_3));
Shift Shift_4(.rstn(rstn), .clk(clk), .in(mux1_4), .out(Shift_out_4));
Shift Shift_5(.rstn(rstn), .clk(clk), .in(mux1_5), .out(Shift_out_5));
Shift Shift_6(.rstn(rstn), .clk(clk), .in(mux1_6), .out(Shift_out_6));
Shift Shift_7(.rstn(rstn), .clk(clk), .in(mux1_7), .out(Shift_out_7));
Shift Shift_8(.rstn(rstn), .clk(clk), .in(mux1_8), .out(Shift_out_8));
Shift Shift_9(.rstn(rstn), .clk(clk), .in(mux1_9), .out(Shift_out_9));
Shift Shift_10(.rstn(rstn), .clk(clk), .in(mux1_10), .out(Shift_out_10));
Shift Shift_11(.rstn(rstn), .clk(clk), .in(mux1_11), .out(Shift_out_11));
Shift Shift_12(.rstn(rstn), .clk(clk), .in(mux1_12), .out(Shift_out_12));
Shift Shift_13(.rstn(rstn), .clk(clk), .in(mux1_13), .out(Shift_out_13));
Shift Shift_14(.rstn(rstn), .clk(clk), .in(mux1_14), .out(Shift_out_14));
Shift Shift_15(.rstn(rstn), .clk(clk), .in(mux1_15), .out(Shift_out_15));
*/

/*
Shift Shift_0(.rstn(rstn), .clk(clk), .in(weight_in_0 * reff_0), .out(Shift_out_0));
Shift Shift_1(.rstn(rstn), .clk(clk), .in(weight_in_1 * reff_1), .out(Shift_out_1));
Shift Shift_2(.rstn(rstn), .clk(clk), .in(weight_in_2 * reff_2), .out(Shift_out_2));
Shift Shift_3(.rstn(rstn), .clk(clk), .in(weight_in_3 * reff_3), .out(Shift_out_3));
Shift Shift_4(.rstn(rstn), .clk(clk), .in(weight_in_4 * reff_4), .out(Shift_out_4));
Shift Shift_5(.rstn(rstn), .clk(clk), .in(weight_in_5 * reff_5), .out(Shift_out_5));
Shift Shift_6(.rstn(rstn), .clk(clk), .in(weight_in_6 * reff_6), .out(Shift_out_6));
Shift Shift_7(.rstn(rstn), .clk(clk), .in(weight_in_7 * reff_7), .out(Shift_out_7));
Shift Shift_8(.rstn(rstn), .clk(clk), .in(weight_in_8 * reff_8), .out(Shift_out_8));
Shift Shift_9(.rstn(rstn), .clk(clk), .in(weight_in_9 * reff_9), .out(Shift_out_9));
Shift Shift_10(.rstn(rstn), .clk(clk), .in(weight_in_10 * reff_10), .out(Shift_out_10));
Shift Shift_11(.rstn(rstn), .clk(clk), .in(weight_in_11 * reff_11), .out(Shift_out_11));
Shift Shift_12(.rstn(rstn), .clk(clk), .in(weight_in_12 * reff_12), .out(Shift_out_12));
Shift Shift_13(.rstn(rstn), .clk(clk), .in(weight_in_13 * reff_13), .out(Shift_out_13));
Shift Shift_14(.rstn(rstn), .clk(clk), .in(weight_in_14 * reff_14), .out(Shift_out_14));
Shift Shift_15(.rstn(rstn), .clk(clk), .in(weight_in_15 * reff_15), .out(Shift_out_15));
*/

    
endmodule

