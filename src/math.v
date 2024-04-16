/*
 * Copyright (c) 2024 Andrew Dona-Couch
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module math #(
    parameter BITS = 128
) (
    input  wire       clk,
    input  wire       rst_n,

    input  wire [7:0] data_in,
    output wire [7:0] data_out,

    input  wire [7:0] op_in
);

  reg [BITS-1:0] accum0, accum1;
  reg which;

  assign data_out = which == 0 ? accum0[7:0] : accum1[7:0];

  always @(posedge clk) begin
    if (!rst_n) begin
      accum0 <= 0;
      accum1 <= 0;
      which <= 0;
    end else begin
      case (op_in)
        8'h00: ;
        8'h01: which <= ~which;
        8'h02: accum0 <= 0;
        8'h03: accum1 <= 0;
        8'h04: accum0 <= {accum0[BITS-1:8], data_in};
        8'h05: accum1 <= {accum1[BITS-1:8], data_in};
        8'h06: accum0 <= accum0 + data_in;
        8'h07: accum0 <= accum1 + data_in;
        8'h08: accum0 <= accum0 + accum1;
        8'h09: accum1 <= accum0 + accum1;
        8'h0A: accum0 <= accum0 << data_in;
        8'h0B: accum0 <= accum1 << data_in;
        8'h0C: accum0 <= accum0 >> data_in;
        8'h0D: accum0 <= accum1 >> data_in;
      endcase
    end
  end

endmodule
