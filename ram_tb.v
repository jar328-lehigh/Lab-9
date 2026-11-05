`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 03:45:21 PM
// Design Name: 
// Module Name: ram_tb
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


module ram_tb;

    parameter DATA_W = 8;
    parameter ADDR_W = 3;
    parameter SIZE   = 8;

    reg clk;
    reg rst;
    reg write_en;
    reg  [ADDR_W-1:0] addr;
    reg  [DATA_W-1:0] write_data;
    wire [DATA_W-1:0] read_data;

    integer file_handle;
    integer i;

    ram #(
        .DATA_W(DATA_W),
        .ADDR_W(ADDR_W),
        .SIZE(SIZE)
    ) uut (
        .i_clk(clk),
        .i_rst(rst),
        .i_write_en(write_en),
        .i_addr(addr),
        .i_write_data(write_data),
        .o_read_data(read_data)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        write_en = 0;
        addr = 0;
        write_data = 0;

        #20;
        rst = 0;

        for (i = 0; i < SIZE; i = i + 1) begin
            @(posedge clk);
            write_en   <= 1'b1;
            addr       <= i[ADDR_W-1:0];
            write_data <= 8'hA0 + i[7:0];
        end

        @(posedge clk);
        write_en <= 1'b0;

        file_handle = $fopen("ram.txt", "w");
        if (file_handle == 0) begin
            $display("Error: Could not create ram.txt");
            $finish;
        end

        for (i = 0; i < SIZE; i = i + 1) begin
            @(posedge clk);
            addr <= i[ADDR_W-1:0];
            @(posedge clk);
            $fdisplay(file_handle, "Address: %0d | Hex: 0x%02h | Bin: %08b", i, read_data, read_data);
            $display("Read Address: %0d => Data: 0x%02h", i, read_data);
        end

        $fclose(file_handle);
        #20;
        $finish;
    end

endmodule
