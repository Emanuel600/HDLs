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

entity mux is
    generic(
        SIZE : INTEGER := 4 --! < Tamanho das entradas
        );
    port(
        mux_in_a, mux_in_b  : in  UNSIGNED(SIZE-1 downto 0);    --! < Entradas do Multiplexador
        mux_sel             : in  std_logic;                    --! < Porta p/ Selecionar Entrada
        mux_out             : out UNSIGNED(SIZE-1 downto 0)     --! < Saída
    );
end entity mux;

architecture RTL of mux is
begin
    with mux_sel select
    mux_out <=  mux_in_a when '0',
                mux_in_b when others;
end architecture RTL;
