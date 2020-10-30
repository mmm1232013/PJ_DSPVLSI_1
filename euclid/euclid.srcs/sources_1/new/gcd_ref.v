`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/01 11:43:28
// Design Name: 
// Module Name: gcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module gcd(
input [31:0]OPA,
input [31:0]OPB,
input START,
input RESETn,
input CLK,
output reg DONE,
output reg [31:0]RESULT
    );

wire start0;
reg start_reg0;
reg start_reg1;
reg [31:0]TmpMax;
reg [31:0]TmpMin;
reg BUSY;
assign start0 = start_reg0 & (~start_reg1);
always@(posedge CLK)
    begin
        start_reg0<=START;
        start_reg1<=start_reg0;
    end
always@(posedge CLK)
    if(!RESETn)
        begin
            TmpMax<=0;
            TmpMin<=0;
            DONE <= 0;
            RESULT <= 0;
            BUSY <= 0;
         end
     else if(start0)
        begin
            DONE <= 0;
            RESULT <= 0;
            BUSY <=1;
            if(OPA >= OPB)
                begin
                    TmpMax <= OPA;
                    TmpMin <= OPB;
                end
            else
                begin
                    TmpMax <= OPB;
                    TmpMin <= OPA;
                end
         end
      else if(BUSY == 1)
        begin
            if(TmpMin != 0)
                begin
                TmpMin <= TmpMax % TmpMin;
                TmpMax <= TmpMin;
                end                
             else
                begin
                    RESULT <= TmpMax;
                    BUSY <= 0;
                    DONE <= 1;
                end   
         end        
endmodule