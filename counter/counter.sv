module counter(
input logic [4:0] data,
input logic load,enable,clk,rst_,
output logic [4:0]count
);
reg [4:0] load_data;
always_ff@(posedge clk,negedge rst_)
begin : always_begin
//load_data=0;
if(~rst_)
    load_data=0;
if (enable)
begin : enable
    load_data = load_data+1;
    end : enable
if (load)
            load_data=data;  
            
end:always_begin

assign count = load_data;
endmodule
