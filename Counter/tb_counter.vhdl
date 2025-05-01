--!
--! @file adder.vhdl
--! @author Emanuel S Araldi
--! @brief Testbench for a 2 bit counter
--! @version 0.2
--! @date 2025-04-20
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_counter is
end entity tb_counter;

architecture RTL of tb_counter is

    signal tb_clk       : std_logic;    --! CLock
    signal tb_aclr_n    : std_logic;    --! Limpa Saída
    signal tb_count_out : unsigned(1 downto 0); --! Saída do Contador
begin

    dut : entity work.counter
        port map(
            clk       => tb_clk,
            aclr_n    => tb_aclr_n,
            count_out => tb_count_out
        );

    pclk : process                      --! Update clock
    begin
        tb_clk <= '1';
        wait for 25 ns;
        tb_clk <= '0';
        wait for 25 ns;
    end process;

    prst : process                      --! Update clear
    begin
        tb_aclr_n <= '0';
        wait for 500 ns;
        tb_aclr_n <= '1';
        wait for 500 ns;
    end process;

end architecture RTL;
