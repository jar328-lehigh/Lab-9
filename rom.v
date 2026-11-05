`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 03:46:32 PM
// Design Name: 
// Module Name: rom
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


module rom #(
    parameter DATA_W = 4,
    parameter ADDR_W = 3,
    parameter SIZE   = 8
)(
    input  wire i_clk,
    input  wire [ADDR_W-1:0] i_rom_addr,
    output reg  [DATA_W-1:0] o_rom_data
);

    reg [DATA_W-1:0] rom_array [0:SIZE-1];

    initial begin
        $readmemh("rom.txt", rom_array);
    end

    always @(posedge i_clk) begin
        o_rom_data <= rom_array[i_rom_addr];
    end

endmodule
