library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    generic(
        top : integer := 1000   --! Max value + 1
    );
    port(
        clk : in std_logic;     --! Input Clock
        rst : in std_logic;     --! Reset Output and Counter (Assynchronous)
        enable : in std_logic;  --! Clock Enable (Synchronous)
        out_clk: out std_logic  --! Output Clock
    );
end entity counter;

architecture RTL of counter is
    signal clk_sig : std_logic := '0';
begin
    count : process(clk, rst, clk_sig)
        variable counter : unsigned(9 downto 0);
    begin
        if rst = '1' then
            counter := to_unsigned(0, 10);
            clk_sig <= '0';
        elsif rising_edge(clk) and enable = '1' then
            if counter < (top - 1) then
                counter := counter + 1;
            else
                counter := to_unsigned(0, 10);
                clk_sig <= not clk_sig;
            end if;
        end if;
        -- Update clock
        out_clk <= clk_sig;
    end process;

end architecture RTL;
