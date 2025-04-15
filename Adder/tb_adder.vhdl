--!
--! @file adder.vhdl
--! @author Emanuel S Araldi
--! @brief Adds two 8-bit numbers together
--! @version 0.2
--! @date 2025-04-15
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! @brief Testbench de somador simples sem carry
--!
--! @param SIZE     GENERIC constant, in/output size
--!
--! @param dataa    *SIZE*-bit Input, unsigned number
--! @param datab    *SIZE*-bit Input, unsigned number
--! @param sum      *SIZE*-bit Output, unsigned number equals a+b
--!

entity testbench_adder is
    generic(
        SIZE : INTEGER := 16            --!< Tamanho definido aqui para facilitar futuras alterações >
    );
end entity testbench_adder;

--! @brief          Arquitetura de teste, executa um processo para verificar saída
--!
--! @param dataa_tb (in)  Uma das variáveis a serem somadas
--! @param datab_tb (in)  Uma das variáveis a serem somadas
--! @param sum_tb   (out) Soma de dataa e datab
architecture stimulus of testbench_adder is

    signal dataa_tb : UNSIGNED(SIZE - 1 downto 0) := to_unsigned(0, SIZE);
    signal datab_tb : UNSIGNED(SIZE - 1 downto 0) := to_unsigned(0, SIZE);
    signal sum_tb   : UNSIGNED(SIZE - 1 downto 0) := to_unsigned(0, SIZE);

begin
    process
    begin
        for i in 20 to 30 loop
            dataa_tb <= to_unsigned(i, SIZE);
            for j in 15 to 20 loop
                datab_tb <= to_unsigned(20 - j, SIZE);
                wait for 0 ns;          --< 'sum_tb' updates next cycle otherwise
                sum_tb   <= dataa_tb + datab_tb;
                wait for 50 ns;
            end loop;
        end loop;
    end process;
end architecture stimulus;
