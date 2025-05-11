--!
--! @file mult.vhdl
--! @author Emanuel S Araldi
--! @brief Multiplies two n-bit numbers together
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

entity mult is
    generic(
        SIZE : INTEGER := 8             --!< Tamanho definido aqui para facilitar futuras alterações >
    );

    port(
        dataa, datab : in  UNSIGNED(SIZE - 1 downto 0); --!< Vetores de entrada com *SIZE* bits >
        product      : out UNSIGNED(2 * SIZE - 1 downto 0) --!< Vetor de saída com *SIZE* bits >
    );
end entity mult;

architecture math of mult is

begin
    product <= dataa * datab;

end architecture math;
