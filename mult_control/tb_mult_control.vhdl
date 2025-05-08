--!
--! @file tb_mult_control.vhdl
--! @author Emanuel S Araldi
--! @brief Logic to Control Muxes and Shifters for an 8x8 multiplier
--! @version 0.2
--! @date 2025-04-29
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mult_control is
end tb_mult_control;

entity tb_counter is
end entity tb_counter;

architecture Test of tb_mult_control is
    -- Inputs
    signal tb_clk       : std_logic;
    signal tb_reset_a   : std_logic;
    signal tb_start     : std_logic;
    signal tb_count     : unsigned(1 downto 0) := "10";
    signal tb_not_start : std_logic;    -- Inverted tb_start for 'counter'
    -- Outputs
    signal tb_input_sel : std_logic_vector(1 downto 0);
    signal tb_shift_sel : std_logic_vector(1 downto 0);
    signal tb_state_out : unsigned(2 downto 0);
    signal tb_done      : std_logic;
    signal tb_clk_ena   : std_logic;
    signal tb_sclr_n    : std_logic;
begin
    --! Entity controls Muxes and Shifter
    dut : entity work.mult_control
        port map(
            -- Inputs
            clk       => tb_clk,
            reset_a   => tb_reset_a,
            start     => tb_start,
            count     => tb_count,
            -- Outputs
            input_sel => tb_input_sel,
            shift_sel => tb_shift_sel,
            state_out => tb_state_out,
            done      => tb_done,
            clk_ena   => tb_clk_ena,
            sclr_n    => tb_sclr_n
        );
    --! Counter used to determine which cycle the fsm is currently on
    dut2 : entity work.counter
        port map(
            clk       => tb_clk,
            aclr_n    => tb_not_start,
            count_out => tb_count
        );

    nst : process(tb_start)             --! Inverts tb_start for counter
    begin
        tb_not_start <= not tb_start;
    end process;

    clk : process                       --! Generate Clock
    begin
        tb_clk <= '1';
        wait for 25 ns;
        tb_clk <= '0';
        wait for 25 ns;
    end process;

    rst : process                       --! Generate reset signal
    begin
        tb_reset_a <= '0';
        wait for 100 ns;
    end process;

    str : process                       --! Start Signal
    begin
        tb_start <= '0';
        wait for 10 ns;
        tb_start <= '1';
        wait for 50 ns;
        tb_start <= '0';
        wait for 325 ns;
    end process;

end architecture Test;
