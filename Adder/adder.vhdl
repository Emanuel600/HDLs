--!
--! @file main.cpp
--! @author Emanuel S Araldi
--! @brief Adds two 8-bit numbers together
--! @version 0.1
--! @date 2025-03-29
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! @brief Somador simples sem carry
--!
--! @port in a:
entity adder is
    port(
        a, b : in std_logic_vector(7 downto 0); --!< Vetores de entrada com 8 bits
        s    : out std_logic_vector(7 downto 0) --!< Vetor de saída com 8 bits
    );
end entity adder;

architecture math of adder is

begin
    s <= a + b;

end architecture math;
