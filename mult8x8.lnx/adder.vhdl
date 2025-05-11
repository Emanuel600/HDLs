--!
--! @file adder.vhdl
--! @author Emanuel S Araldi
--! @brief Adds two n-bit numbers together
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
--! @param SIZE     GENERIC constant, in/output size
--!
--! @param dataa    *SIZE*-bit Input, unsigned number
--! @param datab    *SIZE*-bit Input, unsigned number
--! @param sum      *SIZE*-bit Output, unsigned number equals a+b
--!

entity adder is
    generic(
        SIZE : INTEGER := 16            --!< Tamanho definido aqui para facilitar futuras alterações >
    );

    port(
        dataa, datab    : in  UNSIGNED(SIZE - 1 downto 0); --!< Vetores de entrada com *SIZE* bits >
        sum             : out UNSIGNED(SIZE - 1 downto 0) --!< Vetor de saída com *SIZE* bits >
    );
end entity adder;

architecture math of adder is

begin
    sum <= dataa + datab;

end architecture math;
