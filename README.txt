SDRAM
By Oliver Trevor

This is a Verilog program for the Altera DE1 (Intel Cyclone II) development board that accesses the SDRAM. It requires the Intel Quartus IDE version 13.0sp1 (13.0 service pack 1), the Icarus Verilog simulator, and the GTKWave waveform viewer.

To simulate, cd to the root directory of the project (called SDRAM) and run the command "scripts/compile_for_simulation.sh". Then, run the command "scripts/simulate.sh". This will run the Icarus Verilog simulation, print out any output, then show the resulting output using GTKWave.

To synthesize the design, run the command "scripts/synth.sh" from the root directory of the project (called SDRAM).

To flash the design to an Altera DE1 connected via a USB cable, use the command "scripts/program.sh".

The /rtl folder contains all the Verilog used by the project.

The /qsys folder contains all the output from the QSys Verilog generator (part of Quartus IDE). We don't use all of these files -- the relevant ones have already been copied into /rtl.

/rtl/altera_mf.v is a copy of the file found (on Linux) under altera/13.0sp1/quartus/eda/sim_lib/altera_mf.v (where altera is the folder your Altera development tools were installed to). altera_mf.v implements the altpll module that simulates the hardware PLL on the Altera DE1 board.

/rtl/altera_sdram_partner_module.v is a simulation-only file that acts like an SDRAM module. It is used to test the SDRAM controller.

/rtl/sdram_system_new_sdram_controller_0.v is an SDRAM controller module for simulation AND synthesis.

/rtl/sdram_system_up_clocks_0.v is a module that generates clock signals, especially the SDRAM clock (which is slightly offset from the system clock to allow for latency). It uses the altpll module from /rtl/altera_mf.v. It is used in both simulation AND synthesis.

/rtl/testbench_top.rtl is a simulation-only testbench module.

/rtl/top.v is the top module, used for simulation AND synthesis.
