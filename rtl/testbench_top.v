`timescale 1ps/1ps

module testbench_top();
    reg CLOCK_50;
    reg [3:0] KEY;

    wire SDRAM_CLK;
    wire [11:0] DRAM_ADDR;
    wire DRAM_BA_0;
    wire DRAM_BA_1;
    wire DRAM_CAS_N;
    wire DRAM_CKE;
    wire DRAM_CS_N;
    wire [15:0] DRAM_DQ;
    wire DRAM_LDQM;
    wire DRAM_UDQM;
    wire DRAM_RAS_N;
    wire DRAM_WE_N;

	sdram_system_up_clocks_0 up_clocks_0 (
		.CLOCK_50    (CLOCK_50),                        //       clk_in_primary.clk
		.reset       (~KEY[0]), // clk_in_primary_reset.reset
		.sys_clk     (),                               //              sys_clk.clk
		.sys_reset_n (),                               //        sys_clk_reset.reset_n
		.SDRAM_CLK   (SDRAM_CLK)       //            sdram_clk.clk
	);

    altera_sdram_partner_module sdram_module (
        .clk                            (SDRAM_CLK),
        .zs_addr                        (DRAM_ADDR),
        .zs_ba                          ({DRAM_BA_1, DRAM_BA_0}),
        .zs_cas_n                       (DRAM_CAS_N),
        .zs_cke                         (DRAM_CKE),
        .zs_cs_n                        (DRAM_CS_N),
        .zs_dqm                         ({DRAM_UDQM, DRAM_LDQM}),
        .zs_ras_n                       (DRAM_RAS_N),
        .zs_we_n                        (DRAM_WE_N),
        .zs_dq                          (DRAM_DQ)
    );

    reg[21:0] address_i;
    reg[1:0] be_n_i;
    reg cs_i;
    reg[15:0] data_i;
    reg rd_n_i;
    reg wr_n_i;
    wire[15:0] data_o;
    wire valid_o;
    wire waitrequest_o;
    sdram_system_new_sdram_controller_0 sdram_controller(
        .az_addr                        (address_i),
        .az_be_n                        (be_n_i),
        .az_cs                          (cs_i),
        .az_data                        (data_i),
        .az_rd_n                        (rd_n_i),
        .az_wr_n                        (wr_n_i),
        .clk                            (SDRAM_CLK),
        .reset_n                        (KEY[0]),
        .za_data                        (data_o),
        .za_valid                       (valid_o),
        .za_waitrequest                 (waitrequest_o),
        .zs_addr                        (DRAM_ADDR),
        .zs_ba                          ({DRAM_BA_1, DRAM_BA_0}),
        .zs_cas_n                       (DRAM_CAS_N),
        .zs_cke                         (DRAM_CKE),
        .zs_cs_n                        (DRAM_CS_N),
        .zs_dq                          (DRAM_DQ),
        .zs_dqm                         ({DRAM_UDQM, DRAM_LDQM}),
        .zs_ras_n                       (DRAM_RAS_N),
        .zs_we_n                        (DRAM_WE_N)
    );

    task write_to_sdram;
        input[21:0] address;
        input[15:0] data;
        begin
            $display("Starting write of data %d to address %d at time %t...", data, address, $time);
            address_i = address;
            be_n_i = 'b00;
            cs_i = 'b1;
            data_i = data;
            wr_n_i = 'b0;
            @(posedge CLOCK_50);
            wr_n_i = 'b1;
            repeat (6)
            begin
                @(posedge CLOCK_50);
            end
            $display("Ending write at time %t.", $time);
        end
    endtask

    task read_from_sdram;
        input[21:0] address;
        begin
            $display("Starting read from address %d at time %t...", address, $time);
            address_i = address;
            be_n_i = 'b00;
            cs_i = 'b1;
            rd_n_i = 'b0;
            @(posedge CLOCK_50);
            rd_n_i = 'b1;
            @(posedge valid_o);
            $display("Read %d from address %d.", data_o, address);
            repeat (2)
            begin
                @(posedge CLOCK_50);
            end
        end
    endtask

    initial
    begin
        $dumpfile("waves.lxt");
        $dumpvars(0, testbench_top);
        // Initialize.
        CLOCK_50 = 'b0;
        KEY = 'b0000;
        #80000;
        KEY = 'b1111;
        address_i = 'b0;
        be_n_i = 'b11;
        cs_i = 'b0;
        data_i = 'b0;
        rd_n_i = 'b1;
        wr_n_i = 'b1;
        // Wait for initialization of SDRAM.
        $display("Starting wait for init_done...");
        @(posedge sdram_controller.init_done);
        $display("Ended wait for init_done.");
        repeat (20)
        begin
            @(posedge CLOCK_50);
        end
        // Write.
        write_to_sdram('d0, 'd54);
        write_to_sdram('d1, 'd55);
        write_to_sdram('d2, 'd56);
        // Read.
        read_from_sdram('d0);
        read_from_sdram('d1);
        read_from_sdram('d2);
        $stop;
    end
    always
    begin
        CLOCK_50 = #20000 ~CLOCK_50;
    end
endmodule
