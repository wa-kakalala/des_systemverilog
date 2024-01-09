create_clock -name clkin -period 10.000 [get_ports clk_in]

set_property PACKAGE_PIN M19       [get_ports clk_in]
set_property IOSTANDARD LVCMOS33   [get_ports clk_in]

set_property PACKAGE_PIN AB6       [get_ports rst_n_in]
set_property IOSTANDARD LVCMOS33   [get_ports rst_n_in]

set_property PACKAGE_PIN Y4        [get_ports key_in]
set_property IOSTANDARD LVCMOS33   [get_ports key_in]

set_property PACKAGE_PIN V4        [get_ports nc]
set_property IOSTANDARD LVCMOS33   [get_ports nc]