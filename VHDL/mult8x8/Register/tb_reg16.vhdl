--!
--! @file tb_reg16.vhdl
--! @author Emanuel S Araldi
--! @brief Testbench for a 16-bit register
--! @version 0.2
--! @date 2025-03-29
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_reg16 is
end entity tb_reg16;

architecture RTL of tb_reg16 is
    signal tb_clk     : std_logic;      --! Clock
    signal tb_sclr_n  : std_logic;      --! Limpa Saída (Prioridade Máxima)
    signal tb_clk_ena : std_logic;      --! Ativa clock em alto
    signal tb_datain  : unsigned(15 downto 0); --! Input
    signal tb_reg_out : unsigned(15 downto 0); --! Output
begin

    dut : entity work.reg16
        port map(
            clk     => tb_clk,
            sclr_n  => tb_sclr_n,
            clk_ena => tb_clk_ena,
            datain  => tb_datain,
            reg_out => tb_reg_out
        );

    pclk : process                      --! Update clock
    begin
        tb_clk <= '1';
        wait for 25 ns;
        tb_clk <= '0';
        wait for 25 ns;
    end process;

    pclr : process                      --! Update clear
    begin
        tb_sclr_n <= '0';
        wait for 500 ns;
        tb_sclr_n <= '1';
        wait for 500 ns;
    end process;

    pclken : process                    --! Update clock enable
    begin
        tb_clk_ena <= '1';
        wait for 270 ns;
        tb_clk_ena <= '0';
        wait for 270 ns;
    end process;

    pin : process                       --! Update input
    begin
        for i in 0 to 30 loop
            tb_datain <= to_unsigned(i, 16);
            wait for 20 ns;
        end loop;
    end process;

end architecture RTL;
