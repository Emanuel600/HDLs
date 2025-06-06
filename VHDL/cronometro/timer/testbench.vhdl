library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.data_structs.all;

entity test_bench is
end test_bench;

architecture Test of test_bench is

    signal tb_clk   : std_logic;
    signal tb_rst   : std_logic := '0';
    signal tb_FSM   : FSM_Out_Ports;
    signal tb_absolute  : unsigned(15 downto 0);
    signal tb_partial   : unsigned(15 downto 0);

begin
    dut : entity work.timer
        port map(
            clk      => tb_clk,
            rst      => tb_rst,
            FSM      => tb_FSM,
            absolute => tb_absolute,
            partial  => tb_partial
        );
    
    clk : process is
    begin
        tb_clk <= '0';
        wait for 500 us;
        tb_clk <= '1';
        wait for 500 us;
    end process;

    tb_FSM.enable <= '1', '0' after 10 ms;
    tb_FSM.partial <= '0', '1' after 2.5 ms, '0' after 3.5 ms, '1' after 6.5 ms, '0' after 7.5 ms;
    
end architecture Test;
