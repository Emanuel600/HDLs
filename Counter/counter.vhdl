--!
--! @file adder.vhdl
--! @author Emanuel S Araldi
--! @brief 2 bit counter
--! @version 0.2
--! @date 2025-04-20
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port(
        clk       : in  std_logic;      --! CLock
        aclr_n    : in  std_logic;      --! Limpa Saída
        count_out : out unsigned(1 downto 0) --! Saída do Contador
    );
end entity counter;

architecture RTL of counter is
    signal counter : unsigned(1 downto 0) := "00"; --! Armazena Valor da Saída
begin
    process(clk, aclr_n)
    begin
        if aclr_n = '1' then
            counter <= "00";
        elsif rising_edge(clk) then
            counter <= counter + 1;
        end if;
    end process;
    count_out <= counter;
end architecture RTL;
