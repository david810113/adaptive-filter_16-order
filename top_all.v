`timescale 1ns/1ps

module top_all(clk, miso, mosi, sck, cs, rstn);
input clk, mosi, sck, cs, rstn; 
output miso;

wire [13:0] buffer_2, buffer_3, reff, dn;   

s2p s2p_0 (.mosi(mosi),
           .sck(sck),
           .cs(cs),
           .rstn(rstn),
           .clk(clk),
           .buffer_2(buffer_2),
           .buffer_3(buffer_3),
           .reff(reff),
           .head_flag(head_flag)        
);   

p2s p2s_0 (.sck(sck),
           .head_flag(head_flag),           
	   .cs(cs),
           .rstn(rstn),
           .clk(clk),  
	   .in_p2s(dn),    
	   .miso(miso)
);   


alog_top alog_top (.rstn(rstn),
		   .clk(clk),
		   .buffer_2(buffer_2),
		   .buffer_3(buffer_3),
                   .reff(reff),
                   .head_flag(head_flag),
		   .dout(dn)
);
       
endmodule
