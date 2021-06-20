`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:54:36 06/15/2021 
// Design Name: 
// Module Name:    bmul 
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
module bmul(
    input signed [15:0] m,
    input signed [14+2:0] q,
    output reg signed[31:0] p
    );
	 
	 wire signed [14+1:0]q_in;
	 
	 csdigit csd(.a({1'b0,q[14],q[14:0]}),.c(q_in));
	 
//wire [5:0]count;
//reg signed [7:0]a;
//assign count = 16;
reg [15:0]mn;
 
integer i;
reg qn1;
reg [1:0]t;
 
 initial begin 
 p = 32'h0;
 qn1 = 0;
 end
 
always @(m,q_in,p)
begin 
//qn1 = 0;
//a = 8'b0;
 for(i=0;i<16;i=i+1)
begin
t = {q_in[i],qn1};
mn = -m;
case(t)
2'b10 :begin
        p[31:16] = p[31:16] +  mn;
        p = p>>1;
        p[31] = p[30];
        qn1 = q_in[i];
        end
2'b01 : begin
       p[31:16] = p[31:16] +  m;
       p = p>>1;
       p[31] = p[30];
       qn1 = q_in[i];
		 end
2'b00,2'b11:begin
        p = p>>1;
        p[31] = p[30];
        qn1 = q_in[i];
       end
default : begin end
endcase 
/*a = a>>1;
a[7] = a[6];
qn1 = q[i];*/
end
if(q_in==16'h8000) //2power16/2 = (8000)base16 its 2s complement is also same thats y we need to add this
begin 
p = -p;
end
end

endmodule
