--!
--! @file tb_mult.vhdl
--! @author Emanuel S Araldi
--! @brief Testbench - Multiplies two n bit numbers together
--! @version 0.2
--! @date 2025-04-15
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_mult is
end entity testbench_mult;

--! @brief              Arquitetura de teste, executa um processo para verificar saída
--!
--! @param dataa_tb     (in)  Uma das variáveis a serem multiplicadas
--! @param datab_tb     (in)  Uma das variáveis a serem multiplicadas
--! @param product_tb   (out) Soma de dataa e datab
architecture stimulus of testbench_mult is

    constant N : integer := 8;

    signal dataa_tb   : UNSIGNED(N - 1 downto 0);
    signal datab_tb   : UNSIGNED(N - 1 downto 0);
    signal product_tb : UNSIGNED(2 * N - 1 downto 0);

begin
    dut : entity work.mult
        generic map(
            SIZE => N
        )
        port map(
            dataa   => dataa_tb,
            datab   => datab_tb,
            product => product_tb
        );
    dat_a : process                     --! Updates dataa_tb
    begin
        for i in 5 to 41 loop
            dataa_tb <= to_unsigned(i, N);
            wait for 25 ns;
        end loop;
    end process;
    dat_b : process                     --! Updates datab_tb
    begin
        for i in 12 to 45 loop
            datab_tb <= to_unsigned(45 - i, N);
            wait for 28 ns;
        end loop;
    end process;

end architecture stimulus;
