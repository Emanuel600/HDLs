library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package seven_segment is
    
    subtype seven_seg is std_logic_vector(7 downto 0);
    function to_seven_segment(num : unsigned(3 downto 0)) return seven_seg;
    type nib2sev is array (0 to 15) of seven_seg;

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
end package body seven_segment;
