library verilog;
use verilog.vl_types.all;
entity sdram_system_up_clocks_0 is
    port(
        CLOCK_50        : in     vl_logic;
        reset           : in     vl_logic;
        SDRAM_CLK       : out    vl_logic;
        sys_clk         : out    vl_logic;
        sys_reset_n     : out    vl_logic
    );
end sdram_system_up_clocks_0;
