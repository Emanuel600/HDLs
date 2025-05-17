--!
--! @file tb_mux.vhdl
--! @author Emanuel S Araldi
--! @brief Simple testbench for an n bit multiplexer
--! @version 0.2
--! @date 2025-04-15
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mux is
end entity tb_mux;

architecture Stimulus of tb_mux is
    constant N : integer := 4;

    signal mux_in_a_tb, mux_in_b_tb : UNSIGNED(N - 1 downto 0); --! < Entradas do Multiplexador
    signal mux_sel_tb               : std_logic; --! < Porta p/ Selecionar Entrada
    signal mux_out_tb               : UNSIGNED(N - 1 downto 0); --! Mux por 'case'
    signal mux_out_when_tb          : UNSIGNED(N - 1 downto 0); --! Mux por 'when'
begin
    dut : entity work.mux               --! Mux por 'case'
        generic map(
            SIZE => N
        )
        port map(
            mux_in_a => mux_in_a_tb,
            mux_in_b => mux_in_b_tb,
            mux_sel  => mux_sel_tb,
            mux_out  => mux_out_tb
        );
    dut2 : entity work.mux_when         --! Mux por 'when'
        generic map(
            SIZE => N
        )
        port map(
            mux_in_a => mux_in_a_tb,
            mux_in_b => mux_in_b_tb,
            mux_sel  => mux_sel_tb,
            mux_out  => mux_out_when_tb
        );
    mux_a : process                     --! Update mux_in_a_tb
    begin
        for i in 0 to 16 loop
            mux_in_a_tb <= to_unsigned(i, N);
            wait for 50 ns;
        end loop;
    end process;

    mux_b : process                     --! Update mux_in_b_tb
    begin
        for i in 0 to 16 loop
            mux_in_b_tb <= to_unsigned(16 - i, N);
            wait for 35 ns;
        end loop;
    end process;

    mux_sel : process                   --! Update mux_sel_tb
    begin
        mux_sel_tb <= '0';
        wait for 25 ns;
        mux_sel_tb <= '1';
        wait for 25 ns;
    end process;

end architecture Stimulus;
