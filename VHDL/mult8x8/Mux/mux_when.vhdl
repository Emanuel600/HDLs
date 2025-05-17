--!
--! @file mux.vhdl
--! @author Emanuel S Araldi
--! @brief Simple SIZE-bit multiplexer
--! @version 0.2
--! @date 2025-04-15
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_when is
    generic(
        SIZE : INTEGER := 4             --! < Tamanho das entradas
    );
    port(
        mux_in_a, mux_in_b : in  UNSIGNED(SIZE - 1 downto 0); --! < Entradas do Multiplexador
        mux_sel            : in  std_logic; --! < Porta p/ Selecionar Entrada
        mux_out            : out UNSIGNED(SIZE - 1 downto 0) --! < Saída
    );
end entity mux_when;

architecture RTL of mux_when is
begin
    mux_out <= mux_in_a when mux_sel = '0' else
               mux_in_b;
end architecture RTL;
