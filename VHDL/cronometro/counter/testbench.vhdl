library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_bench is
end test_bench;

architecture Test of test_bench is
    signal tb_clk       : std_logic;
    signal tb_rst       : std_logic := '0';
    signal tb_enable    : std_logic := '1';
    signal tb_out_clk   : std_logic;
begin
    dut: entity work.counter
        generic map(
            top => 1000
        )
        port map(
            clk     => tb_clk,
            rst     => tb_rst,
            enable  => tb_enable,
            out_clk => tb_out_clk
        );
    
    clk : process           --! Input clock process
    begin
        tb_clk <= '0';
        wait for 500 ns;
        tb_clk <= '1';
        wait for 500 ns;
    end process;
    
end architecture Test;
