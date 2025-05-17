library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_bench is
end test_bench;

architecture Test of test_bench is
    -- Inputs
    signal tb_clk            : std_logic;
    signal tb_reset_a        : std_logic;
    signal tb_start          : std_logic;
    signal tb_dataa          : unsigned(7 downto 0);
    signal tb_datab          : unsigned(7 downto 0);
    -- Outputs
    signal tb_done_flag      : std_logic;
    signal tb_product8x8_out : unsigned(15 downto 0);
    signal tb_seg_a          : std_logic;
    signal tb_seg_b          : std_logic;
    signal tb_seg_c          : std_logic;
    signal tb_seg_d          : std_logic;
    signal tb_seg_e          : std_logic;
    signal tb_seg_f          : std_logic;
    signal tb_seg_g          : std_logic;
    signal tb_seg_dp         : std_logic;
begin

    dut : entity work.mult8x8
        port map(
            clk            => tb_clk,
            reset_a        => tb_reset_a,
            start          => tb_start,
            dataa          => tb_dataa,
            datab          => tb_datab,
            done_flag      => tb_done_flag,
            product8x8_out => tb_product8x8_out,
            seg_a          => tb_seg_a,
            seg_b          => tb_seg_b,
            seg_c          => tb_seg_c,
            seg_d          => tb_seg_d,
            seg_e          => tb_seg_e,
            seg_f          => tb_seg_f,
            seg_g          => tb_seg_g,
            seg_dp         => tb_seg_dp
        );

    clk : process
    begin
        tb_clk <= '0';
        wait for 25 ns;
        tb_clk <= '1';
        wait for 25 ns;
    end process;

    rst : process
    begin
        tb_reset_a <= '0';
        wait for 500 ns;
        tb_reset_a <= '1';
        wait for 12 ns;
    end process;

    strt : process
    begin
        tb_start <= '0';
        wait for 10 ns;
        tb_start <= '1';
        wait for 50 ns;
        tb_start <= '0';
        wait for 325 ns;
    end process;

    data : process                      --! Update dataa_tb
    begin
        for i in 5 to 20 loop
            tb_dataa <= to_unsigned(32, 8);
            wait for 250 ns;
        end loop;
    end process data;

    datb : process                      --! Update datab_tb
    begin
        for i in 5 to 20 loop
            tb_datab <= to_unsigned(32, 8);
            wait for 250 ns;
        end loop;
    end process datb;

end architecture Test;
