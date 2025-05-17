--!
--! @file reg16.vhdl
--! @author Emanuel S Araldi
--! @brief 16-bit register
--! @version 0.2
--! @date 2025-03-29
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16 is
    port(
        clk     : in  std_logic;        --! Clock
        sclr_n  : in  std_logic;        --! Limpa Saída (Prioridade Máxima)
        clk_ena : in  std_logic;        --! Ativa clock em alto
        datain  : in  unsigned(15 downto 0); --! Input
        reg_out : out unsigned(15 downto 0) --! Output
    );
end entity reg16;

architecture RTL of reg16 is

begin
    process(clk, sclr_n)
    begin
        if sclr_n = '0' then
            reg_out <= to_unsigned(0, 16);
        elsif rising_edge(clk) then
            if clk_ena = '1' then
                reg_out <= datain;
            end if;
        end if;
    end process;

end architecture RTL;
