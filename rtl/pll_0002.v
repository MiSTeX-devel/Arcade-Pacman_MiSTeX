`timescale 1ns/10ps
module  pll_0002(

	// interface 'refclk'
	input wire refclk,

	// interface 'reset'
	input wire rst,

	// interface 'outclk0'
	output wire outclk_0,

	// interface 'outclk1'
	output wire outclk_1,

	// interface 'locked'
	output wire locked
);
`ifdef CYCLONEV
	altera_pll #(
		.fractional_vco_multiplier("true"),
		.reference_clock_frequency("50.0 MHz"),
		.operation_mode("direct"),
		.number_of_clocks(2),
		.output_clock_frequency0("48.648000 MHz"),
		.phase_shift0("0 ps"),
		.duty_cycle0(50),
		.output_clock_frequency1("24.324000 MHz"),
		.phase_shift1("0 ps"),
		.duty_cycle1(50),
		.pll_type("General"),
		.pll_subtype("General")
	) altera_pll_i (
		.rst	(rst),
		.outclk	({outclk_1, outclk_0}),
		.locked	(locked),
		.fboutclk	( ),
		.fbclk	(1'b0),
		.refclk	(refclk)
	);
`else
	ALTPLL #(
		.BANDWIDTH_TYPE("AUTO"),
		.CLK0_DIVIDE_BY(10'd27),   // 48.648 MHz ~= 50 MHz * 26 / 27
		.CLK0_DUTY_CYCLE(6'd50),
		.CLK0_MULTIPLY_BY(10'd26),
		.CLK0_PHASE_SHIFT(1'd0),
		.CLK1_DIVIDE_BY(10'd54),   // 24.324 MHz ~= 50 MHz * 26 / 54
		.CLK1_DUTY_CYCLE(6'd50),
		.CLK1_MULTIPLY_BY(10'd26),
		.CLK1_PHASE_SHIFT(1'd0),
		.COMPENSATE_CLOCK("CLK0"),
		.INCLK0_INPUT_FREQUENCY(15'd20000),
		.OPERATION_MODE("NORMAL")
	) ALTPLL (
		.ARESET(1'd0),
		.CLKENA(5'd31),
		.EXTCLKENA(4'd15),
		.FBIN(1'd1),
		.INCLK(refclk),
		.PFDENA(1'd1),
		.PLLENA(1'd1),
		.CLK({outclk_1, outclk_0}),
		.LOCKED(locked)
	);
`endif
endmodule

