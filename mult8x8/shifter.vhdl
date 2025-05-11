--!
--! @file shifter.vhdl
--! @author Emanuel S Araldi
--! @brief Simple n-bit shifter
--! @version 0.2
--! @date 2025-04-15
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter is
    generic(
        SIZE : INTEGER := 8             --! Amount of bits on input
    );
    port(
        input       : in  unsigned(SIZE - 1 downto 0); --! Value to be shifted
        shift_cntrl : in  std_logic_vector(1 downto 0); --! Selects by how much 'input' is shifted
        shift_out   : out unsigned(2 * SIZE - 1 downto 0) --! Output
    );
    --!
    --! shift_cntrl does not shift input if equal to 0 or 3, only pads with zeros to the left
    --! shift_cntrl = 1 shifts left by 4
    --! shift_cntrl = 2 shifts left by 8
    --!
end entity shifter;

architecture RTL of shifter is

begin
    shft_ctl : process(shift_cntrl, input)
    begin
        shift_out                    <= (others => '0');
        shift_out(SIZE - 1 downto 0) <= input; -- default case (0 or 3)

        if shift_cntrl = "01" then      -- Shift 4 bits
            shift_out                        <= (others => '0');
            shift_out(SIZE - 1 + 4 downto 4) <= input;
        elsif shift_cntrl = "10" then   -- Shift 8 bits
            shift_out                        <= (others => '0');
            shift_out(SIZE - 1 + 8 downto 8) <= input;
        end if;
    end process;

end architecture RTL;
