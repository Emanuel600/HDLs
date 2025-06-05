library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Package
use work.seven_segment.all;

entity test_bench is
end test_bench;

architecture Test of test_bench is

    signal count : unsigned(15 downto 0) := "0000000000000000";
    signal sev_seg0 : seven_seg;
    signal sev_seg1 : seven_seg;
    signal sev_seg2 : seven_seg;
    signal sev_seg3 : seven_seg;

begin

    incr : process
    begin
        count <= count + x"1A21";
        wait for 500 ns;
    end process;

    conv : process(count)
    begin
        (sev_seg0, sev_seg1, sev_seg2, sev_seg3) <= register_to_seven_segment(count);
    end process;
    
end architecture Test;
