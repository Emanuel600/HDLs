library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package seven_segment is

    subtype seven_seg is std_logic_vector(7 downto 0);					--! Convenience type for  seven segment std arrays
    function to_seven_segment(num : unsigned(3 downto 0)) return seven_seg;		--! Convert nibble to Seven Segment Vector
    type nib2sev is array (0 to 15) of seven_seg;					--! Store `nibble to seven segment` Convertion Table
    type reg_seven_seg is array (0 to 3) of seven_seg;					--! 4 Seven Segment Displays for one 16-bit register
    function register_to_seven_segment(num : unsigned(15 downto 0)) return reg_seven_seg;	--! Convert value in 16-bit register to 4 Seven Segment Displays

end package seven_segment;

package body seven_segment is
    function to_seven_segment(num : unsigned(3 downto 0)) return seven_seg is
        
        constant conversion_table : nib2sev := (
            -- First value is the decimal point
            0  => "11000000",
            1  => "11111001",
            2  => "10100100",
            3  => "10110000",
            4  => "10011001",
            5  => "10010010",
            6  => "10000010",
            7  => "11111000",
            8  => "10000000",
            9  => "10011000",
            10 => "10001000",
            11 => "10000011",
            12 => "11000110",
            13 => "10100001",
            14 => "10000110",
            15 => "10001110"
        );

    begin
        return conversion_table(to_integer(num));
    
    end to_seven_segment;

    function register_to_seven_segment(num : UNSIGNED(15 downto 0)) return reg_seven_seg is
    -- Simple array to make assignement easier
    variable reg_table : reg_seven_seg := (
        0 => "11111111",
        1 => "11111111",
        2 => "11111111",
        3 => "11111111"
    );

    begin
        reg_table(0) := to_seven_segment(num(3 downto 0));
        reg_table(1) := to_seven_segment(num(7 downto 4));
        reg_table(2) := to_seven_segment(num(11 downto 8));
        reg_table(3) := to_seven_segment(num(15 downto 12));

        return reg_table;

    end register_to_seven_segment;
    
end package body seven_segment;
