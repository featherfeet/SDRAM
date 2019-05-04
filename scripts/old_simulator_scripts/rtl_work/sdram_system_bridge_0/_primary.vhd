library verilog;
use verilog.vl_types.all;
entity sdram_system_bridge_0 is
    generic(
        AW              : integer := 22;
        DW              : integer := 15;
        BW              : integer := 1
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        avalon_readdata : in     vl_logic_vector;
        avalon_waitrequest: in     vl_logic;
        address         : in     vl_logic_vector;
        byte_enable     : in     vl_logic_vector;
        read            : in     vl_logic;
        write           : in     vl_logic;
        write_data      : in     vl_logic_vector;
        avalon_address  : out    vl_logic_vector;
        avalon_byteenable: out    vl_logic_vector;
        avalon_read     : out    vl_logic;
        avalon_write    : out    vl_logic;
        avalon_writedata: out    vl_logic_vector;
        acknowledge     : out    vl_logic;
        read_data       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of AW : constant is 1;
    attribute mti_svvh_generic_type of DW : constant is 1;
    attribute mti_svvh_generic_type of BW : constant is 1;
end sdram_system_bridge_0;
