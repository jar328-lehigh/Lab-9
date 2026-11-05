`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 03:47:34 PM
// Design Name: 
// Module Name: rom_tb
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

module rom_tb;

    parameter DATA_W = 4;
    parameter ADDR_W = 3;
    parameter SIZE   = 8;

    reg clk;
    reg  [ADDR_W-1:0] rom_addr;
    wire [DATA_W-1:0] rom_data;

    integer i;

    // Instantiate ROM
    rom #(
        .DATA_W(DATA_W),
        .ADDR_W(ADDR_W),
        .SIZE(SIZE)
    ) uut (
        .i_clk(clk),
        .i_rom_addr(rom_addr),
        .o_rom_data(rom_data)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rom_addr = 0;

        #20;

        for (i = 0; i < SIZE; i = i + 1) begin
            @(posedge clk);
            rom_addr <= i[ADDR_W-1:0];
            @(posedge clk);
            $display("Time: %0t ns | ROM Address: %0d (0b%03b) => Data Out: 0x%h (0b%04b)", 
                     $time, rom_addr, rom_addr, rom_data, rom_data);
        end

        #20;
        $finish;
    end

endmodule
