vlib rtl_work

vlog -vlog01compat -work rtl_work ../rtl/altera_sdram_partner_module.v
vlog -vlog01compat -work rtl_work ../rtl/sdram_system_new_sdram_controller_0.v
vlog -vlog01compat -work rtl_work ../rtl/sdram_system_up_clocks_0.v
vlog -vlog01compat -work rtl_work ../rtl/testbench_top.v

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -voptargs="+acc" rtl_work.testbench_top

log -r *
add wave *
view structure
view signals
run 201580ns
