`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 03:43:21 PM
// Design Name: 
// Module Name: ram
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


module ram #(
    parameter DATA_W = 8,
    parameter ADDR_W = 3,
    parameter SIZE   = 8
)(
    input  wire i_clk,
    input  wire i_rst,
    input  wire i_write_en,
    input  wire [ADDR_W-1:0] i_addr,
    input  wire [DATA_W-1:0] i_write_data,
    output reg  [DATA_W-1:0] o_read_data
);

    reg [DATA_W-1:0] mem [0:SIZE-1];
    integer i;

    always @(posedge i_clk) begin
        if (i_rst) begin
            for (i = 0; i < SIZE; i = i + 1) begin
                mem[i] <= {DATA_W{1'b0}};
            end
            o_read_data <= {DATA_W{1'b0}};
        end else begin
            if (i_write_en) begin
                mem[i_addr] <= i_write_data;
            end else begin
                o_read_data <= mem[i_addr];
            end
        end
    end

endmodule
