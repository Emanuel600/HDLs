--!
--! @file seven_segment_cntrl.vhdl
--! @author Emanuel S Araldi
--! @brief Seven Segment Controller
--! @version 0.2
--! @date 2025-04-22
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment_cntrl is
    port(
        input : in  unsigned(3 downto 0);
        segs  : out std_logic_vector(7 downto 0)
    );
end entity seven_segment_cntrl;

architecture RTL of seven_segment_cntrl is

    --   A
    -- F   B
    --   G
    -- E   C
    --   D   P
    -- segs = "PGFEDCBA", LED turns activates on '0'
begin
    process(input)
    begin
        case input is
            when "0000" => segs <= "11000000"; -- "0", ABCDEF
            when "0001" => segs <= "11111001"; -- "1", BC
            when "0010" => segs <= "10100100"; -- "2", ABDEG
            when "0011" => segs <= "10110000"; -- "3", ABCDG
            when "0100" => segs <= "10011001"; -- "4", BCFG
            when "0101" => segs <= "10010010"; -- "5", ACDFG
            when "0110" => segs <= "10000010"; -- "6", ACDEFG
            when "0111" => segs <= "11111000"; -- "7", ABC
            when "1000" => segs <= "10000000"; -- "8", ABCDEFG
            when "1001" => segs <= "10011000"; -- "9", ABCFG
            when "1010" => segs <= "10001000"; -- A  , ABCEFG
            when "1011" => segs <= "10000011"; -- b  , CDEFG
            when "1100" => segs <= "11000110"; -- C  , ADEF
            when "1101" => segs <= "10100001"; -- d  , BCDEG
            when "1110" => segs <= "10000110"; -- E  , ADEFG
            when "1111" => segs <= "10001110"; -- F  , AEFG

            when others => segs <= "01111111"; -- error
        end case;
    end process;
end architecture RTL;
