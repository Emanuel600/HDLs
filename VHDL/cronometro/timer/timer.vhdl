library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.data_structs.all;

entity timer is
    port(
        clk : in std_logic; --! Clock 1 kHz
        rst : in std_logic; --! Async Reset
        FSM : in FSM_Out_Ports; --! Clock enable and store partial signal
        absolute : out unsigned(15 downto 0) := x"0000"; --! Absolute time
        partial : out unsigned(15 downto 0) := x"0000" --! Partial time
    );
end entity timer;

architecture RTL of timer is
    signal absolute_signal : unsigned(15 downto 0) := x"0000";
    signal partial_signal : unsigned(15 downto 0) := x"0000";
begin
    count : process(clk, rst) is
    begin
        if rst = '1' then
            absolute_signal <= x"0000";
        elsif rising_edge(clk) then
            if FSM.enable = '1' then
                absolute_signal <= absolute_signal + 1;
            end if;
        end if;
    end process;

    part : process(FSM.partial) is
    -- LS complains of incomplete sensitivity list, but adding partial_signal predictably makes simulation very slow
    begin
        if rst = '1' then
            partial_signal <= x"0000";
        elsif FSM.partial = '1' then
            partial_signal <= absolute_signal - partial_signal;
        end if;
    end process;

    assign : process(absolute_signal, partial_signal) is
    begin
        absolute <= absolute_signal;
        partial  <= partial_signal;
    end process;
    
end architecture RTL;
