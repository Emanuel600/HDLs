library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Package
use work.seven_segment.all;

entity test_bench is
end test_bench;

architecture Test of test_bench is

    signal count : unsigned(3 downto 0) := "1111";
    signal sev_seg : seven_seg;

begin

    incr : process
    begin
        count <= count + 1;
        wait for 500 ns;
    end process;

    conv : process(count)
    begin
        sev_seg <= to_seven_segment(count);
    end process;
    
end architecture Test;
