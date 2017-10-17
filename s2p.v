`timescale 1ns/1ps
module s2p (mosi, sck, cs, rstn, clk, buffer_2, buffer_3, reff, head_flag);
input mosi, sck, cs, rstn, clk;
output reg [13:0] buffer_2, buffer_3;
output reg[13:0] reff;
output reg head_flag;
reg [13:0]ad_tmp,ad_1,ad_2;
reg [2:0] counter;
wire counter_1, counter_2,valid;   
       
                    
 always@ (posedge sck or negedge rstn)
    begin
    if (rstn == 1'b0)
        ad_tmp <= #2 14'd0;
    else
        ad_tmp[13:0] <= #2 {ad_tmp[12:0],mosi};
    end

 
  always@ (posedge cs or negedge rstn)
    begin
    if (rstn == 1'b0)
        head_flag <= #2  1'b0;
    else if (ad_tmp[13:0]==14'h0fff)
	    head_flag <= #2  1'b0;
 	else 
        head_flag <= #2  1'b1;
   
	end
assign valid = head_flag & cs;

    always@ (posedge valid or negedge rstn)
    begin
    if (rstn == 1'b0)
        counter <= #2  8'd0;
    else if (counter == 8'd2)
        counter <= #2  8'd0;
    else if (head_flag == 1'b1)
             counter <= #1  counter + 8'd1;
    else counter <= #2  counter;
    end  
reg valid_d,valid_d2;  
always@(posedge clk or negedge rstn)
	begin
		if(rstn== 1'b0)
			valid_d <= #2 1'd0;
		else
			valid_d <= #2 valid;
	end
always@(posedge clk or negedge rstn)
	begin
		if(rstn== 1'b0)
			valid_d2 <= #2 1'd0;
		else
			valid_d2 <= #2 valid_d;
	end


 
assign counter_1 = valid_d2 & (counter == 8'd1) ? 1'b1 : 1'b0;
assign counter_2 = valid_d2 & (counter == 8'd2) ? 1'b1 : 1'b0;  


always@(posedge clk or negedge rstn)
	begin
		if(rstn== 1'b0)
			ad_1 <= #2 14'd0;
		else if(counter_1 == 1'b1)
			ad_1 <= #2 ad_tmp;
		else
			ad_1 <= #2 ad_1;
	end
always@(posedge clk or negedge rstn)
	begin
		if(rstn== 1'b0)
			ad_2 <= #2 14'd0;
		else if(counter_2 == 1'b1)
			ad_2 <= #2 ad_tmp;
		else
			ad_2 <= #2 ad_2;
	end	

always@(negedge head_flag or negedge rstn)
	begin
		if(rstn==1'b0)
		buffer_2 <= #2 14'd0;
		else
		buffer_2 <= #2 ad_1;
	end	
	
always@(negedge head_flag or negedge rstn)
	begin
		if(rstn==1'b0)
		buffer_3 <= #2 14'd0;
		else
		buffer_3 <= #2 ad_2;
	end	
		
always@(negedge head_flag or negedge rstn)
	begin
		if(rstn==1'b0)
		reff <= #2 14'd0;
		else
		reff[13:0] <= #2 {1'b0,(buffer_2[13:1] + buffer_3[13:1])};
	end	
	
	
endmodule
	
	
	
	
	
	
	
	
	
