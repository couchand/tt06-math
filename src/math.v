/*
 * Copyright (c) 2024 Andrew Dona-Couch
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module math #(
    parameter BITS = 64
) (
    input  wire       clk,
    input  wire       rst_n,

    input  wire [7:0] data_in,
    output wire [7:0] data_out,

    input  wire [7:0] op_in
);

  reg [BITS-1:0] accum;

  assign data_out = accum[7:0];

  always @(posedge clk) begin
    if (!rst_n) begin
      accum <= 0;
    end else begin
      case (op_in)
        8'h00: ;
        8'h01: accum <= 0;
        8'h02: accum <= {accum[BITS-1:8], data_in};
        8'h03: accum <= accum + {{BITS-9{1'b0}}, data_in};
        8'h04: accum <= accum << data_in;
        8'h05: accum <= accum >> data_in;
        default: ;
      endcase
    end
  end

endmodule
