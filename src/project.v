/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_SUMADOR (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire S1, C1, S2;
  
    C_XOR U1 (.OUT(S1), .A(ui_in[0]), .B(ui_in[1]));
    C_AND U2 (.OUT(C1), .A(ui_in[0]), .B(ui_in[1]));
    C_XOR U3 (.OUT(uo_out[0]), .A(S1), .B(ui_in[2]));
    C_AND U4 (.OUT(S2), .A(S1), .B(ui_in[2]));
    C_XOR U5 (.OUT(uo_out[1]), .A(S2), .B(C1));


    assign uo_out [7:2] = 6'b0;	// Las salidas que NO estan dedicadas se mandan a 0 (Son 6 salidas que no se usan para este caso)
    assign uo_out [7:0] = 8'b0;	// Las I/O que no se usan se mandan a 0 (en este caso son 8 I/O)
    assign uo_out [7:0] = 8'b0	// Las I/O que no se usan se mandan a 0 (esn este caso son 8 salidas)

  // List all unused inputs to prevent warnings
        wire _unused - &[ena, clk, rst_n, iu_in [7:3], uio_in [7:0], 1b0];

endmodule
