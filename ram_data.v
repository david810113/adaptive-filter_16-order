`timescale 1ns/1ps
module ram_data (shift_data_state, rstn, clk, in, head_flag, ram_tmp_0, ram_tmp_1, ram_tmp_2, ram_tmp_3, ram_tmp_4, ram_tmp_5, ram_tmp_6, ram_tmp_7, ram_tmp_8, ram_tmp_9, ram_tmp_10, ram_tmp_11, ram_tmp_12, ram_tmp_13, ram_tmp_14, ram_tmp_15,ram_tmp_16);

input rstn, clk, head_flag, shift_data_state;
input [13:0] in;

output reg [13:0] ram_tmp_0;
output reg [13:0] ram_tmp_1;
output reg [13:0] ram_tmp_2;
output reg [13:0] ram_tmp_3;
output reg [13:0] ram_tmp_4;
output reg [13:0] ram_tmp_5;
output reg [13:0] ram_tmp_6;
output reg [13:0] ram_tmp_7;
output reg [13:0] ram_tmp_8;
output reg [13:0] ram_tmp_9;
output reg [13:0] ram_tmp_10;
output reg [13:0] ram_tmp_11;
output reg [13:0] ram_tmp_12;
output reg [13:0] ram_tmp_13;
output reg [13:0] ram_tmp_14;
output reg [13:0] ram_tmp_15;
output reg [13:0] ram_tmp_16;

//********************** Shift Register Storage ***********************//
    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_0 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_0 <= #2  in;
    else
	ram_tmp_0 <= #2  ram_tmp_0;
    end  


    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_1 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_1 <= #2  ram_tmp_0;
    else
	ram_tmp_1 <= #2  ram_tmp_1;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_2 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_2 <= #2  ram_tmp_1;
    else
	ram_tmp_2 <= #2  ram_tmp_2;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_3 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_3 <= #2  ram_tmp_2;
    else
	ram_tmp_3 <= #2  ram_tmp_3;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_4 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_4 <= #2  ram_tmp_3;
    else
	ram_tmp_4 <= #2  ram_tmp_4;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_5 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_5 <= #2  ram_tmp_4;
    else
	ram_tmp_5 <= #2  ram_tmp_5;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_6 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_6 <= #2  ram_tmp_5;
    else
	ram_tmp_6 <= #2  ram_tmp_6;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_7 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_7 <= #2  ram_tmp_6;
    else
	ram_tmp_7 <= #2  ram_tmp_7;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_8 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_8 <= #2  ram_tmp_7;
    else
	ram_tmp_8 <= #2  ram_tmp_8;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_9 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_9 <= #2  ram_tmp_8;
    else
	ram_tmp_9 <= #2  ram_tmp_9;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_10 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_10 <= #2  ram_tmp_9;
    else
	ram_tmp_10 <= #2  ram_tmp_10;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_11 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_11 <= #2  ram_tmp_10;
    else
	ram_tmp_11 <= #2  ram_tmp_11;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_12 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_12 <= #2  ram_tmp_11;
    else
	ram_tmp_12 <= #2  ram_tmp_12;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_13 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_13 <= #2  ram_tmp_12;
    else
	ram_tmp_13 <= #2  ram_tmp_13;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_14 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_14 <= #2  ram_tmp_13;
    else
	ram_tmp_14 <= #2  ram_tmp_14;
    end    

    always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_15 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_15 <= #2  ram_tmp_14;
    else
	ram_tmp_15 <= #2  ram_tmp_15;
    end
	
	always@(posedge clk or negedge rstn)
    begin
    if (rstn == 1'b0)
        ram_tmp_16 <= #2  14'd0;
    else if (shift_data_state == 1'b1)
        ram_tmp_16 <= #2  ram_tmp_15;
    else
	ram_tmp_16 <= #2  ram_tmp_16;
    end

endmodule
