module register(
input logic [7:0] data,
output logic [7:0] out,
input logic clk,
input logic enable,
input logic rst_
);
reg [7:0] reg_out;
always_ff@(posedge clk or negedge rst_)
begin
if(enable==1)
begin
reg_out=data;
end 
else if (rst_==0)
begin
reg_out=0;
end
end
assign out = reg_out;
endmodule
