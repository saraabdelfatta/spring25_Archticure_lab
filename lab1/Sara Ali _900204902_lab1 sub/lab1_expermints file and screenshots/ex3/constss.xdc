set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}];

set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { num[0] }]; #IO_L24N_T3_RS0_15 Sch=num[0]
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { num[1] }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=num[1]
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { num[2] }]; #IO_L6N_T0_D08_VREF_14 Sch=num[2]
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { num[3] }]; #IO_L13N_T2_MRCC_14 Sch=num[3]
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { num[4] }]; #IO_L12N_T1_MRCC_14 Sch=num[4]
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { num[5] }]; #IO_L7N_T1_D10_14 Sch=num[5]
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { num[6] }]; #IO_L17N_T2_A13_D29_14 Sch=num[6]
set_property -dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports { num[7] }]; #IO_L5N_T0_D07_14 Sch=num[7]
set_property -dict { PACKAGE_PIN T8    IOSTANDARD LVCMOS18 } [get_ports { num[8] }]; #IO_L24N_T3_34 Sch=num[8]
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS18 } [get_ports { num[9] }]; #IO_25_34 Sch=num[9]
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { num[10] }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=num[10]
set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { num[11] }]; #IO_L23P_T3_A03_D19_14 Sch=num[11]
set_property -dict { PACKAGE_PIN H6    IOSTANDARD LVCMOS33 } [get_ports { num[12] }]; #IO_L24P_T3_35 Sch=num[12]
#set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { num[13] }]; #IO_L20P_T3_A08_D24_14 Sch=num[13]


set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { LED_out[6] }]; #IO_L24N_T3_A00_D16_14 Sch=ca
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { LED_out[5] }]; #IO_25_14 Sch=cb
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { LED_out[4] }]; #IO_25_15 Sch=cc
set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { LED_out[3] }]; #IO_L17P_T2_A26_15 Sch=cd
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { LED_out[2] }]; #IO_L13P_T2_MRCC_14 Sch=ce
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { LED_out[1] }]; #IO_L19P_T3_A10_D26_14 Sch=cf
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { LED_out[0] }]; #IO_L4P_T0_D04_14 Sch=cg


set_property -dict { PACKAGE_PIN J17   IOSTANDARD  LVCMOS33 } [get_ports { Anode[0] }]; #IO_L23P_T3_FOE_B_15 Sch=Anode[0]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD  LVCMOS33 } [get_ports { Anode[1] }]; #IO_L23N_T3_FWE_B_15 Sch=Anode[1]
set_property -dict { PACKAGE_PIN T9    IOSTANDARD  LVCMOS33 } [get_ports { Anode[2] }]; #IO_L24P_T3_A01_D17_14 Sch=Anode[2]
set_property -dict { PACKAGE_PIN J14   IOSTANDARD  LVCMOS33 } [get_ports { Anode[3] }]; #IO_L19P_T3_A22_15 Sch=Anode[3]