--!
--! @file main.cpp
--! @author Emanuel S Araldi
--! @brief Adds two 8-bit numbers together
--! @version 0.2
--! @date 2025-03-29
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! @brief Somador simples sem carry
--!
--! @param a        8-bit Input, unsigned number
--! @param b        8-bit Input, unsigned number
--! @param s        8-bit Output, unsigned number equals a+b
--!

entity adder is
    generic(
        SIZE : INTEGER := 8             --!< Tamanho definido aqui para facilitar futuras alterações >
    );

    port(
        a, b : in  UNSIGNED(SIZE - 1 downto 0); --!< Vetores de entrada com 8 bits >
        s    : out UNSIGNED(SIZE - 1 downto 0) --!< Vetor de saída com 8 bits >
    );
end entity adder;

architecture math of adder is

begin
    s <= a + b;

end architecture math;
