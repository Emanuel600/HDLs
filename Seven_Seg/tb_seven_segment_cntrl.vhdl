--!
--! @file seven_segment_cntrl.vhdl
--! @author Emanuel S Araldi
--! @brief Testbench for a Seven Segment Controller
--! @version 0.2
--! @date 2025-04-22
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_seven_segment_cntrl is
end entity tb_seven_segment_cntrl;

architecture Stimulus of tb_seven_segment_cntrl is

    signal tb_input : unsigned(3 downto 0) := "0000";
    signal tb_segs  : std_logic_vector(7 downto 0);

begin

    dut : entity work.seven_segment_cntrl
        port map(
            input => tb_input,
            segs  => tb_segs
        );
    inc : process                       --! update input
    begin
        for i in 0 to 16 loop
            tb_input <= to_unsigned(i, 4);
            wait for 25 ns;
        end loop;
    end process;

end architecture Stimulus;
