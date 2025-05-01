--!
--! @file tb_shifter.vhdl
--! @author Emanuel S Araldi
--! @brief Simple testbench for an n bit shifter
--! @version 0.2
--! @date 2025-04-15
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_shifter is
end entity tb_shifter;

architecture Stimulus of tb_shifter is

    constant N : integer := 8;

    signal input_tb       : unsigned(N - 1 downto 0);
    signal shift_cntrl_tb : unsigned(1 downto 0);
    signal shift_out_tb   : unsigned(2 * N downto 0);

begin

    dut : entity work.shifter
        generic map(
            SIZE => N
        )
        port map(
            input       => input_tb,
            shift_cntrl => shift_cntrl_tb,
            shift_out   => shift_out_tb
        );

    inp : process                       --! Process to change input
    begin
        for i in 0 to 325 loop
            input_tb <= to_unsigned(i, N);
            wait for 43 ns;
        end loop;
    end process;

    ctl : process                       --! Process to change control
    begin
        for i in 0 to 3 loop
            shift_cntrl_tb <= to_unsigned(i, 2);
            wait for 10 ns;
        end loop;
    end process;

end architecture Stimulus;
