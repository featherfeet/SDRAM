library verilog;
use verilog.vl_types.all;
entity sdram_system is
    port(
        clk_clk         : in     vl_logic;
        reset_reset_n   : in     vl_logic;
        sdram_controller_pins_addr: out    vl_logic_vector(11 downto 0);
        sdram_controller_pins_ba: out    vl_logic_vector(1 downto 0);
        sdram_controller_pins_cas_n: out    vl_logic;
        sdram_controller_pins_cke: out    vl_logic;
        sdram_controller_pins_cs_n: out    vl_logic;
        sdram_controller_pins_dq: inout  vl_logic_vector(15 downto 0);
        sdram_controller_pins_dqm: out    vl_logic_vector(1 downto 0);
        sdram_controller_pins_ras_n: out    vl_logic;
        sdram_controller_pins_we_n: out    vl_logic;
        avalon_bridge_pins_address: in     vl_logic_vector(22 downto 0);
        avalon_bridge_pins_byte_enable: in     vl_logic_vector(1 downto 0);
        avalon_bridge_pins_read: in     vl_logic;
        avalon_bridge_pins_write: in     vl_logic;
        avalon_bridge_pins_write_data: in     vl_logic_vector(15 downto 0);
        avalon_bridge_pins_acknowledge: out    vl_logic;
        avalon_bridge_pins_read_data: out    vl_logic_vector(15 downto 0)
    );
end sdram_system;
