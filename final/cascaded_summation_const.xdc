

set_property PACKAGE_PIN E3 [get_ports {SSD_clk}]					
set_property IOSTANDARD LVCMOS33 [get_ports {SSD_clk}]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {SSD_clk}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets CPU/LED_out_OBUF[6]_inst_i_11_n_0]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets CPU/LED_out_OBUF[6]_inst_i_10_n_0]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_6]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_10]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_15]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_19]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_20]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_22]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_37]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_18_n_1]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_22]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_24]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_26]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets  CPU/LED_out_OBUF[6]_inst_i_27]


set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L24N_T3_RS0_15 Sch=A[0]
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=A[1]

set_property PACKAGE_PIN T10 [get_ports {LED_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[6]}]

set_property PACKAGE_PIN R10 [get_ports {LED_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[5]}]

set_property PACKAGE_PIN K16 [get_ports {LED_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[4]}]

set_property PACKAGE_PIN K13 [get_ports {LED_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[3]}]

set_property PACKAGE_PIN P15 [get_ports {LED_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[2]}]

set_property PACKAGE_PIN T11 [get_ports {LED_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[1]}]

set_property PACKAGE_PIN L18 [get_ports {LED_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_out[0]}]


set_property PACKAGE_PIN P14 [get_ports {Anode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode[0]}]

set_property PACKAGE_PIN T14 [get_ports {Anode[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode[1]}]

set_property PACKAGE_PIN K2 [get_ports {Anode[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode[2]}]

set_property PACKAGE_PIN U13 [get_ports {Anode[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode[3]}]


