--!
--! @file adder.vhdl
--! @author Emanuel S Araldi
--! @brief Adds two n-bit numbers together
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
end entity testbench_adder;

--! @brief          Arquitetura de teste, executa um processo para verificar saída
--!
--! @param dataa_tb (in)  Uma das variáveis a serem somadas
--! @param datab_tb (in)  Uma das variáveis a serem somadas
--! @param sum_tb   (out) Soma de dataa e datab
architecture stimulus of testbench_adder is
    constant N : integer := 16;

    signal dataa_tb : UNSIGNED(N - 1 downto 0) := to_unsigned(0, N);
    signal datab_tb : UNSIGNED(N - 1 downto 0) := to_unsigned(0, N);
    signal sum_tb   : UNSIGNED(N - 1 downto 0) := to_unsigned(0, N);

begin
    dut : entity work.adder
        generic map(
            SIZE => N
        )
        port map(
            dataa => dataa_tb,
            datab => datab_tb,
            sum   => sum_tb
        );

    data : process                      --! Update dataa_tb
    begin
        for i in 5 to 20 loop
            dataa_tb <= to_unsigned(i, N);
            wait for 25 ns;
        end loop;
    end process data;

    datb : process                      --! Update datab_tb
    begin
        for i in 5 to 20 loop
            datab_tb <= to_unsigned(15 - i, N);
            wait for 35 ns;
        end loop;
    end process datb;

end architecture stimulus;
